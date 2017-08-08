Received: from eggs.gnu.org ([2001:4830:134:3::10]:51843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dfDyQ-0000R0-CZ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 19:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dfDyP-000845-Cu
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 19:31:42 -0400
MIME-Version: 1.0
In-Reply-To: <e20b65fe-9cb4-2b8f-05cb-fdc10485c9d9@redhat.com>
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-11-hpoussin@reactos.org>
	<CAJhHMCAZjtSZ9bVP8ARuex=kEUox=ed__LdEe39a6-gY7oKggQ@mail.gmail.com>
	<e20b65fe-9cb4-2b8f-05cb-fdc10485c9d9@redhat.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 8 Aug 2017 19:31:09 -0400
Message-ID: <CAJhHMCD8f6yb9YTHFDxsQ7yLHCjSaTiVranuhp+1TveiCNk3iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/13] vvfat: correctly generate
 numeric-tail of short file names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Mon, Aug 7, 2017 at 7:07 AM, Eric Blake <eblake@redhat.com> wrote:
> On 08/05/2017 01:52 PM, Pranith Kumar wrote:
>> FYI,
>>
>> This commit breaks the build with gcc-7:
>>
>>   CC      block/vvfat.o
>> qemu/block/vvfat.c: In function =E2=80=98read_directory=E2=80=99:
>> qemu/block/vvfat.c:605:37: error: =E2=80=98__builtin___sprintf_chk=E2=80=
=99 may write
>> a terminating nul past the end of the destination
>> [-Werror=3Dformat-overflow=3D]
>>              int len =3D sprintf(tail, "~%d", i);
>>                                      ^~~~~
>
> Doesn't commit 7c8730d45f6 fix that?

Indeed it does. I hadn't rebased my branch before reporting. Sorry for
the noise!

--=20
Pranith
