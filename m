Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43705C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078F92239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078F92239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpy7Y-0002xm-0V
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 12:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hpy7M-0002O2-7h
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hpy7K-0003Tz-GM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hpy7G-0003QR-Q3; Tue, 23 Jul 2019 12:58:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9AC32CD7E6;
 Tue, 23 Jul 2019 16:58:16 +0000 (UTC)
Received: from [10.10.125.185] (ovpn-125-185.rdu2.redhat.com [10.10.125.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C4455C25A;
 Tue, 23 Jul 2019 16:58:10 +0000 (UTC)
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>
References: <20190709232550.10724-1-jsnow@redhat.com>
 <20190722121755.xpx2qni53e6pha7t@nora.maurer-it.com>
 <a88974cc-29dc-3e4d-12b4-b2ce2734612b@redhat.com>
 <20190723094702.glmdyjm6rgelcwte@nora.maurer-it.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <787d6506-d4bb-0904-5e58-521d6fc8313a@redhat.com>
Date: Tue, 23 Jul 2019 12:58:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723094702.glmdyjm6rgelcwte@nora.maurer-it.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 23 Jul 2019 16:58:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 00/18] bitmaps: introduce 'bitmap' sync
 mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/23/19 5:47 AM, Fabian Gr=C3=BCnbichler wrote:
> On Mon, Jul 22, 2019 at 01:21:02PM -0400, John Snow wrote:
>>
>>
>> On 7/22/19 8:17 AM, Fabian Gr=C3=BCnbichler wrote:
>>> On Tue, Jul 09, 2019 at 07:25:32PM -0400, John Snow wrote:
>>>> This series adds a new "BITMAP" sync mode that is meant to replace t=
he
>>>> existing "INCREMENTAL" sync mode.
>>>>
>>>> This mode can have its behavior modified by issuing any of three bit=
map sync
>>>> modes, passed as arguments to the job.
>>>>
>>>> The three bitmap sync modes are:
>>>> - ON-SUCCESS: This is an alias for the old incremental mode. The bit=
map is
>>>>               conditionally synchronized based on the return code of=
 the job
>>>>               upon completion.
>>>> - NEVER: This is, effectively, the differential backup mode. It neve=
r clears
>>>>          the bitmap, as the name suggests.
>>>> - ALWAYS: Here is the new, exciting thing. The bitmap is always sync=
hronized,
>>>>           even on failure. On success, this is identical to incremen=
tal, but
>>>>           on failure it clears only the bits that were copied succes=
sfully.
>>>>           This can be used to "resume" incremental backups from late=
r points
>>>>           in times.
>>>>
>>>> I wrote this series by accident on my way to implement incremental m=
ode
>>>> for mirror, but this happened first -- the problem is that Mirror mo=
de
>>>> uses its existing modes in a very particular way; and this was the b=
est
>>>> way to add bitmap support into the mirror job properly.
>>>>
>>>> [...]
>>>>
>>>> Future work:
>>>> [..]
>>>>  - Add these modes to Mirror. (Done*, but needs tests.)
>>>
>>> are these mirror patches available somehwere for testing in combinati=
on
>>> with this series? your bitmaps branch does not seem to contain them ;=
)
>>>
>>> we've been experimenting with Ma Haocong's patch (v4 from February) t=
o add
>>> "incremental"/differential sync to drive-mirror recently with positiv=
e
>>> results so far, and this sounds like it is another attempt at getting
>>> this properly integrated into Qemu.
>>>
>>
>> Not available quite yet; I added it in fairly hastily but haven't done
>> the testing I want to do yet, so I wouldn't feel comfortable sharing i=
t
>> before I do my own due diligence on it. Give me a chance to polish it =
so
>> that the testing effort isn't wasted :)
>=20
> fair enough, and no hurries :)
>=20
>>
>> Can you share some of your use-cases for how you are using the
>> "incremental mirror" so far? It might be useful for the patch
>> justification if I can point to production use cases. (And good for
>> allocating time, too.)
>=20
> it's basically the same use case that the original "incremental mirror"
> patch (series)[1] from two years ago had (no affiliation with the autho=
r
> though) - we have a guest disk replication feature for ZFS/zvols in a
> clustered hypervisor setting, and would like to re-use the already
> replicated disk state when live-migrating a VM. Qemu does not know
> anything about the replication, since it happens on the storage layer
> with zfs send/zfs receive. note that for VMs, we use zvols which are
> block devices backed by ZFS (or rather, ZFS datasets exposed as block
> devices), minus the file system part of regular ZFS datasets. from
> Qemu's PoV these (replicated) disks are just regular block devices (and=
 not
