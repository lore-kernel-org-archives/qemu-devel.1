Received: from eggs.gnu.org ([2001:4830:134:3::10]:39401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eEzzo-0002C4-BO
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eEzzn-00005s-F3
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:53:00 -0500
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:45803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gandalf.corvotempesta@gmail.com>)
	id 1eEzzn-0008Vq-Ac
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:52:59 -0500
Received: by mail-io0-x22a.google.com with SMTP id z74so2010963iof.12
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 07:52:58 -0800 (PST)
MIME-Version: 1.0
From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date: Wed, 15 Nov 2017 16:52:56 +0100
Message-ID: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm thinking if support for XVA files could be added to qemu-img
The file-format is well known (it's just a tar archive) and there are scripts
that are able to convert an XVA file to a RAW image. (ie:
https://gist.github.com/miebach/0433947bcf053de23159)

Running these script on their own is very time consuming, as you have to
extract the XVA, convert any disk image from "single chunks" to a raw image
and then use qemu-img to convert from raw to qcow.

Maybe a native support will be able to skip some steps. (like the
conversion from
"single chunks" to raw and raw to qcow2)
