Received: from eggs.gnu.org ([2001:4830:134:3::10]:49062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e8z25-0001bB-JM
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 21:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e8z22-0001dL-GQ
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 21:38:29 -0400
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:54002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1e8z22-0001d9-B8
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 21:38:26 -0400
Received: by mail-io0-x235.google.com with SMTP id 189so23726304iow.10
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 18:38:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171029102106.GA2841@work-vm>
Date: Sun, 29 Oct 2017 21:38:22 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <847196B3-8C4D-4B8E-A6A4-5ADAEC73FF62@gmail.com>
References: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
	<38c3125f-b050-c0ba-282f-bc1e9e11d297@redhat.com>
	<20171029102106.GA2841@work-vm>
Subject: Re: [Qemu-devel] drive_add: file names with spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Oct 29, 2017, at 6:21 AM, Dr. David Alan Gilbert =
<dgilbert@redhat.com> wrote:
>=20
> * Eric Blake (eblake@redhat.com) wrote:
>> On 10/28/2017 06:44 AM, Programmingkid wrote:
>>> I'm trying to use an image file that has spaces in its file name =
(and sometimes in the path) to be used as a USB flash drive. When I try =
adding the image file using the drive_add command I see this error: =
drive_add: extraneous characters at the end of the line
>>>=20
>>> I have tried using single and double quotes around the file name but =
this does not help. Is there a way to use files that have spaces in it's =
name with drive_add?
>>=20
>> Not in HMP, which lacks quoting.  (Unless you want to patch HMP to =
learn
>> quoting)
>=20
> I think it's already got that code at least in some places.
> monitor_parse_arguments calls get_str, and get_str understands " =
wrapped
> arguments.
>=20
> drive_add 1 "file=3Dfoo bar"
>=20
> gives me:
> Could not open 'foo bar': No such file or directory
>=20
> so I think that's doing the right thing.
>=20
> Dave
>=20
>> But using spaces in filenames works fine in QMP.
>>=20
>> --=20
>> Eric Blake, Principal Software Engineer
>> Red Hat, Inc.           +1-919-301-3266
>> Virtualization:  qemu.org | libvirt.org
>>=20
>=20
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Thank you so much for this info. It solved my problem :)
