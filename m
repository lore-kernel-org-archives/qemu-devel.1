Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94EC00523
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 02:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135B1215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 02:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+5ViJE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135B1215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioHwc-0004M2-8z
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 21:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ioHvY-0003g8-JJ
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 21:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ioHvX-00042w-8O
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 21:15:32 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ioHvW-0003y6-WB
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 21:15:31 -0500
Received: by mail-pf1-x443.google.com with SMTP id i6so19385353pfc.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 18:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XP2hNmKzUX3IBbM3eIgKOH1z6Rf1aNz0lhFQuUULG28=;
 b=L+5ViJE/plrN7/Mb02cYU3on+MSMjvXFum9iBNLG4cSZVc98RsAx+t0+giOH/7vxnY
 Io2ZFBtPuUSXbxkjuzrZRNncANRyBvpp0mVHnu4duv2JSIelA1qhLc/4WnbJf87Krq06
 s3iXcDm4nLInqAbd3ZK24/2jVdeYpr5X//LrhliNCvurrUr4FMiAbRpBBoCWF30uknZn
 +i4HoE7zTRx0CEUX8RmzjV7obcpImGDRiYSJp/mDh/vSnl3DOKbF9cCOn+0SS61LgUmP
 bpcuNHcNv3yLIitYkqU3BSa+ssgQSbyH7E0M9y294F9n2sJ0ONmKfTnDXXg5a42tsymM
 5DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XP2hNmKzUX3IBbM3eIgKOH1z6Rf1aNz0lhFQuUULG28=;
 b=nxsIv6kwNhZ1soUdlK8hvHqt+xlsLkb/d2Co+33OQsdewULGzk8HtWNZSPdK8jIY5x
 bc0YfwGyFidI5g/SxOWedycE/qzo781D/zk8ebAMsU3XzYHItJ0utdXUTiqqP8IlHbsi
 7v68/WndBEz90ww2Z543g52lW+zf3yfx6EN8cE04Zs5NloJXx9wQmqDaQ0PWKYzNVr/U
 tz6/k/cKoV8jlwhjA5qeTDlQrn4znGNUdBXt/9OLOWb3+0CtmWwROmi5fizjL+llAjTf
 gphy4/KJyOp9HqP5A7Z76ijD0IzD23dC65QTHoMud/KDGPiWC2Sqf0TAktbyl7Tjfn9S
 w4gA==
X-Gm-Message-State: APjAAAV/aTL5yWKPE+WpVA45zuCwjIf9cEF5bL31COkn7UKU3CY/U9Jz
 MeKCJeRbVziZ+zrxYWc/TAvRcg==
X-Google-Smtp-Source: APXvYqzm/I8hj2u5w/XYgHGzZIr6n8dwIqvbWjJ4C8k8SWV87E9RhpMQLnIDrk/G2Bdkz5g2p6hTFw==
X-Received: by 2002:a63:5b59:: with SMTP id
 l25mr110928350pgm.382.1578276929620; 
 Sun, 05 Jan 2020 18:15:29 -0800 (PST)
Received: from ?IPv6:2001:44b8:2176:c800:f1c3:9f9c:2e9f:1ebd?
 (2001-44b8-2176-c800-f1c3-9f9c-2e9f-1ebd.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:f1c3:9f9c:2e9f:1ebd])
 by smtp.gmail.com with ESMTPSA id z6sm60618257pfa.155.2020.01.05.18.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2020 18:15:28 -0800 (PST)
Subject: Re: [PATCH] arm/translate-a64: fix uninitialized variable warning
To: pannengyuan@huawei.com, peter.maydell@linaro.org
References: <20200106015700.52992-1-pannengyuan@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <69ee9eb1-84bf-5bcc-738c-c75dd520cbf2@linaro.org>
Date: Mon, 6 Jan 2020 12:15:22 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106015700.52992-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 qemu-arm@nongnu.org, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/6/20 11:57 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Fixes:
> target/arm/translate-a64.c: In function 'disas_crypto_three_reg_sha512':
> target/arm/translate-a64.c:13625:9: error: 'genfn' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> qemu/target/arm/translate-a64.c:13609:8: error: 'feature' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     if (!feature) {
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Cc: Peter Maydell <peter.maydell@linaro.org> 

Are you compiling with reduced optimization?  The compiler should be able to
prove that these variables are initialized.  It certainly does with -O2, on all
known gcc versions.

Perhaps a better fix is to add a

    default:
        g_assert_not_reached();

entry to the o == 0 switch.  Though of course opcode must be in [0-3], based on
the extraction mask, so a default label isn't actually reachable.  But that's
the only path I can see for which incomplete optimization would fail to prove
initialization.


r~

