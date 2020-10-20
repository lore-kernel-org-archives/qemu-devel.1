Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830CEC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB14E22251
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB14E22251
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsBw-000317-Gg
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUsB0-00026m-OF
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:59:46 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:45481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUsAv-0004pb-MQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:59:44 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.210])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 34DAD6DD2516;
 Tue, 20 Oct 2020 15:59:38 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 20 Oct
 2020 15:59:37 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006bc0c9eca-3558-4228-abe5-b65982a39bc2,
 1DF5E91C91B319FFB92086F2F245FA8D0BCC998A) smtp.auth=groug@kaod.org
Date: Tue, 20 Oct 2020 15:59:36 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/8] tests/9pfs: simplify fs_mkdir()
Message-ID: <20201020155936.5dc8bed4@bahia.lan>
In-Reply-To: <2130426.d1XtYRms3g@silver>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
 <03b427019be98d12761924f1e6132eefc82c80ec.1603149434.git.qemu_oss@crudebyte.com>
 <20201020153536.1fe40e32@bahia.lan> <2130426.d1XtYRms3g@silver>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: d7599a5f-7bdf-4210-bb49-c6c77ea5bdb0
X-Ovh-Tracer-Id: 17098197463819065754
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:35:38
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

Well I guess I haven't set a good exemple by calling fs_attach() everywhere
instead of factoring out an helper in the first place... I have some spare
time, I'll fix that.

> Best regards,
> Christian Schoenebeck
> 
> 


