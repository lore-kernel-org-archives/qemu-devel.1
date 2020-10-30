Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2238FC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6711520739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRenndN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6711520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWX8-0003T4-5y
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYWW7-0002Rf-6h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYWW4-0002CT-7K
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604072435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKCTkjgoWwLDFx1hoXgl39UPJ5hPteXPX0N7OIPqBMg=;
 b=XRenndN8LZNza66tcptyfuGyqb0JoCBpygLnf3L3KV3mv3sHMGaqg2+v9VNX6ITfeDqWBV
 PqDkHzgI6IsfNLWN+Wf4EblHggq6ArmFLwTgFDV1zXu0M4R6Y+aQhqJiNtpxejBjZmaxDQ
 QPhz+3L7ny4ceDT46pRqMyvge/te2E8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-ezwwrsxWOwy_qMUYCe00dg-1; Fri, 30 Oct 2020 11:40:31 -0400
X-MC-Unique: ezwwrsxWOwy_qMUYCe00dg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C1EE87950C;
 Fri, 30 Oct 2020 15:40:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-87.ams2.redhat.com [10.36.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A2571000320;
 Fri, 30 Oct 2020 15:40:27 +0000 (UTC)
Subject: Re: [PATCH v2 3/8] accel/tcg/user-exec: silence the compiler warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
 <20201030004046.2191790-4-kuhn.chenqun@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <820857af-e8da-e664-bb39-502ce96146a6@redhat.com>
Date: Fri, 30 Oct 2020 16:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201030004046.2191790-4-kuhn.chenqun@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/10/2020 01.40, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> ../accel/tcg/user-exec.c: In function ‘handle_cpu_signal’:
> ../accel/tcg/user-exec.c:169:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   169 |             cpu_exit_tb_from_sighandler(cpu, old_set);
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../accel/tcg/user-exec.c:172:9: note: here
>   172 |         default:
> 
> Mark the cpu_exit_tb_from_sighandler() function with QEMU_NORETURN to fix it.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> v1->v2: Add QEMU_NORETURN to cpu_exit_tb_from_sighandler() function
> to avoid the compiler warnings(Base on Thomas's and Richard's comments).
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/user-exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 4ebe25461a..293ee86ea4 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -49,7 +49,8 @@ __thread uintptr_t helper_retaddr;
>  /* exit the current TB from a signal handler. The host registers are
>     restored in a state compatible with the CPU emulator
>   */
> -static void cpu_exit_tb_from_sighandler(CPUState *cpu, sigset_t *old_set)
> +static void QEMU_NORETURN cpu_exit_tb_from_sighandler(CPUState *cpu,
> +                                                      sigset_t *old_set)
>  {
>      /* XXX: use siglongjmp ? */
>      sigprocmask(SIG_SETMASK, old_set, NULL);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


