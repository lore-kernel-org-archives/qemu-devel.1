Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85BAC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CD220661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vN17DgH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CD220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyE8-00081R-L6
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVy87-0001uC-Ei
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:01:03 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVy82-0002ci-UM
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:01:02 -0400
Received: by mail-pl1-x644.google.com with SMTP id v2so850318plp.9
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D2mBVlnpvVYcF4KObf8GAsSOgtsOhe3PMdTj4MtMF2I=;
 b=vN17DgH7myYytRFcaLnzNj24WClrwW+RJrr+6Spq7JG5MMo6dVcYHORH2/Ux5eKC3F
 Ul7/LbH/CPXA8sgWJs9WZ6wbVP+074T8m3sNsrvUkYhkESt3uNY30XT0PUDOJFeHRH7q
 8tt2/wnkXe8E+DOnD4lNhpwUP5jnSKDCNMkF8oie3tBQYHG8U/NYIQTlMlguVec7pdaE
 blHI/7qJ51tekKaFffgFOrQ3ek0rmk2jKzA+8LThLnOpvBGiyY2IrlBHwxKRgvmOOwlh
 TbgI3R7aBI9nU1tZzfB0ZttsQE6LCAqgGKHxQaJaO13D8sDu7OdmNv01iLWTIEbCkgjV
 hHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D2mBVlnpvVYcF4KObf8GAsSOgtsOhe3PMdTj4MtMF2I=;
 b=lONLggqn0MOkHiGfEdIsKR94SF3Ed/B0aAObdNGamzkFUTHDNJ9i1pg7hbyFtRyqLe
 u/Pq/Eb9bC84qPiMEJB25C51ObXKdawYvTD+8GQvKwaGhMT5BztyXVv8ibc7H+hmDhKC
 MBjhdR8z5b4H7jG4M/K7iNIWjjKnaCEgOL3PmvMICaRYhLsygIApWfn2ryNupuy8INQ6
 yDHf2FEKenwewp8JBlzlFFqIe8OFe5r+VaHiDTVdZMIYZF3FJQWpLuoSYDiGOkmgFk4u
 5KuPL2MurESy8qpA7JlwdA4y6gFevs95lNA33Xpnqpr9j4txhYZ1jXYHMEnjVhzydIbK
 YfdQ==
X-Gm-Message-State: AGi0PuY+VQjud/U8gBOZibSnBec57KQJAABk1AU42K3HA57HuLVN8dr/
 sI5UGngv1zBzzleYC4ZCnNIj2B2adPk=
X-Google-Smtp-Source: APiQypJVGTXsDFH4aWjJxTruJak85U5iEnJ2mvEvSyeEvRBSURPvuPBE8HLPMzQecQQ7G0hgC6IrHQ==
X-Received: by 2002:a17:90a:21ee:: with SMTP id
 q101mr3338085pjc.24.1588687256592; 
 Tue, 05 May 2020 07:00:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id nm22sm2123823pjb.38.2020.05.05.07.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 07:00:55 -0700 (PDT)
Subject: Re: [PATCH v2 00/15] target/arm: partial vector cleanup
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
 <CAFEAcA-fbQwjU3_UuorV3q-k9exr9f_uqO_YSP7aggsm=oP=wg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7825f17f-2306-7b07-b65c-60d87db48137@linaro.org>
Date: Tue, 5 May 2020 07:00:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-fbQwjU3_UuorV3q-k9exr9f_uqO_YSP7aggsm=oP=wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 3:38 AM, Peter Maydell wrote:
> This doesn't apply on master any more as a result of the
> first lump of decodetree stuff going in. Also patch 2
> doesn't seem to compile:
> 
> /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c: In
> function ‘gen_gvec_srshr’:
> /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:4107:9:
> error: implicit declaration of function ‘tcg_gen_gvec_dup_imm’; did
> you mean ‘tcg_gen_gvec_dup_i64’?
> [-Werror=implicit-function-declaration]
>          tcg_gen_gvec_dup_imm(vece, rd_ofs, opr_sz, max_sz, 0);
>          ^~~~~~~~~~~~~~~~~~~~
>          tcg_gen_gvec_dup_i64
> /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:4107:9:
> error: nested extern declaration of ‘tcg_gen_gvec_dup_imm’
> [-Werror=nested-externs]
> 
> Any chance you could do a rebase and resend?


Ah yes, it seems built on top of tcg-next.  Time for a pull there too, lest
this have to get changed yet again.


r~

