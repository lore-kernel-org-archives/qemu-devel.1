Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3075BC742B9
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037FC20645
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037FC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlukl-0006kN-30
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 08:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39057)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlukZ-0006MI-Ix
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlukX-00054m-Lk
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:34:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlukW-00053q-Ie
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:34:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A67530842A0;
 Fri, 12 Jul 2019 12:34:03 +0000 (UTC)
Received: from work-vm (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E0B60DB7;
 Fri, 12 Jul 2019 12:34:02 +0000 (UTC)
Date: Fri, 12 Jul 2019 13:34:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lin Ma <LMa@suse.com>
Message-ID: <20190712123400.GJ2730@work-vm>
References: <BY5PR18MB3313E1E22A22D236D4C2680DC5F30@BY5PR18MB3313.namprd18.prod.outlook.com>
 <20190711102410.GH3971@work-vm>
 <BY5PR18MB331347C441DA068E32BFDE53C5F20@BY5PR18MB3313.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR18MB331347C441DA068E32BFDE53C5F20@BY5PR18MB3313.namprd18.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 12 Jul 2019 12:34:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] 
 =?utf-8?b?562U5aSNOiAgbWlncmF0ZV9zZXRfc3BlZWQgaGFz?=
 =?utf-8?q?_no_effect_if_the_guest_is_using_hugepages=2E?=
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lin Ma (LMa@suse.com) wrote:
>=20
>=20
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Dr. David Alan Gilbert <dgilbert@redhat.=
com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B47=E6=9C=8811=E6=97=
=A5 18:24
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Lin Ma <LMa@suse.com>
> > =E6=8A=84=E9=80=81: qemu-devel@nongnu.org
> > =E4=B8=BB=E9=A2=98: Re: [Qemu-devel] migrate_set_speed has no effect =
if the guest is using
> > hugepages.
> >=20
> > * Lin Ma (LMa@suse.com) wrote:
> > > Hi all,
> >=20
> > Hi Lin,
>=20
> Hi Dave,
> >=20
> > > When I live migrate a qemu/kvm guest, If the guest is using huge
> > > pages, I found that the migrate_set_speed command had no effect dur=
ing
> > stage 2.
> >=20
> > Can you explain what you mean by 'stage 2'?
> We know that the live migration contains 3 stages:
> Stage 1: Mark all of RAM dirty.
> Stage 2: Keep sending dirty RAM pages since last iteration
> Stage 3: Stop guest, transfer remaining dirty RAM, device state
> (Please refer to https://developers.redhat.com/blog/2015/03/24/live-mig=
rating-qemu-kvm-virtual-machines/#live-migration for further details)

OK, yeh the numbering is pretty arbitrary so it's not something I
normally think about like that.

>=20
> > > It was caused by commit 4c011c3 postcopy: Send whole huge pages
> > >
> > > I'm wondering that is it by design or is it a bug waiting for fix?
> >=20
> > This is the first report I've seen for it.  How did you conclude that
> > 4c011c3 caused it?  While I can see it might have some effect on the
> > bandwidth management, I'm surprised it has this much effect.
>=20
> While digging into the bandwidth issue, Git bisect shows that this comm=
it was the first bad commit.

OK.

> > What size huge pages are you using - 2MB or 1GB?
>=20
> When I hit this issue I was using 1GB huge page size.
> I tested this issue with 2MB page size today On Gigabit LAN, Although t=
he bandwidth control looks
> a little better than using 1GB, But not too much. Please refer to the b=
elow test result.

OK, I can certainly see why this might happen with 1GB huge pages; I
need to have a think about a fix.

> > I can imagine we might have a problem that since we only do the sleep=
 between
> > the hugepages, if we were using 1GB hugepages then we'd see <big chun=
k of
> > data>[sleep]<big chunk of data>[sleep] which isn't as smooth as it us=
ed to be.
> >=20
> > Can you give me some more details of your test?
>=20
> Live migration bandwidth management testing with 2MB hugepage size:
> sles12sp4_i440fx is a qemu/kvm guest with 6GB memory size.
> Note: the throughput value is approximating value.
>=20
> Terminal 1:
> virsh migrate-setspeed sles12sp4_i440fx $bandwidth && virsh migrate --l=
ive sles12sp4_i440fx qemu+tcp://5810f/system
>=20
> Terminal 2:
> virsh qemu-monitor-command sles12sp4_i440fx --hmp "info migrate"
>=20
> bandwidth=3D5
> throughput: 160 mbps
>=20
> bandwidth=3D10
> throughput: 167 mbps
>=20
> bandwidth=3D15
> throughput: 168 mbps
>=20
> bandwidth=3D20
> throughput: 168 mbps
>=20
> bandwidth=3D21
> throughput: 336 mbps
>=20
> bandwidth=3D22
> throughput: 336 mbps
>=20
> bandwidth=3D25
> throughput: 335.87 mbps
>=20
> bandwidth=3D30
> throughput: 335 mbps
>=20
> bandwidth=3D35
> throughput: 335 mbps
>=20
> bandwidth=3D40
> throughput: 335 mbps
>=20
> bandwidth=3D45
> throughput: 504.00 mbps
>=20
> bandwidth=3D50
> throughput: 500.00 mbps
>=20
> bandwidth=3D55
> throughput: 500.00 mbps
>=20
> bandwidth=3D60
> throughput: 500.00 mbps
>=20
> bandwidth=3D65
> throughput: 650.00 mbps
>=20
> bandwidth=3D70
> throughput: 660.00 mbps

OK, so migrate-setspeed takes a bandwidth in MBytes/sec and I guess
you're throughput is in MBit/sec - so at the higher end it's about
right, and at the lower end it's way off.

Let me think about a fix for this.

What are you using to measure throughput?

Dave

>=20
> Thanks,
> Lin
>=20
>=20
> > Dave
> >=20
> > >
> > > Thanks,
> > > Lin
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

