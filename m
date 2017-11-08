Received: from eggs.gnu.org ([2001:4830:134:3::10]:52922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCKGC-0007tA-Fs
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCKGB-0001Ut-IK
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:54:52 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:50149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eCKGB-0001Ul-DX
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:54:51 -0500
Received: by mail-ua0-x231.google.com with SMTP id u13so194201uaf.6
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 22:54:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171107165339.GB3111@localhost.localdomain>
References: <CAJ+F1CKWdxAwuZ-QAvT=AhGMrXd+7c8=eBCMMuKPdbK75NDtiQ@mail.gmail.com>
	<20171107165339.GB3111@localhost.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Nov 2017 07:54:50 +0100
Message-ID: <CAJ+F1CKpNUq6f5gTeBUSYkTRj_b9Nc9R4rGx6x_UrNMDk8ePBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] i440/piix and dynamic sysbus check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi Eduardo

On Tue, Nov 7, 2017 at 5:53 PM, Eduardo Habkost <ehabkost@redhat.com> wrote=
:
> On Tue, Nov 07, 2017 at 05:40:17PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> Hi,
>>
>> I am working on a TPM CRB device (last sent version:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02014.html).
>> It's a sysbus device, and when starting qemu with i440, I get "Option
>> '-device tpm-crb' cannot be handled by this machine".
>>
>> The check comes from machine_init_notify(), checking that the machine
>> has_dynamic_sysbus.
>>
>>  Apparently, q35 supports it. But not i440. If I declare
>> has_dynamic_sysbus in piix, the device works fine.
>
> Before doing that, I would like to replace has_dynamic_sysbus
> with a whitelist, so we don't need to make the machine accept all
> other sysbus devices too.
>
> I probably should rebase and resubmit this RFC:
> http://mid.mail-archive.com/20170323212848.8492-1-ehabkost@redhat.com
> Subject: [Qemu-devel] [RFC 0/4] Replace has_dynamic_sysbus with device ty=
pe  whitelist

Looks good. I'll assume the problem will be eventually resolved after
your series. Looking forward to it.

Thanks




--=20
Marc-Andr=C3=A9 Lureau
