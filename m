Received: from eggs.gnu.org ([2001:4830:134:3::10]:58942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYyEa-0001nk-7H
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYyEX-0004xA-1y
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:35:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fYyEW-0004mq-Rr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:35:00 -0400
References: <1400565880-13409-1-git-send-email-famz@redhat.com>
	<57e00977-d315-6be9-de9f-b599021958f2@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7a7293c0-051e-1955-c990-bcd3db4d00ef@redhat.com>
Date: Fri, 29 Jun 2018 14:34:53 -0400
MIME-Version: 1.0
In-Reply-To: <57e00977-d315-6be9-de9f-b599021958f2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v20 00/15] Drop in_use from
 BlockDriverState and enable point-in-time snapshot exporting over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imain@redhat.com, stefanha@redhat.com, hbrock@redhat.com, jcody@redhat.com, armbru@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



On 06/29/2018 02:00 PM, Eric Blake wrote:
> On 05/20/2014 01:04 AM, Fam Zheng wrote:
>> Thanks for Eric's and Markus' reviewing!
>=20
> Thread necromancy - now that patch 15/15 has had a revival four years
> later (two different threads proposing a test 222 for image fleecing) -
> I want to double check if anything else in this series still needs
> forward porting.
>=20

This is pretty intensely old...

>>
>> v20: Rebase to master, with minor improvements as listed below:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 [02/15] block: Introduce op_blockers to Block=
DriverState
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Better error message in bdrv_op_is_blocked. (Markus)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 [03/15] block: Replace in_use with operation =
blocker
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Accurate commit message: why use bdrv_op_blocker_is_empty in
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 block_job_create. (Markus)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 [06/15] block: Add backing_blocker in BlockDr=
iverState
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Drop error_is_set().
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Call error_free() unconditionally.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0 [08/15] block: Support dropping active in bdr=
v_drop_intermediate
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Fix list index in function comment. (Eric)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 [13/15] block: Add blockdev-backup to transac=
tion
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Drop error_is_set().
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 [14/15] qemu-iotests: Test blockdev-backup in=
 055
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Bump year in file header. (Eric)
>> =C2=A0=20
>=20
>> Fam Zheng (15):
>> =C2=A0=C2=A0 block: Add BlockOpType enum
>> =C2=A0=C2=A0 block: Introduce op_blockers to BlockDriverState
>> =C2=A0=C2=A0 block: Replace in_use with operation blocker
>> =C2=A0=C2=A0 block: Move op_blocker check from block_job_create to its=
 caller
>> =C2=A0=C2=A0 block: Add bdrv_set_backing_hd()
>> =C2=A0=C2=A0 block: Add backing_blocker in BlockDriverState
>=20
> Before this point looks to be in master (in some form or another); afte=
r
> this point did not have any review.
>=20
>> =C2=A0=C2=A0 block: Parse "backing" option to reference existing BDS

Well, this obviously currently works.

>> =C2=A0=C2=A0 block: Support dropping active in bdrv_drop_intermediate
>> =C2=A0=C2=A0 stream: Use bdrv_drop_intermediate and drop close_unused_=
images
>> =C2=A0=C2=A0 commit: Use bdrv_drop_intermediate

Not sure about these three.

>> =C2=A0=C2=A0 qmp: Add command 'blockdev-backup'

We do have this one.

>> =C2=A0=C2=A0 block: Allow backup on referenced named BlockDriverState

With patch 1/2 or 1/3 from either Vlad or myself, we have this, too.

>> =C2=A0=C2=A0 block: Add blockdev-backup to transaction

We already have this.

>> =C2=A0=C2=A0 qemu-iotests: Test blockdev-backup in 055
>> =C2=A0=C2=A0 qemu-iotests: Image fleecing test case 089

These never got added, but we're working on that now.

>>
>> =C2=A0 block-migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 310
>> +++++++++++++++++++++++++++-------------
>> =C2=A0 block/backup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 26 ++++
>> =C2=A0 block/commit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 block/mirror.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +-
>> =C2=A0 block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 +-----
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 122 ++++++++++++++--
>> =C2=A0 blockjob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 14 +-
>> =C2=A0 hw/block/dataplane/virtio-blk.c |=C2=A0 18 ++-
>> =C2=A0 include/block/block.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 29 +++-
>> =C2=A0 include/block/block_int.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 9 +-
>> =C2=A0 include/block/blockjob.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 3 +
>> =C2=A0 qapi-schema.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 52 +++++++
>> =C2=A0 qmp-commands.hx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 44 ++++++
>> =C2=A0 tests/qemu-iotests/055=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 277
>> +++++++++++++++++++++++++++++------
>> =C2=A0 tests/qemu-iotests/055.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 4 +-
>> =C2=A0 tests/qemu-iotests/089=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 99 +++++++++++++
>> =C2=A0 tests/qemu-iotests/089.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 5 +
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 19 files changed, 856 insertions(+), 217 deletions(-)
>> =C2=A0 create mode 100755 tests/qemu-iotests/089
>> =C2=A0 create mode 100644 tests/qemu-iotests/089.out
>>
>=20
