Received: from eggs.gnu.org ([2001:4830:134:3::10]:44371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhcDV-0006dU-5T
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhcDS-0002ZX-3S
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:49:09 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dhcDR-0002Yv-Ua
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:49:06 -0400
Received: by mail-io0-x241.google.com with SMTP id m88so630968iod.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:49:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170815083822.GB9674@redhat.com>
Date: Tue, 15 Aug 2017 09:49:00 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <85B66A0C-33EF-4DF8-8137-ECCA251A0F2D@gmail.com>
References: <695CE828-CE3F-48D0-B20E-7B88C76453B8@gmail.com>
	<20170815083822.GB9674@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>


> On Aug 15, 2017, at 4:38 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Mon, Aug 14, 2017 at 02:46:22PM -0400, Programmingkid wrote:
>> Sorry but there appears to be an issue with your patchset. I ran this =
command:
>>=20
>> ./configure --target-list=3Dppc-softmmu,i386-softmmu
>>=20
>> Then saw this error message:=20
>>=20
>> error: pathspec 'ui/keycodemapdb' did not match any file(s) known to =
git.
>>=20
>> Running 'make' I saw this error message:
>>=20
>> make: *** No rule to make target `ui/input-keymap-atset1-to-qcode.c', =
needed by `Makefile'.  Stop.
>> make: *** Waiting for unfinished jobs....
>>=20
>> Running the 'make clean' command produces this error message:
>>=20
>> make[1]: *** No rule to make target =
`ui/input-keymap-atset1-to-qcode.c', needed by `Makefile'.  Stop.
>> make: *** [clean] Error 1
>>=20
>> Perhaps a missing patch?
>=20
> No, its a missing "git submodule update --init ui/keycodemapdb" call

Thank you for replying. I tried this command and saw this error message:

error: pathspec 'ui/keycodemapdb' did not match any file(s) known to =
git.

Note: I'm using version 3. Will test version 4 soon.=20

I suggest adding the git submodule update info to your cover letter =
saying it is required.=20=
