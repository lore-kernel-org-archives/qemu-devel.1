Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7BCC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8282076A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8282076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvzo-0005MX-2f
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUvyd-0004TW-K7
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:03:15 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:59907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUvyb-0004u4-MZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:03:15 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.235])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 3F5DC677BF27;
 Tue, 20 Oct 2020 20:03:11 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 20 Oct
 2020 20:03:10 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0012b1ab48b-bda1-4fcb-845e-57ae4488ee7e,
 1DF5E91C91B319FFB92086F2F245FA8D0BCC998A) smtp.auth=groug@kaod.org
Date: Tue, 20 Oct 2020 20:03:09 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/8] tests/9pfs: simplify fs_mkdir()
Message-ID: <20201020200309.20f8e85d@bahia.lan>
In-Reply-To: <2130426.d1XtYRms3g@silver>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
 <03b427019be98d12761924f1e6132eefc82c80ec.1603149434.git.qemu_oss@crudebyte.com>
 <20201020153536.1fe40e32@bahia.lan> <2130426.d1XtYRms3g@silver>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: ad4e8645-ff48-4c6e-a629-b14737ce4067
X-Ovh-Tracer-Id: 2764928697989765530
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 14:03:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 15:43:21 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 20. Oktober 2020 15:35:36 CEST Greg Kurz wrote:
> > On Tue, 20 Oct 2020 01:13:23 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > Split out walking a directory path to a separate new utility function
> > > fs_walk_fid() and use that function in fs_mkdir().
> > > 
> > > The code difference saved this way is not much, but we'll use that new
> > > fs_walk_fid() function in the upcoming patches, so it will avoid quite
> > > some code duplication after all.
> > > 
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > > 
> > >  tests/qtest/virtio-9p-test.c | 23 ++++++++++++++++++-----
> > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > > index c15908f27b..dc724bbb1e 100644
> > > --- a/tests/qtest/virtio-9p-test.c
> > > +++ b/tests/qtest/virtio-9p-test.c
> > > @@ -967,13 +967,12 @@ static void fs_flush_ignored(void *obj, void *data,
> > > QGuestAllocator *t_alloc)> 
> > >      g_free(wnames[0]);
> > >  
> > >  }
> > > 
> > > -static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
> > > -                     const char *path, const char *cname)
> > > +/* utility function: walk to requested dir and return fid for that dir */
> > > +static uint32_t fs_walk_fid(void *obj, void *data, QGuestAllocator
> > > *t_alloc, +                            const char *path)
> > > 
> > >  {
> > 
> > Since fs_walk_fid() is a helper function, ie. not passed to qos_add_test(),
> > any reason to keep the "void *obj, void *data, QGuestAllocator *t_alloc"
> > based signature ? data and t_alloc aren't used at all and it seems that the
> > function should rather take a QVirtio9P * directly instead of casting from
> > a void *.
> > 
> > Something like:
> > 
> > static uint32_t fs_walk_fid(QVirtio9P *v9p, const char *path)
> > {
> > ...
> > }
> > 
> > 
> > Same remark applies to fs_mkdir() which isn't a top level test function
> > either BTW (sorry for not having spotted this earlier).
> 
> Good point. Typical case of being copy & waste induced. I'll change that.
> 

Since this also affects other patches in this series and this might
have a substantial impact, I'll wait for v2 to review if you don't
mind.

> Best regards,
> Christian Schoenebeck
> 
> 


