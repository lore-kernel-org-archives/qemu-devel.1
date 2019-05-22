Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36FC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 07:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3276720863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 07:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3276720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37793 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTLrO-0003j1-78
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 03:40:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hTLqV-0003IS-Jn
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hTLqU-000158-N7
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:39:31 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:47641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hTLqU-00013s-H3
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:39:30 -0400
Received: from player762.ha.ovh.net (unknown [10.109.159.35])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 318A419A1BD
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 09:39:27 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player762.ha.ovh.net (Postfix) with ESMTPSA id 9AEED608B9E7;
	Wed, 22 May 2019 07:39:17 +0000 (UTC)
Date: Wed, 22 May 2019 09:39:16 +0200
From: Greg Kurz <groug@kaod.org>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190522093916.43eb8677@bahia.lan>
In-Reply-To: <20190522061112.3accdb76@kryten>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
	<c1d2a4cf-a9a7-4dfa-ed80-987118043f08@ilande.co.uk>
	<20190522061112.3accdb76@kryten>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18207490344495782177
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.58.226
Subject: Re: [Qemu-devel] [Qemu-ppc]  [PATCH 4/9] target/ppc: Fix lxvw4x,
 lxvh8x and lxvb16x
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	richard.henderson@linaro.org, f4bug@amsat.org,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 06:11:12 +1000
Anton Blanchard <anton@ozlabs.org> wrote:

> Hi,
> 
> > I've now had a bit of time to look through this and I believe it is
> > correct, so:
> > 
> > Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>  
> 
> Thanks Mark. David: any chance we could get this merged? I can't run a
> recent Ubuntu image successfully without it. sshd hangs when I try to
> ssh into it.
> 

Ha ! I also had troubles ssh'ing into a fedora guest, but couldn't find
time to investigate:

$ ssh 192.168.122.76
ssh_dispatch_run_fatal: Connection to 192.168.122.76 port 22: incorrect signature

It doesn't happen anymore with this patch. Maybe worth mentioning it in the
changelog, and Cc stable of course since this is a regression in QEMU 4.0.

Tested-by: Greg Kurz <groug@kaod.org>

Also, as Mark mentioned in another mail, this looks very much like the other
bug I had fixed with 3e5365b7aa6c "target/ppc: Fix QEMU crash with stxsdx".
The patch looks correct:

Reviewed-by: Greg Kurz <groug@kaod.org>

> Thanks,
> Anton
> 


