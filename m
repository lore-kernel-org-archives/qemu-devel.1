Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ADCC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D26721479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D26721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5Nq-0006GO-Ap
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:16:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hP5Ml-0005GS-QN
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hP5Mj-0008GL-Tv
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:15:11 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:59205)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hP5Mi-0008Dy-GL
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:15:09 -0400
Received: from player787.ha.ovh.net (unknown [10.109.146.19])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id ACB9916F87A
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 15:15:03 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
	(Authenticated sender: groug@kaod.org)
	by player787.ha.ovh.net (Postfix) with ESMTPSA id 832D55B7C245;
	Fri, 10 May 2019 13:14:51 +0000 (UTC)
Date: Fri, 10 May 2019 15:14:49 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190510151449.68d656d0@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <155591658718.20338.10108476276907741991.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591658718.20338.10108476276907741991.stgit@aravinda>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8742894255625443732
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeekgdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.205
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 2/6] Wrapper function to wait
 on condition for the main loop mutex
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Apr 2019 12:33:07 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> Introduce a wrapper function to wait on condition for
> the main loop mutex. This function atomically releases
> the main loop mutex and causes the calling thread to
> block on the condition. This wrapper is required because
> qemu_global_mutex is a static variable.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  cpus.c                   |    5 +++++
>  include/qemu/main-loop.h |    8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/cpus.c b/cpus.c
> index e83f72b..d9379e7 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1858,6 +1858,11 @@ void qemu_mutex_unlock_iothread(void)
>      qemu_mutex_unlock(&qemu_global_mutex);
>  }
>  
> +void qemu_cond_wait_iothread(QemuCond *cond)
> +{
> +    qemu_cond_wait(cond, &qemu_global_mutex);
> +}
> +
>  static bool all_vcpus_paused(void)
>  {
>      CPUState *cpu;
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index f6ba78e..a6d20b0 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -295,6 +295,14 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line);
>   */
>  void qemu_mutex_unlock_iothread(void);
>  
> +/*
> + * qemu_cond_wait_iothread: Wait on condition for the main loop mutex
> + *
> + * This function atomically releases the main loop mutex and causes
> + * the calling thread to block on the condition.
> + */
> +void qemu_cond_wait_iothread(QemuCond *cond);
> +
>  /* internal interfaces */
>  
>  void qemu_fd_register(int fd);
> 
> 


