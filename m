Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A442076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A442076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XH1-0001MS-VW
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k5XGM-0000Xo-80; Tue, 11 Aug 2020 12:36:34 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:57967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k5XGJ-0001hq-Kw; Tue, 11 Aug 2020 12:36:33 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.124])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 527634F7CF4C;
 Tue, 11 Aug 2020 18:36:27 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 11 Aug
 2020 18:36:26 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00590243214-7802-4537-a90f-ec6bf2dd1f1f,
 21410A4A3A6052EE44A78CBD9556F34A390CB301) smtp.auth=groug@kaod.org
Date: Tue, 11 Aug 2020 18:36:25 +0200
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 2/2] spapr/nvram: Allocate enough space for all
 -prom-env options
Message-ID: <20200811183625.099e03ad@bahia.lan>
In-Reply-To: <17a888a8-1264-f072-a044-6315a6488049@redhat.com>
References: <159715979684.1635409.14107632395902701971.stgit@bahia.lan>
 <159715981316.1635409.16117540313443167075.stgit@bahia.lan>
 <17a888a8-1264-f072-a044-6315a6488049@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: e02ebca2-5639-47c0-b652-bd6c81d90fe1
X-Ovh-Tracer-Id: 14486672629506611619
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrledtgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 12:36:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 18:05:21 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 11/08/2020 17:30, Greg Kurz wrote:
> > Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
> > support the -prom-env parameter"), pseries machines can pre-initialize
> > the "system" partition in the NVRAM with the data passed to all -prom-env
> > parameters on the QEMU command line.
> > 
> > In this cases it is assumed that all the data fits in 64 KiB, but the user
> > can easily pass more and crash QEMU:
> > 
> > $ qemu-system-ppc64 -M pseries $(for ((x=0;x<128;x++)); do \
> >   echo -n " -prom-env "$(for ((y=0;y<1024;y++)); do echo -n x ; done) ; \
> >   done) # this requires ~128 Kib
> > malloc(): corrupted top size
> > Aborted (core dumped)
> > 
> > Call chrp_nvram_create_system_partition() first with its recently added
> > parameter dry_run set to false, to know the required size and allocate
> > the NVRAM buffer accordingly.
> > 
> > Fixes: 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to support the -prom-env parameter")
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/nvram/spapr_nvram.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> > index 992b818d34e7..1b74bec6200a 100644
> > --- a/hw/nvram/spapr_nvram.c
> > +++ b/hw/nvram/spapr_nvram.c
> > @@ -165,6 +165,10 @@ static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
> >          if (ret < 0) {
> >              return;
> >          }
> > +    } else if (nb_prom_envs > 0) {
> > +        nvram->size = chrp_nvram_create_system_partition(NULL,
> > +                                                         MIN_NVRAM_SIZE / 4,
> > +                                                         true);
> 
> I think this will break the migration: the prom-env parameters can be on
> the source side without being on the dest side. And so the pram size

Huh ? Migration mandates to have the same arguments on the command line,
and libvirt buys us that AFAIK or am I missing something ?

> will differ and the migration will fail.
> 
> Thanks,
> Laurent
> 