> image-backed disks on a filesystem, or accessed via some special
> BlockDriver like Ceph's RBD images).
>=20
> we currently support live migration
> 1) with disks on shared/distributed storage (easy enough)
> 2) with regular (non-replicated, local) disks (via nbd/drive-mirror)
> 3) with unused disks on the storage level (disks are not known to Qemu/=
the VM)
>=20
> 1-3 can be mixed and matched arbitrarily in one guest, e.g. with one
> disk on a shared Ceph cluster, one disk that is not in use on an NFS
> share, and another disk on a local LVM-thin pool. 2) and 3) also allow
> switching the underlying storage on the fly, since they transfer the
> full disk (content) anyway.
>=20
> we also support offline migration with shared, local, unused and/or
> replicated disks (all on the storage level with no involvement of Qemu)=
.
>=20
> as you can see there is a gap in the live-migration feature matrix: whe=
n
> replication is used, you either have to poweroff the VM to re-use the
> replication state (storage-only migration), or drop the replication
> state and do a full local-disk live-migration before re-creating the
> replication state from scratch (which is bad, since replication can hav=
e
> multiple target hosts, and re-establishing the whole disk can take a
> while if its big).
>=20
> our basic approach is (currently) the following:
>=20
> 1) get disk info
> 2) Qemu: add dirty bitmaps for currently used, replicated disks
> 3) storage/ZFS: do a regular replication of all replicated disks (used =
AND unused)

I take it that the ZFS replication is not an ongoing process but
something that terminates, so you need QEMU to pick up the difference
that occurred during that time?

(Which I imagine the bitmap will pick up some writes that DO get
replicated, but copying some extra is safe.)

> 4) storage: do a regular storage migration of all regular unused local =
disks
> 5a) Qemu: do a regular drive-mirror of all currently used, local disks
> 5b) Qemu: do an incremental drive-mirror for all currently used, replic=
ated disks

To mirror anything written since the replication started, based on this
timeline.

> 6) Qemu: wait for convergence of drive-mirror jobs
> 7) Qemu: do a regular live-migration of VM
> 8) Qemu: once converged and VM is suspended, complete drive-mirror jobs
> 9) Qemu: resume now fully migrated VM on target node
> 10) Qemu/storage: clean up on source node
>=20
> 5b) with bitmaps from 2) is what is currently missing on the Qemu side,
> but seems easy enough to support (like I said, we are currently using M=
a
> Haocong's patch for testing, but want to get this feature upstream one
> way or another instead of carrying our own, possibly incompatible in th=
e
> near-future version).
>=20

It will look VERY similar. Switching should be easy; the only difference
will be:

sync=3DBITMAP instead of sync=3DINCREMENTAL, and
bitmap_mode=3DNEVER provided explicitly to match Ma Haocong's patch behav=
ior.

You can alternatively use the other bitmap policies depending on what
you want:

NEVER leaves the bitmap alone entirely like Ma Haocong's patch does. It
reflects a kind of "differential backup" intent; changes accumulate in
the bitmap if it was enabled.

ON-SUCCESS will reset any bits copied out if the job completes
successfully (note that this includes mirror cancellation after sync as
well as a COMPLETE instruction that includes the pivot.)

ALWAYS will reset any bits successfully copied out, regardless of the
final state of the job. You can use this one to resume the mirror on
failures.

You should be able to get the exact behavior you've already programmed
for, and maybe some new toys.

> 2) and 3) are obviously not atomic, so the bitmaps will contain some
> writes that have been replicated already on the block/storage layer
> below the VM, and those writes will be done a second time in step 5b).
>=20
> we can work around this by adding another short down time by
> freezing/suspending prior to 2) until after doing the ZFS snapshots at
> the start of 3), in case these duplicate writes turn out to be
> problematic after all. this downtime would be rather short, as the bulk
> of the replication work (actually transfering the latest delta) can
> happen after unfreezing/resuming the VM. so far we haven't encountered
> any problems in our (albeit limited) testing though, so if possible we
> would naturally like to avoid the additional downtime altogether ;)
>=20
> looking forward to your patch(es) :)
>=20
> 1: <CAKVPjOZ8Y8U2zHgo_06aozrdd9_Cq6txWrX5F4HnFefAUjimyQ@mail.gmail.com>
> and <20170504105444.8940-1-daniel.kucera@gmail.com>
>=20

Thanks for the writeup! My goal is to have this in for 4.2 alongside all
of the other bitmap changes I've queued so far.

--js

