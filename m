Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74071C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54345207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54345207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2wk7-0007QJ-Gu
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 09:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1k2wjX-0006vz-2j
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 09:11:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2531 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1k2wjU-0005Em-9Y
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 09:11:58 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 6B737756ADD8D7437DE7;
 Tue,  4 Aug 2020 21:11:40 +0800 (CST)
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 4 Aug 2020 21:11:39 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Tue, 4 Aug 2020 21:11:39 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, "david@redhat.com" <david@redhat.com>
Subject: RE: [PATCH v0 0/4] background snapshot
Thread-Topic: [PATCH v0 0/4] background snapshot
Thread-Index: AQHWX//paz+Rb4dfLUOxQKrMAEkMNakbKICAgAzQiBA=
Date: Tue, 4 Aug 2020 13:11:39 +0000
Message-ID: <f58d7249bc0c49e3b1fe8258a711aaaf@huawei.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200727165935.GS3040@work-vm>
In-Reply-To: <20200727165935.GS3040@work-vm>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 09:11:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "den@openvz.org" <den@openvz.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

Thanks for cc me, it was really exciting to know that write-protect feature=
 finally been merged.
Exclude live memory snapshot, I'm thinking if we can use it to realize the =
real memory throttle in migration,
Since we still can come across dirty pages fail to converge with current cp=
u throttle method.
we may use write-protect capability to slow down the accessing speed of gue=
st's memory, in order to
slow down the dirty pages ..., I'll look into it.

Besides, I'll follow this snapshot series, and to see if I can do some work=
s to make this feature to be perfect enough
To be accepted as quickly as possible. ;)


Thanks,
Hailiang

> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Tuesday, July 28, 2020 1:00 AM
> To: Denis Plotnikov <dplotnikov@virtuozzo.com>; david@redhat.com;
> Zhanghailiang <zhang.zhanghailiang@huawei.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; quintela@redhat.com;
> eblake@redhat.com; armbru@redhat.com; peterx@redhat.com;
> den@openvz.org
> Subject: Re: [PATCH v0 0/4] background snapshot
>=20
> * Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
> > Currently where is no way to make a vm snapshot without pausing a vm
> > for the whole time until the snapshot is done. So, the problem is the
> > vm downtime on snapshoting. The downtime value depends on the
> vmstate
> > size, the major part of which is RAM and the disk performance which is
> > used for the snapshot saving.
> >
> > The series propose a way to reduce the vm snapshot downtime. This is
> > done by saving RAM, the major part of vmstate, in the background when
> > the vm is running.
> >
> > The background snapshot uses linux UFFD write-protected mode for
> > memory page access intercepting. UFFD write-protected mode was added
> to the linux v5.7.
> > If UFFD write-protected mode isn't available the background snapshot
> > rejects to run.
>=20
> Hi Denis,
>   I see Peter has responded to most of your patches, but just anted to sa=
y
> thank you; but also to cc in a couple of other people; David Hildenbrand
> (who is interested in unusual memory stuff) and zhanghailiang who works o=
n
> COLO which also does snapshotting and had long wanted to use WP.
>=20
>   2/4 was a bit big for my liking; please try and do it in smaller chunks=
!
>=20
> Dave
>=20
> > How to use:
> > 1. enable background snapshot capability
> >    virsh qemu-monitor-command vm --hmp migrate_set_capability
> > background-snapshot on
> >
> > 2. stop the vm
> >    virsh qemu-monitor-command vm --hmp stop
> >
> > 3. Start the external migration to a file
> >    virsh qemu-monitor-command cent78-bs --hmp migrate
> exec:'cat > ./vm_state'
> >
> > 4. Wait for the migration finish and check that the migration has compl=
eted
> state.
> >
> > Denis Plotnikov (4):
> >   bitops: add some atomic versions of bitmap operations
> >   migration: add background snapshot capability
> >   migration: add background snapshot
> >   background snapshot: add trace events for page fault processing
> >
> >  qapi/migration.json     |   7 +-
> >  include/exec/ramblock.h |   8 +
> >  include/exec/ramlist.h  |   2 +
> >  include/qemu/bitops.h   |  25 ++
> >  migration/migration.h   |   1 +
> >  migration/ram.h         |  19 +-
> >  migration/savevm.h      |   3 +
> >  migration/migration.c   | 142 +++++++++-
> >  migration/ram.c         | 582
> ++++++++++++++++++++++++++++++++++++++--
> >  migration/savevm.c      |   1 -
> >  migration/trace-events  |   2 +
> >  11 files changed, 771 insertions(+), 21 deletions(-)
> >
> > --
> > 2.17.0
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


