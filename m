Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA55C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9B22067C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfSMN0EW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9B22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD0g1-0007Ef-3D
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 02:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0fM-0006nv-QD
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0fH-0007Bk-Ko
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:52:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD0fH-00075K-Bj
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:52:55 -0400
Received: by mail-pl1-x642.google.com with SMTP id w3so5369040plz.5
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4KuKDkIqQC/omjXP8z/3uo2FpKZuXa2d25HGbtXyIH4=;
 b=GfSMN0EWNwN/ddkImNWhMncAuLps5opEsCQ2rGk1nmaDZUb7x+1AD3KQNmkM+ZJmt7
 ckFxb/5ZMOEgoiuGTxMyjCm+eubhzGLNJuefttt+o5jv/LjfVasaD4fcL0rtdFjXEJba
 fiLZovVUmJP7ZZnehyCgqkrETG+raLeydiH1xI3HUl9ZaYm9hvJn03ZH8eZnEJeclECf
 Xt8FjWf5RjKKHhvJ/QKNOWmD9WqE7FBws0GUoHJ42mNz4tS8g9UpjQyHJp0dhW+ymeQj
 tT0RvhktUkRK0LuFhrHwWAUPwL8xJtkgbdt4t2MgPYbaXY0JX+IZJ3vdMki4unq8Zqk6
 qNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4KuKDkIqQC/omjXP8z/3uo2FpKZuXa2d25HGbtXyIH4=;
 b=JpKKKH3HoqeuHrDHRKBqyGQM+8h6L4AFZJArSWWdSdSJNtxsjnTXSw4AZKf5QWGic0
 ZbD7/1PE3042t59K7gXJ1zCt8/fm3E2eTXA6t6R6edHTHdTvAcis4BAeyTN3ObzQ4NAI
 9HTYSw1BAJP2XQ2qyNd7/6M/wUuF4tanbLdhO5yZ+LIguOfJMZizpCgyb8k2wlHvekcb
 zxMVMhbzx/r9+KvTiDbAMYR4yQbMYIscxAYySFtHuUfHaoMqUiDLM4cmv4zaWJf1lycl
 jnzvsaq72i/K0VspdyeKEPB/P3Q/I1348nGjG+0dZ19SYSNcM0wooIrfRgk+xMdy6Nv4
 7nzg==
X-Gm-Message-State: ANhLgQ3fp8i3f2jCIZ96ye7BZ+rhgseHmwATMMSuf7EfTk/SQN8hoBCu
 7mimL7j/jVDtlQoq8e90ZWZZhQ==
X-Google-Smtp-Source: ADFU+vsrKRsiw48qMw5ivE/kj5ahWsjpMI8Ze34GoWgteF7cYSmhN6C3gOZcoko1ZLe5rT/4F+ObSQ==
X-Received: by 2002:a17:902:7796:: with SMTP id
 o22mr16046428pll.250.1584168774210; 
 Fri, 13 Mar 2020 23:52:54 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i2sm23118855pfr.151.2020.03.13.23.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 23:52:53 -0700 (PDT)
Subject: Re: [PATCH v5 17/60] target/riscv: vector single-width integer
 multiply instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-18-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e35d894d-30a4-dfbd-72ff-f33d70d4f9a0@linaro.org>
Date: Fri, 13 Mar 2020 23:52:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-18-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +static int64_t do_mulhsu_d(int64_t s2, uint64_t s1)
> +{
> +    uint64_t hi_64, lo_64, abs_s2 = s2;
> +
> +    if (s2 < 0) {
> +        abs_s2 = -s2;
> +    }
> +    mulu64(&lo_64, &hi_64, abs_s2, s1);
> +    if ((int64_t)(s2 ^ s1) < 0) {

Why would the sign of s1 be relevant?
It's always unsigned.

We have code for this in e.g. tcg_gen_mulsu2_i64

    mulu4(&lo, &hi, s1, s2);
    if ((int64_t)s2 < 0) {
        hi -= s2;
    }


r~

