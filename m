Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C6AC33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADFC2085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADFC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io7fV-0003AV-Ax
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 10:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1io7ek-0002cY-8q
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 10:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1io7ej-0002Nr-0Y
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 10:17:29 -0500
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:60673)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1io7ei-0002Kz-RU
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 10:17:28 -0500
Received: from player788.ha.ovh.net (unknown [10.108.54.13])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 206C18A956
 for <qemu-devel@nongnu.org>; Sun,  5 Jan 2020 16:17:18 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 24DC0DE55485;
 Sun,  5 Jan 2020 15:17:10 +0000 (UTC)
Date: Sun, 5 Jan 2020 16:17:08 +0100
From: Greg Kurz <groug@kaod.org>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v18 1/7] Wrapper function to wait on condition for the
 main loop mutex
Message-ID: <20200105161708.6d4711b1@bahia.lan>
In-Reply-To: <20200102075111.25308-2-ganeshgr@linux.ibm.com>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
 <20200102075111.25308-2-ganeshgr@linux.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18302065936480835858
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdegkedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.91
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  2 Jan 2020 13:21:05 +0530
Ganesh Goudar <ganeshgr@linux.ibm.com> wrote:

> From: Aravinda Prasad <arawinda.p@gmail.com>
> 
> Introduce a wrapper function to wait on condition for
> the main loop mutex. This function atomically releases
> the main loop mutex and causes the calling thread to
> block on the condition. This wrapper is required because
> qemu_global_mutex is a static variable.
> 
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---

This should have your Signed-off-by: tag as well.

>  cpus.c                   | 5 +++++
>  include/qemu/main-loop.h | 8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/cpus.c b/cpus.c
> index b472378b70..79388d2b0f 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1835,6 +1835,11 @@ void qemu_mutex_unlock_iothread(void)
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
> index f6ba78ea73..a6d20b0719 100644
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


