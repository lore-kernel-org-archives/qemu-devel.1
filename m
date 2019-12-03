Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE67C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CDA20659
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CDA20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic5ZO-0006Xa-Cd
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 05:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ic5WK-0005Yw-Ka
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ic5WI-000759-6y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:35:03 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:36765)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ic5WH-0006lJ-U3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:35:02 -0500
Received: from player774.ha.ovh.net (unknown [10.108.35.131])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 8E3951B0F96
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 11:34:56 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id D3D9ACD3643D;
 Tue,  3 Dec 2019 10:34:50 +0000 (UTC)
Date: Tue, 3 Dec 2019 11:34:49 +0100
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtfs-proxy-helper: switch from libcap to libcap-ng
Message-ID: <20191203113449.4b2e129e@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191129135937.74a9b264@bahia.w3ibm.bluemix.net>
References: <20191129111632.22840-2-pbonzini@redhat.com>
 <20191129133241.738b70ed@bahia.w3ibm.bluemix.net>
 <4e49ea13-fe0c-2b06-052e-474d714b88ad@redhat.com>
 <20191129135937.74a9b264@bahia.w3ibm.bluemix.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4201858455046887886
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.181.248
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
Cc: Thomas Huth <thuth@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 13:59:37 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 29 Nov 2019 13:49:20 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 29/11/19 13:32, Greg Kurz wrote:
> > > Nice. :)
> > > 
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > 
> > > Paolo,
> > > 
> > > I can take this through my 9p tree if you want. Otherwise,
> > > 
> > > Acked-by: Greg Kurz <groug@kaod.org>
> > 
> > Yes, please do it since it's self-contained.  You'd probably also test
> > it better than me. :)
> > 
> > Paolo
> > 
> 
> Ok I'll just do that then.
> 

And it happens to be missing an extra-change in Makefile :)

-fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
+fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap-ng

I've fixed this up in my tree.

> Cheers,
> 
> --
> Greg


