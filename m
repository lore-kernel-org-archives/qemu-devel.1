Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB7EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 23:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50071223C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 23:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ip4AE/Ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50071223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka5Kx-00070C-DN
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 18:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka5KA-0006YG-Ad
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 18:02:46 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka5K8-0001aq-JJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 18:02:45 -0500
Received: by mail-pg1-x544.google.com with SMTP id f38so14914971pgm.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 15:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M9u6/n3m6Sg1GrEP4CakoxmHi05Ui82QASF0dVuVCq0=;
 b=Ip4AE/EiWxGZiP1YSG8BoojV0KLDL54+AmV7dZgcExfTcT3VtdQxLeMBD8fTX/medS
 pT/UC6WSiKBY3QQz5QMy+LCmWFJJ3Ni4DSv9lmXwu2gVWcUe/2hNWLDVrAp4+NDRrxCZ
 vMkeq8rxOY17OvOqxMRo739Wp0ZaTyx6ln63QCFh1TvTGuj3ejE+e4Ex2IvzSdK4nLfA
 8b/xt18mTPV4C61J7rc3+2R8+KTQ7+L31YTt8hU3yg7In0cetbwZ61qvjc3fby0wL1g7
 CckFpDYzzmH27Jg1WIsGkzogm2aghFtMXBnPwoay9+trx4Won1SfhpPsCR+bOFbAvRiX
 a+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M9u6/n3m6Sg1GrEP4CakoxmHi05Ui82QASF0dVuVCq0=;
 b=r3u39B4z0LJoLxoSxr/cEbHXK087ExBvsj93teE12bcDoI5tpIADbW8Z6GOhxjFbDs
 6dzwieVhbnmYPpkaqi9s5u1+ZX540aFtg/ErT4VQf2sji/o7c0ZD8BVWVMFd1MHKIR4L
 iMiP68+5or77jK0JpTou3HZtBwHeSNjUwxALTODADjn4N1ABd68db2v/6JgI6nTnAqId
 mSdPiT9F/gbwy4RAaDPELhKjkE36XReCsnrMeYR4QUQTiZFKvq53fPx8if+6lXBNKIIy
 Js4UoGzrMX0TdyyIJ3SE0+76owMO42Qx2stTVRdMhOFC9JJGKG4Ul/rS07XkCFtkneSR
 3Tqg==
X-Gm-Message-State: AOAM5335dYelEvXtL8EI4HI6e0dx9ZuVgoPRGxOgQx4CgvEitYWvnZPF
 muWZofWRWJwZfDMDMj3muwWEniaesXdVcg==
X-Google-Smtp-Source: ABdhPJwvT5bbM+uV3CTZPxAuQhbxsNTYmpO9FISk3DZDyVOi8sERYC6sj1O9Ws3FLNx5p/HRxhiJoA==
X-Received: by 2002:a62:d459:0:b029:18b:12eb:7755 with SMTP id
 u25-20020a62d4590000b029018b12eb7755mr7961684pfl.79.1604444562446; 
 Tue, 03 Nov 2020 15:02:42 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id a184sm169446pfa.86.2020.11.03.15.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 15:02:41 -0800 (PST)
Subject: Re: [PATCH v2 01/19] tcg: Enhance flush_icache_range with separate
 data pointer
To: Joelle van Dyne <j@getutm.app>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
 <20201030004921.721096-2-richard.henderson@linaro.org>
 <CA+E+eSCn=NjEWrGngmgQtk+robNxL01Ksu7T6nBUNXEg90yvsQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e6a71372-68e1-7ee5-4c86-3394d7d10fa2@linaro.org>
Date: Tue, 3 Nov 2020 15:02:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+E+eSCn=NjEWrGngmgQtk+robNxL01Ksu7T6nBUNXEg90yvsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/31/20 11:54 PM, Joelle van Dyne wrote:
> s->code_ptr and s->code_buf are 4 byte pointers on aarch64 so the
> cache flush is off by a factor of 4
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 44b923f5fe..2c4b66965b 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4325,7 +4325,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
> 
>      /* flush instruction cache */
>      flush_idcache_range((uintptr_t)tcg_mirror_rw_to_rx(s->code_buf),
> -                        (uintptr_t)s->code_buf, s->code_ptr - s->code_buf);
> +                        (uintptr_t)s->code_buf,
> +                        (uintptr_t)s->code_ptr - (uintptr_t)s->code_buf);

Yep, thanks.


r~

