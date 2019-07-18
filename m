Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD45C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D7A21783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D7A21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3qe-0006Vq-6o
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1ho3qH-0005Qr-OL
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ho3qG-000167-Kk
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:53 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:56188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ho3qG-00014X-CD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:52 -0400
Received: from player774.ha.ovh.net (unknown [10.108.35.131])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id CC26720C0A0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 12:40:49 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id 9CA5080F0DA5;
 Thu, 18 Jul 2019 10:40:44 +0000 (UTC)
Date: Thu, 18 Jul 2019 12:40:42 +0200
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190718124042.4dd7b132@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <9587706e-d53c-5490-cb4a-4c89eadfc497@ozlabs.ru>
References: <20190716053522.78813-1-aik@ozlabs.ru>
 <8b727864-1634-0a5d-c557-fcaa52c49434@redhat.com>
 <9587706e-d53c-5490-cb4a-4c89eadfc497@ozlabs.ru>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5526198218723269109
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.165.232
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH qemu] spapr: Stop providing
 RTAS blob
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

On Thu, 18 Jul 2019 17:55:12 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> 
> 
> On 18/07/2019 17:20, Thomas Huth wrote:
> > On 16/07/2019 07.35, Alexey Kardashevskiy wrote:
> >> SLOF implements one itself so let's remove it from QEMU. It is one less
> >> image and simpler setup as the RTAS blob never stays in its initial place
> >> anyway as the guest OS always decides where to put it.
> >>
> >> This totally depends on https://patchwork.ozlabs.org/patch/1132440/ ,
> >> hence RFC.
> > 
> > Patch looks basically fine for me, but I wonder whether we should wait
> > for one or two releases until we really remove it from QEMU, so that it
> > is still possible to test the latest QEMU with older SLOF releases for a
> > while (which is sometimes useful when hunting bugs). Or should this
> > maybe even go through the official deprecation process (i.e. with an
> > entry in qemu-deprecated.texi)?
> 
> I worry more about slof being distributed as a separate package in RHEL, 
> easy enough to get qemu/slof out of sync.
> 

Then it seems to call for keeping the code around in QEMU in case RHEL's
slof doesn't implement the RTAS blob. Following the official deprecation
process looks like a good option IMHO.

> 


