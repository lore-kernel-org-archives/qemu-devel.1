Received: from eggs.gnu.org ([2001:4830:134:3::10]:39119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1etdDC-0006rx-Tk
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1etdDC-0000BY-3K
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:50:46 -0500
References: <20180205202232.19254-1-mreitz@redhat.com>
	<73838a0c-d960-d24d-b706-a0ecbcbe7aaf@redhat.com>
	<20180307100424.GA7917@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <2d97780c-4a06-1b08-8211-760fc3567c2a@redhat.com>
Date: Wed, 7 Mar 2018 12:50:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180307100424.GA7917@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org



On 03/07/2018 05:04 AM, Kevin Wolf wrote:
> Am 06.03.2018 um 22:51 hat John Snow geschrieben:
>> On 02/05/2018 03:22 PM, Max Reitz wrote:
>>> This series implements .bdrv_refresh_filename() for the ssh block
>>> driver, along with an appropriate .bdrv_dirname() so we don't chop of=
f
>>> query strings for backing files with relative filenames.
>>>
>>> This series depends on my =E2=80=9Cblock: Fix some filename generatio=
n issues=E2=80=9D
>>> series and on Pino's =E2=80=9Cssh: switch from libssh2 to libssh=E2=80=
=9D patch.
>>>
>>> Based-on: 20180205151835.20812-1-mreitz@redhat.com
>>> Based-on: 20180118164439.2120-1-ptoscano@redhat.com
>>>
>>>
>>> Max Reitz (2):
>>>   block/ssh: Implement .bdrv_refresh_filename()
>>>   block/ssh: Implement .bdrv_dirname()
>>>
>>>  block/ssh.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++------
>>>  1 file changed, 65 insertions(+), 7 deletions(-)
>>
>> Did this one rot on the vine?
>>
>>> 1 month old.
>=20
> The Based-on tags are the problem, in particular the first one. But yes=
,
> we could possibly do more to review the dependencies...
>=20
> Kevin
>=20

Yeah, sorry, I'm not pulling my review weight right now. I do try to
keep my block-devel inbox a rough "todo," though, so for patches that
get to that one month mark with no conclusion I like to ping them before
I archive them.

It's something I'd like to see patchew do, actually:

"Here's a list of what's on the list that has no reviews or NACKs, and
needs some love"

coupled with a 30 day "Hey, nobody looked at this" ping to the list
before it NACKs a set for being too old.

I hope nobody reads these >1 month pings as me wondering why nobody ELSE
has reviewed it, which is not my intent...

--js
