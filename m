Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA3FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762FE2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762FE2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTbD-0004c3-73
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYTZp-0003iI-LU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:32:17 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:40725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYTZk-0004He-Ge
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:32:17 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.137])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 5094C697B719;
 Fri, 30 Oct 2020 13:32:06 +0100 (CET)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 30 Oct
 2020 13:32:05 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005b8cc4846-d226-4083-b028-ad9822fc89ee,
 28B94817A5BF005C53DACA451BCD6EA07813AA4A) smtp.auth=groug@kaod.org
Date: Fri, 30 Oct 2020 13:32:04 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 2/2] tests/9pfs: fix coverity error in
 create_local_test_dir()
Message-ID: <20201030133204.65651c0a@bahia.lan>
In-Reply-To: <3565953.R2qxJ1zP7r@silver>
References: <cover.1604046404.git.qemu_oss@crudebyte.com>
 <b111895492f8fb79bcca1c3e9586c0615f46cc97.1604046404.git.qemu_oss@crudebyte.com>
 <20201030124418.1a20fb9f@bahia.lan> <3565953.R2qxJ1zP7r@silver>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 20b317ba-6fed-4965-b9e3-27b5e45b2dda
X-Ovh-Tracer-Id: 560135206828022237
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleehgdeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveegkeelgfetudekieduleejfffgieejgfdukedvtdeiteffieelteektdfffefgnecuffhomhgrihhnpegtohhvvghrihhthidrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:32:16
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 12:59:48 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Freitag, 30. Oktober 2020 12:44:18 CET Greg Kurz wrote:
> > On Fri, 30 Oct 2020 09:19:46 +0100
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > Coverity wants the return value of mkdir() to be checked, so let's
> > > pretend to do that. We're actually just making a dummy check and
> > > ignore the result, because we actually only care if the required
> > > directory exists and we have an existence check for that in place
> > > already.
> > 
> > I see that sometimes changelog shows a copy of the original
> > coverity report (e.g. commit df1a312fea58).
> 
> Ok, I'll add that.
> 
> > > Reported-by: Greg Kurz <groug@kaod.org>
> > 
> > Please give credits to coverity, not me :-)
> > 
> > And most importantly, we want to mention the CID in the changelog.
> > 
> > e.g.
> > 
> > Reported-by: Coverity (CID 1435963)
> 
> Ok.
> 
> It's not clear to me where this coverity report is accessible online. A quick 
> search only brought me to statistics about its latest check, but not the 
> details of the report you quoted.
> 

I've been notified by mail because I have an account there.

https://scan.coverity.com/users/sign_up

> And more importantly: is there coverity CI support that one could enable on 
> github, so that pending patches were checked before upstream merge?
> 

I see that Peter already provided the details.

> > 
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > > 
> > >  tests/qtest/libqos/virtio-9p.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/qtest/libqos/virtio-9p.c
> > > b/tests/qtest/libqos/virtio-9p.c index 6b22fa0e9a..0a7c0ee5d8 100644
> > > --- a/tests/qtest/libqos/virtio-9p.c
> > > +++ b/tests/qtest/libqos/virtio-9p.c
> > > @@ -48,9 +48,13 @@ static void init_local_test_path(void)
> > > 
> > >  static void create_local_test_dir(void)
> > >  {
> > >  
> > >      struct stat st;
> > > 
> > > +    int res;
> > > 
> > >      g_assert(local_test_path != NULL);
> > > 
> > > -    mkdir(local_test_path, 0777);
> > > +    res = mkdir(local_test_path, 0777);
> > > +    if (res < 0) {
> > > +        /* ignore error, dummy check to prevent error by coverity */
> > 
> > Why not printing an error message with errno there like you did in
> > the previous patch ?
> 
> Yeah, originally I didn't want to trigger false positives on automated CIs if 
> mkdir() failed just because the directory already exists. But OTOH 

mkdtemp() should buy you the directory doesn't exist.

> g_test_message() is just an info-level message, so it is Ok to bark silently 
> and I will add it.
> 
> > 
> > > +    }
> > > 
> > >      /* ensure test directory exists now ... */
> > >      g_assert(stat(local_test_path, &st) == 0);
> 
> Thanks!
> 
> Best regards,
> Christian Schoenebeck
> 
> 


