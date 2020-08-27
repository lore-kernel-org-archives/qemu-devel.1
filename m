Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5833C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6D922CAE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0hsQ7/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6D922CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBG45-0008Fc-S0
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBG32-0007Gk-Ik
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:26:28 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:35344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBG31-000348-07
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:26:28 -0400
Received: by mail-io1-xd44.google.com with SMTP id s2so5427201ioo.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wiVq44xaI5lMEHpRW4cY2wbZWjxgkKYOPZ16WwudzpE=;
 b=J0hsQ7/dmCgjuLxL7UHi35rW7kzCoDfoJA4nH99CnCvOVOfaynw/kaKeuOOwjbAfiE
 voJ/REd0Blpn9CGdwcKeTekqben9wPArCmaE6NCQupe1tBGgBxPgRgZfqaikgLntdJ5a
 u7QIXv5nKM6di11IpcCr5+7QHGQPk84U3ySChFx72DGITiuHKhMIcFwDLIv8ZTA57xnM
 EFF0dNDrnCj0h3Ui26MfE48iFgcOKjvkWPOike+bhDDeZPG4E1tL33eDDI4MRMUrhv3K
 JkHPPWReKz44go6sPrudxhLNAD9JBBAVU/gYDPREOJvWE3MXcT9PeHD2oEXELZfExNnV
 ihbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wiVq44xaI5lMEHpRW4cY2wbZWjxgkKYOPZ16WwudzpE=;
 b=sYzgSdMR2zt+DLtWDdXpa5UueGMuLOPuCvBVjE2RICLXhek/ksVD4NYTP0jLiw6wvH
 zlEohkZI28Ef09e2XPFjwsRA7Aim7G0w20rqCbtn++eUFxNwZE5Lx5aFC8ZmQVvts2Xd
 QcepjKP0N0Tk2j7q8c1qKqqAQR632u/nr1s8PteXy3LO2d5+6pfKBscPXXAr+pq0Ytc5
 STnrfI9wyrVK955jYGK3QiJ18gAXSiReNn8rCmE6b1zFd9e4OJFh7jDnGcqpaqnfPUpN
 bhLJyV5bHQpTDxTRUth27aoRxpnC3J4wskhNthOSo2L9RbIvOKY/sKOHhaKsR2vb4jMj
 ifoA==
X-Gm-Message-State: AOAM531NnqmUSFdpZjrrkyRQ2mJwJI7SdBaUpkLEjrG8KwmXyWcPsttP
 9FgbvJl3SX6M3zsVKiVe60Qprquz3WC6Hw==
X-Google-Smtp-Source: ABdhPJwmmBdTbiSAS504JzPE5CLzgrnpDMZMJBqQRoDgvRV7iDBnWOaNreMJoqJ/M5F9dPZBIhHasg==
X-Received: by 2002:a63:f305:: with SMTP id l5mr13470173pgh.421.1598527194643; 
 Thu, 27 Aug 2020 04:19:54 -0700 (PDT)
Received: from [192.168.101.174] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id d8sm2105576pgt.19.2020.08.27.04.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 04:19:54 -0700 (PDT)
Subject: Re: [PATCH 00/77] target/microblaze improvements
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200827091128.GK2954729@toto>
 <1628c0ac-db22-ef9d-22e2-6a167ceaaf55@linaro.org>
 <20200827102217.GN2954729@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a787d85-a75f-60cf-0c99-a40c84222b35@linaro.org>
Date: Thu, 27 Aug 2020 04:19:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827102217.GN2954729@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.782,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 3:22 AM, Edgar E. Iglesias wrote:
> Thanks. Here's another issue, it seems some branches are jumping
> to the wrong address.
> 
> This is a disasm from a failing case:
> 
> 0x00000000ffd033a0:  brlid      r15, -636       // 0xffffffffffd03124
> 0x00000000ffd033a4:  or r0, r0, r0
> 
> 0x00000000ffa73124:  Address 0xffa73124 is out of bounds.

That's a weird one.

My guess is that IMM_FLAG is set in iflags incorrectly.
Can you verify this with -d in_asm,op,exec?

When IMM_FLAG is set, you'll see in in iflags: bit 0 will be set in the second
word of the insn_data.  E.g.:

 ---- 00000000ffd033a0 0000000000000001

It would also show up in the tb_flags of the exec lines.  E.g.

Trace 0: 0x7f38a4000940 [0000000000000000/0000000090000058/0]

where the format is host_pc [cs_base/pc/tb_flags].


If so, then we'll need to check where iflags got out of sync.


r~

