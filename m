Received: from eggs.gnu.org ([2001:4830:134:3::10]:57918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhd4n-0006B4-GE
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhd4j-0004ci-FD
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:44:13 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dhd4j-0004cN-AL
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:44:09 -0400
Received: by mail-io0-x242.google.com with SMTP id j32so711391iod.3
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 07:44:09 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170815134945.GM9674@redhat.com>
Date: Tue, 15 Aug 2017 10:44:07 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C886DE0-FFF9-4C88-BC59-2FA9ED26BB14@gmail.com>
References: <695CE828-CE3F-48D0-B20E-7B88C76453B8@gmail.com>
	<20170815083822.GB9674@redhat.com>
	<85B66A0C-33EF-4DF8-8137-ECCA251A0F2D@gmail.com>
	<20170815134945.GM9674@redhat.com>
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


> On Aug 15, 2017, at 9:49 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Tue, Aug 15, 2017 at 09:49:00AM -0400, Programmingkid wrote:
>>=20
>>> On Aug 15, 2017, at 4:38 AM, Daniel P. Berrange =
<berrange@redhat.com> wrote:
>>>=20
>>> On Mon, Aug 14, 2017 at 02:46:22PM -0400, Programmingkid wrote:
>>>> Sorry but there appears to be an issue with your patchset. I ran =
this command:
>>>>=20
>>>> ./configure --target-list=3Dppc-softmmu,i386-softmmu
>>>>=20
>>>> Then saw this error message:=20
>>>>=20
>>>> error: pathspec 'ui/keycodemapdb' did not match any file(s) known =
to git.
>>>>=20
>>>> Running 'make' I saw this error message:
>>>>=20
>>>> make: *** No rule to make target =
`ui/input-keymap-atset1-to-qcode.c', needed by `Makefile'.  Stop.
>>>> make: *** Waiting for unfinished jobs....
>>>>=20
>>>> Running the 'make clean' command produces this error message:
>>>>=20
>>>> make[1]: *** No rule to make target =
`ui/input-keymap-atset1-to-qcode.c', needed by `Makefile'.  Stop.
>>>> make: *** [clean] Error 1
>>>>=20
>>>> Perhaps a missing patch?
>>>=20
>>> No, its a missing "git submodule update --init ui/keycodemapdb" call
>>=20
>> Thank you for replying. I tried this command and saw this error =
message:
>>=20
>> error: pathspec 'ui/keycodemapdb' did not match any file(s) known to =
git.
>>=20
>> Note: I'm using version 3. Will test version 4 soon.=20
>>=20
>> I suggest adding the git submodule update info to your cover letter
>> saying it is required.
>=20
> It isn't supposed to be required - its a bug, hence why the tests are
> failing.
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|

Version four appears to have the same problem as version three. I still =
see this error message:

make: *** No rule to make target `ui/input-keymap-atset1-to-qcode.c', =
needed by `Makefile'.  Stop.
make: *** Waiting for unfinished jobs....=
