Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26453C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B2220863
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B2220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd9Nt-0002B4-2P
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 04:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38220)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hd9Me-0001Uh-0p
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hd9Mc-0006Kh-Ki
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hd9MZ-0006DG-KS; Tue, 18 Jun 2019 04:21:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B7B6356CF;
 Tue, 18 Jun 2019 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A25437E8E8;
 Tue, 18 Jun 2019 08:20:58 +0000 (UTC)
Date: Tue, 18 Jun 2019 10:20:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190618082057.GC4296@localhost.localdomain>
References: <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
 <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
 <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
 <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
 <20190617155315.GK7397@linux.fritz.box>
 <b86c6a8f-7a89-58ca-6966-b2f00aff0f2b@redhat.com>
 <20190617162531.GM7397@linux.fritz.box>
 <02e338ba-5e5e-240e-ddcb-d8e7840d0b06@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02e338ba-5e5e-240e-ddcb-d8e7840d0b06@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 18 Jun 2019 08:21:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 4/7] block: introduce backup-top filter
 driver
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.06.2019 um 09:19 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 17.06.2019 19:25, Kevin Wolf wrote:
> > The first step would be making the block drivers full replacements of
> > the old things, which unfortunately isn't true today.
> >=20
> > After your "deal with filters" series, we should be a lot closer for =
the
> > core infrastructure at least.
> >=20
> > Not sure about copy-on-read, but I know that throttle still doesn't h=
ave
> > feature parity with -drive throttling. At least I'm pretty sure that
> > something about changing the group or group options at runtime (and n=
ot
> > just dropping the x-) was missing.
>=20
> OK, thanks, I understand now that implicit filters are not just a
> feature but compatibility mechanism.
>=20
> So, can we at some point deprecate "optionality" of filter-node-name
> parameters of jobs, in addition to deprecation of things like old
> copy-on-read option?  And actually deprecate implicit filters by this?

Hm, I'm not sure if we have ever moved an optional feature to required,
and how to communicate this to libvirt, but this would be ideal, yes.

> >>>>>>> But should really filter do that job, or it is here only to do =
CBW? Maybe target
> >>>>>>> must have another parent which will care about flushing.
> >>>>>>>
> >>>>>>> Ok, I think I'll flush target here too for safety, and leave a =
comment, that something
> >>>>>>> smarter would be better.
> >>>>>>> (or, if we decide to flush all children by default in generic c=
ode, I'll drop this handler)
> >>>>>>
> >>>>>> [1] Thinking more about this, for normal backups the target file=
 does
> >>>>>> not reflect a valid disk state until the backup is done; just li=
ke for
> >>>>>> qemu-img convert.  Just like qemu-img convert, there is therefor=
e no
> >>>>>> reason to flush the target until the job is done.
> >>>
> >>> Depends, the target could have the source as its backing file (like
> >>> fleecing, but without exporting it right now), and then you could a=
lways
> >>> have a consistent view on the target. Well, almost.
> >>>
> >>> Almost because to guarantee this, we'd have to flush between each C=
BW
> >>> and the corresponding write to the same block, to make sure that th=
e old
> >>> data is backed up before it is overwritten.
> >>
> >> Yes, that=E2=80=99s what I meant by =E2=80=9Cenforce on the host tha=
t the target is
> >> always flushed before the source=E2=80=9D.  Well, I meant to say the=
re is no
> >> good way of doing that, and I kind of don=E2=80=99t consider this a =
good way.
> >>
> >>> Of course, this would perform about as badly as internal COW in qco=
w2...
> >>> So probably not a guarantee we should be making by default. But it =
might
> >>> make sense as an option.
> >>
> >> I don=E2=80=99t know.  =E2=80=9CUse this option so your data isn=E2=80=
=99t lost in case of a
> >> power failure, but it makes everything pretty slow=E2=80=9D?  Who is=
 going to do
> >> explicitly enable that (before their first data loss)?
> >=20
> > Maybe the backup job wasn't that clever after all. At least if you ca=
re
> > about keeping the point-in-time snapshot at the start of the backup j=
ob
> > instead of just retrying and getting a snapshot of a different point =
in
> > time that is just as good.
> >=20
> > If you do care about the specific point in time, the safe way to do i=
t
> > is to take a snapshot and copy that away, and then delete the snapsho=
t
> > again.
> >=20
> > The only problem is that merging external snapshots is slow and you e=
nd
> > up writing the new data twice. If only we had a COW image format... :=
-)
>=20
> So, I still don't understand the reason of flushing backup target in a
> meantime.  Backup target remains invalid until the successful end of
> the job, at which point we definitely flush target, but only once.
>=20
> If node crashes during backup, backup would be invalid independently
> of were there flushes after each write (or better just enable
> O_DIRECT) or not.

Say your VM is running on disk.qcow2 and you use a backup job to copy
data to backup.qcow2. At some point, the host crashes. If we made sure
that every CBW to backup.qcow2 has completed before we write new data to
disk.qcow2, backup.qcow2 contains valid data that represents the state
at the start of the backup job as long as you use disk.qcow2 as its
backing file.

The only way to ensure the right order is flushing between the two
operations. If you don't do that, then yes, your backing is invalid
before it has completed.

O_DIRECT doesn't guarantee that the data is on disk, only a flush does
that. Maybe your chances that things actually make it to the disk in
case of a host crash are higher if it sits in the disk cache rather than
in the host's RAM, but there is no guarantee without a flush.

Now flushing the target when the guest flushes its disk doesn't give you
new guarantees. Maybe it increases your chances that you're lucky and
your data is correct, but you won't be able to tell. So... not really a
reason not to do it, but it's probably kind of useless.

Kevin

