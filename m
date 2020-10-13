Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92285C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C30247C6
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C30247C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKyv-00028L-1x
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSKx8-0000S4-3F
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:06:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:52846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSKx6-0006Qk-G1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:06:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 28165AB91;
 Tue, 13 Oct 2020 14:06:53 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] accel: Remove _WIN32 ifdef from qtest-cpus.c
To: Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org
References: <20201013140511.5681-1-jandryuk@gmail.com>
 <20201013140511.5681-2-jandryuk@gmail.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <8e3d56e5-f2de-0e93-4f7a-6f51a96a5fd8@suse.de>
Date: Tue, 13 Oct 2020 16:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013140511.5681-2-jandryuk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 4:05 PM, Jason Andryuk wrote:
> dummy-cpus.c is only compiled with CONFIG_POSIX, so the _WIN32 condition
> will never evaluate true.  Remove it.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
> v2: New in v2
> ---
>  accel/qtest/qtest-cpus.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/accel/qtest/qtest-cpus.c b/accel/qtest/qtest-cpus.c
> index 7c5399ed9d..db094201c1 100644
> --- a/accel/qtest/qtest-cpus.c
> +++ b/accel/qtest/qtest-cpus.c
> @@ -29,10 +29,6 @@
>  
>  static void *qtest_cpu_thread_fn(void *arg)
>  {
> -#ifdef _WIN32
> -    error_report("qtest is not supported under Windows");
> -    exit(1);
> -#else
>      CPUState *cpu = arg;
>      sigset_t waitset;
>      int r;
> @@ -69,7 +65,6 @@ static void *qtest_cpu_thread_fn(void *arg)
>      qemu_mutex_unlock_iothread();
>      rcu_unregister_thread();
>      return NULL;
> -#endif
>  }
>  
>  static void qtest_start_vcpu_thread(CPUState *cpu)
> 
Reviewed-by: Claudio Fontana <cfontana@suse.de>

