Received: from eggs.gnu.org ([2001:4830:134:3::10]:37079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eC6vE-0005nq-Up
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eC6vD-0007ts-Sf
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:40:20 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:47062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eC6vD-0007tH-Jk
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:40:19 -0500
Received: by mail-vk0-x231.google.com with SMTP id k123so8388442vkb.3
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 08:40:19 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Nov 2017 17:40:17 +0100
Message-ID: <CAJ+F1CKWdxAwuZ-QAvT=AhGMrXd+7c8=eBCMMuKPdbK75NDtiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] i440/piix and dynamic sysbus check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi,

I am working on a TPM CRB device (last sent version:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02014.html).
It's a sysbus device, and when starting qemu with i440, I get "Option
'-device tpm-crb' cannot be handled by this machine".

The check comes from machine_init_notify(), checking that the machine
has_dynamic_sysbus.

 Apparently, q35 supports it. But not i440. If I declare
has_dynamic_sysbus in piix, the device works fine.

Marcel, could we do something similar to piix to what you did for q35?:

commit bf8d492405feaee2c1685b3b9d5e03228ed3e47f
Author: Marcel Apfelbaum <marcel@redhat.com>
Date:   Mon Jun 27 18:38:33 2016 +0300

    q35: allow dynamic sysbus

thanks

--=20
Marc-Andr=C3=A9 Lureau
