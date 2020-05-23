Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32306C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 17:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A4620849
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 17:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="lJ0KOGJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A4620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcXqj-00065C-3u
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 13:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcXpg-0004wl-V9
 for qemu-devel@nongnu.org; Sat, 23 May 2020 13:21:12 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:37499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcXpg-0006jI-63
 for qemu-devel@nongnu.org; Sat, 23 May 2020 13:21:12 -0400
Received: by mail-qv1-xf41.google.com with SMTP id z5so6258733qvw.4
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 10:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=d1zMmnxOd6fpGRM8D+tuITKQhXzxateNvqbWqGl+uCk=;
 b=lJ0KOGJsEA/45aQgQUxsYvY8GLJ5Z4cn12VTOSHD+2pitx+cEBDgTkZ3ENd9QtQcoP
 rqSyekuRI0ChO6bBVOnNamLVI4htX03vbD+DNkh97KTcLpHZnB+J0n20z77r29lM4isE
 qzzh+hEkrW1rV1HTvGIIdAsKdAyJJ9aZECxvYKeh1zRCoSkM2+wWRw+vyn1wD+M+vAYL
 uYTvIe5AH4gvxQ8xtGymiUxm56beGEBgr52Uhf3SRaUFVy265to9mBjBdhHAwaR2eZL8
 g92VZeEGsDeDuIlFZvjs8ralolAzoUqf/LpHM2HwSyLrBmSs7J1smrYtv8rm/Qf/cFTd
 O5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d1zMmnxOd6fpGRM8D+tuITKQhXzxateNvqbWqGl+uCk=;
 b=mLD2bgpidCBVP89M25ZNKtZf3nSlA0lp/29M8mAu4COblWJ4VNr7xtnjloXa5tnMYZ
 vaypAhrv2ZGBYKTneANuFumgfLBpgBTi8VnnColNAQsuCpMDJxLTnttzCdarvUQ4gShx
 5FWVJ7IUu4hiP1uH1nz6Jv8CI7gcGTxyd9+dIgsXd31Zzp5uwg9YK0eAkbO/SLwLMlsY
 xqeIKy+S5v2zCJnchRDPXtQNZZhcgPBODO0eOj3my8kX4Ed1jtEPTaQHmnCSylBNIqhE
 FCd7/xRKKlOr/EDcincMgQTFsthieGQjWZRbD/p1A+oLSyk/g2d6skTmZNrAi0SJxanB
 jiqw==
X-Gm-Message-State: AOAM530XgEzF21T7vTcn9i3DmidaW+oNL4CjByp5uwGj+6uEr5w+xOkc
 uXKHoBf6VNTwXiK9UDGSwP2Ayw==
X-Google-Smtp-Source: ABdhPJwAR3C2niejzdG3pKVvnQ1zpmIVQE0EUMQp+cjvazixOtiMP/dKw5rmfqKeSLGAb8jaN8NpEA==
X-Received: by 2002:a0c:ee25:: with SMTP id l5mr8651566qvs.5.1590254471311;
 Sat, 23 May 2020 10:21:11 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id h13sm11195690qti.32.2020.05.23.10.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 10:21:10 -0700 (PDT)
Date: Sat, 23 May 2020 13:21:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 11/19] accel/tcg: Fixed tsan warnings related to
 parallel_cpus
Message-ID: <20200523172110.GC382220@sff>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-12-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522160755.886-12-robert.foley@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::f41;
 envelope-from=cota@braap.org; helo=mail-qv1-xf41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 12:07:47 -0400, Robert Foley wrote:
> Fixed several tsan warnings. e.g.
> 
> WARNING: ThreadSanitizer: data race (pid=35425)
>   Read of size 1 at 0x557cd83aee28 by thread T7:
>     #0 curr_cflags include/exec/exec-all.h:460:13 (qemu-system-aarch64+0x4b7f27)
>     #1 cpu_exec accel/tcg/cpu-exec.c:730:26 (qemu-system-aarch64+0x4b7f27)
>     #2 tcg_cpu_exec cpus.c:1415:11 (qemu-system-aarch64+0x45b9b6)
>     #3 qemu_tcg_cpu_thread_fn cpus.c:1723:17 (qemu-system-aarch64+0x45b9b6)
>     #4 qemu_thread_start util/qemu-thread-posix.c:519:9 (qemu-system-aarch64+0xd431e0)
> 
>   Previous write of size 1 at 0x557cd83aee28 by thread T6:
>     #0 cpu_exec_step_atomic accel/tcg/cpu-exec.c:254:23 (qemu-system-aarch64+0x4b6caa)
>     #1 qemu_tcg_cpu_thread_fn cpus.c:1741:17 (qemu-system-aarch64+0x45baca)
>     #2 qemu_thread_start util/qemu-thread-posix.c:519:9 (qemu-system-aarch64+0xd431e0)
> 
>   Location is global 'parallel_cpus' of size 1 at 0x557cd83aee28 (qemu-system-aarch64+0x000001fb3e28)
> 
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.

