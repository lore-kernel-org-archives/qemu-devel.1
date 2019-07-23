Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2995EC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028F121743
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028F121743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprOG-000082-7F
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50476)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1hprO4-00088L-5b
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1hprO2-0007kD-ML
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:47:12 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:16157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1hprNz-0007gV-Iq; Tue, 23 Jul 2019 05:47:07 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C69FB432B2;
 Tue, 23 Jul 2019 11:47:04 +0200 (CEST)
Date: Tue, 23 Jul 2019 11:47:02 +0200
From: Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190723094702.glmdyjm6rgelcwte@nora.maurer-it.com>
References: <20190709232550.10724-1-jsnow@redhat.com>
 <20190722121755.xpx2qni53e6pha7t@nora.maurer-it.com>
 <a88974cc-29dc-3e4d-12b4-b2ce2734612b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a88974cc-29dc-3e4d-12b4-b2ce2734612b@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.186.127.180
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

On Mon, Jul 22, 2019 at 01:21:02PM -0400, John Snow wrote:
>=20
>=20
> On 7/22/19 8:17 AM, Fabian Gr=FCnbichler wrote:
> > On Tue, Jul 09, 2019 at 07:25:32PM -0400, John Snow wrote:
> >> This series adds a new "BITMAP" sync mode that is meant to replace t=
he
> >> existing "INCREMENTAL" sync mode.
> >>
> >> This mode can have its behavior modified by issuing any of three bit=
map sync
> >> modes, passed as arguments to the job.
> >>
> >> The three bitmap sync modes are:
> >> - ON-SUCCESS: This is an alias for the old incremental mode. The bit=
map is
> >>               conditionally synchronized based on the return code of=
 the job
> >>               upon completion.
> >> - NEVER: This is, effectively, the differential backup mode. It neve=
r clears
> >>          the bitmap, as the name suggests.
> >> - ALWAYS: Here is the new, exciting thing. The bitmap is always sync=
hronized,
> >>           even on failure. On success, this is identical to incremen=
tal, but
> >>           on failure it clears only the bits that were copied succes=
sfully.
> >>           This can be used to "resume" incremental backups from late=
r points
> >>           in times.
> >>
> >> I wrote this series by accident on my way to implement incremental m=
ode
> >> for mirror, but this happened first -- the problem is that Mirror mo=
de
> >> uses its existing modes in a very particular way; and this was the b=
est
> >> way to add bitmap support into the mirror job properly.
> >>
> >> [...]
> >>
> >> Future work:
> >> [..]
> >>  - Add these modes to Mirror. (Done*, but needs tests.)
> >=20
> > are these mirror patches available somehwere for testing in combinati=
on
> > with this series? your bitmaps branch does not seem to contain them ;=
)
> >=20
> > we've been experimenting with Ma Haocong's patch (v4 from February) t=
o add
> > "incremental"/differential sync to drive-mirror recently with positiv=
e
> > results so far, and this sounds like it is another attempt at getting
> > this properly integrated into Qemu.
> >=20
>=20
> Not available quite yet; I added it in fairly hastily but haven't done
> the testing I want to do yet, so I wouldn't feel comfortable sharing it
> before I do my own due diligence on it. Give me a chance to polish it s=
o
> that the testing effort isn't wasted :)

fair enough, and no hurries :)

>=20
> Can you share some of your use-cases for how you are using the
> "incremental mirror" so far? It might be useful for the patch
> justification if I can point to production use cases. (And good for
> allocating time, too.)

it's basically the same use case that the original "incremental mirror"
patch (series)[1] from two years ago had (no affiliation with the author
though) - we have a guest disk replication feature for ZFS/zvols in a
clustered hypervisor setting, and would like to re-use the already
replicated disk state when live-migrating a VM. Qemu does not know
anything about the replication, since it happens on the storage layer
with zfs send/zfs receive. note that for VMs, we use zvols which are
block devices backed by ZFS (or rather, ZFS datasets exposed as block
devices), minus the file system part of regular ZFS datasets. from
Qemu's PoV these (replicated) disks are just regular block devices (and n=
ot
image-backed disks on a filesystem, or accessed via some special
BlockDriver like Ceph's RBD images).

we currently support live migration
1) with disks on shared/distributed storage (easy enough)
2) with regular (non-replicated, local) disks (via nbd/drive-mirror)
3) with unused disks on the storage level (disks are not known to Qemu/th=
e VM)

1-3 can be mixed and matched arbitrarily in one guest, e.g. with one
disk on a shared Ceph cluster, one disk that is not in use on an NFS
share, and another disk on a local LVM-thin pool. 2) and 3) also allow
switching the underlying storage on the fly, since they transfer the
full disk (content) anyway.

we also support offline migration with shared, local, unused and/or
replicated disks (all on the storage level with no involvement of Qemu).

as you can see there is a gap in the live-migration feature matrix: when
replication is used, you either have to poweroff the VM to re-use the
replication state (storage-only migration), or drop the replication
state and do a full local-disk live-migration before re-creating the
replication state from scratch (which is bad, since replication can have
multiple target hosts, and re-establishing the whole disk can take a
while if its big).

our basic approach is (currently) the following:

1) get disk info
2) Qemu: add dirty bitmaps for currently used, replicated disks
3) storage/ZFS: do a regular replication of all replicated disks (used AN=
D unused)
4) storage: do a regular storage migration of all regular unused local di=
sks
5a) Qemu: do a regular drive-mirror of all currently used, local disks
5b) Qemu: do an incremental drive-mirror for all currently used, replicat=
ed disks
6) Qemu: wait for convergence of drive-mirror jobs
7) Qemu: do a regular live-migration of VM
8) Qemu: once converged and VM is suspended, complete drive-mirror jobs
9) Qemu: resume now fully migrated VM on target node
10) Qemu/storage: clean up on source node

5b) with bitmaps from 2) is what is currently missing on the Qemu side,
but seems easy enough to support (like I said, we are currently using Ma
Haocong's patch for testing, but want to get this feature upstream one
way or another instead of carrying our own, possibly incompatible in the
near-future version).

2) and 3) are obviously not atomic, so the bitmaps will contain some
writes that have been replicated already on the block/storage layer
below the VM, and those writes will be done a second time in step 5b).

we can work around this by adding another short down time by
freezing/suspending prior to 2) until after doing the ZFS snapshots at
the start of 3), in case these duplicate writes turn out to be
problematic after all. this downtime would be rather short, as the bulk
of the replication work (actually transfering the latest delta) can
happen after unfreezing/resuming the VM. so far we haven't encountered
any problems in our (albeit limited) testing though, so if possible we
would naturally like to avoid the additional downtime altogether ;)

looking forward to your patch(es) :)

1: <CAKVPjOZ8Y8U2zHgo_06aozrdd9_Cq6txWrX5F4HnFefAUjimyQ@mail.gmail.com>
and <20170504105444.8940-1-daniel.kucera@gmail.com>


