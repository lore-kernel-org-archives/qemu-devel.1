Received: from eggs.gnu.org ([2001:4830:134:3::10]:42297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eF1kE-0006bD-BA
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 12:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eF1kD-00023D-DE
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 12:45:02 -0500
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:42110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gandalf.corvotempesta@gmail.com>)
	id 1eF1kD-00022i-7R
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 12:45:01 -0500
Received: by mail-it0-x229.google.com with SMTP id n134so2693401itg.1
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 09:45:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date: Wed, 15 Nov 2017 18:44:59 +0100
Message-ID: <CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

XVA is a tar archive.
I don't think would be possible to directly use the image stored inside
without extracting and merging each chunks

Any random reads would be impossible to do, only a huge sequential dump to
build the raw image

Il 15 nov 2017 6:33 PM, "Eric Blake" <eblake@redhat.com> ha scritto:

[adding libguestfs]

On 11/15/2017 09:52 AM, Gandalf Corvotempesta wrote:
> I'm thinking if support for XVA files could be added to qemu-img
> The file-format is well known (it's just a tar archive) and there are
scripts
> that are able to convert an XVA file to a RAW image. (ie:
> https://gist.github.com/miebach/0433947bcf053de23159)
>
> Running these script on their own is very time consuming, as you have to
> extract the XVA, convert any disk image from "single chunks" to a raw
image
> and then use qemu-img to convert from raw to qcow.
>
> Maybe a native support will be able to skip some steps. (like the
> conversion from
> "single chunks" to raw and raw to qcow2)

Another possibility might be writing an nbdkit plugin that can directly
read XVA, then you can connect qemu to the NBD server provided by
nbdkit, without having to teach qemu proper how to read the file.

--
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
