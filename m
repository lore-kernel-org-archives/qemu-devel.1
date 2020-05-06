Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97A4C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A7820714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvtBSWBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A7820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIe8-0003Pg-Sd
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 07:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWId7-0002cJ-E0; Wed, 06 May 2020 07:54:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWId6-0000Yn-Ox; Wed, 06 May 2020 07:54:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id s8so1839268wrt.9;
 Wed, 06 May 2020 04:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R1U0sR42CISSUoea7dyb4TX1tmhWDowAmtdQvinMREo=;
 b=AvtBSWBx7pqdlUjoRRdjW/lQfpVvzARl10xRzI7BW876BPFy6X0lISRlIfzW57ydUz
 WLcKFCMTXYS72aOEIGZ6ZefKy4DWYNJzf4JbdK4mjz5ZUGca/ZLHK2hnxwtH4P+QzcOm
 y2NVqMkvieZn45dO0zjP0jx8dk/qtKZKZi9wp0dR62UGOpWHmyy2+UorD3eo5nlG5woV
 7FS3FD6yb5HQWOypNZxOafnxb5O0gKq4PY9ucTuu70seq6XhTRlxqBTIuoeASz9L4H4Q
 49/c1CZLrIOnaGJqNDJeaz+Yk7+U5F4/+o92ujFkEvlK6XDxM4L+oZpVdQtLMCHidXaK
 dg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R1U0sR42CISSUoea7dyb4TX1tmhWDowAmtdQvinMREo=;
 b=HS3dQp+nHiGLOMILfePavME73quG99WLoMZPeocZxWdxI7BGS83wtVGtBhkEkafVZW
 6/PpVddsDr90Op5/+Q0cCQt+ZRtIlNkdLdIvxFI99u+AKtAdfADORrAO73PzgrQeOdQR
 Md5C3NtctWxOFkTcBkgT8TN3++Yt4Hxv+CAIOqrUhDpDda1lCM2RgorwzQFBjAX9vLY4
 Bnj3I3OKKRXn/GCTV4VmCC4tHcbYdfbbNAaLNt0O7pl3B8MH33cZw9hvIOJG+Z57NssV
 NuVrhWFmexjiSRmfOgXI/W2plSoSQYog03RnPt1RaU3S3SIhPuWArou3zY3nUpkh5gck
 DVHw==
X-Gm-Message-State: AGi0Pua3iVYR/BcsRkQFkY/OuhSZYCn1EWg+tSXX1Yjuh4APQHIxBKuX
 kqfRho6NJJCRnNpM9xcZPEw=
X-Google-Smtp-Source: APiQypIGavhlDUd81ESSvhkKTiMJ5LneipZjYzEQwrTUivE4hkZVFXReXtn73ReplvkWt7x4d+qqjQ==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr8946521wrx.113.1588766063202; 
 Wed, 06 May 2020 04:54:23 -0700 (PDT)
Received: from [192.168.1.37] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id h188sm2972884wme.8.2020.05.06.04.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2020 04:54:22 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] MAINTAINERS: Add myself as streams maintainer
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
 <20200506082513.18751-10-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8fcf6570-2cfc-5a29-4721-86840b57640d@amsat.org>
Date: Wed, 6 May 2020 13:54:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200506082513.18751-10-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, figlesia@xilinx.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 10:25 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Since we're missing a maintainer, add myself.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c..d3663d6c9a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2315,6 +2315,12 @@ F: net/slirp.c
>   F: include/net/slirp.h
>   T: git https://people.debian.org/~sthibault/qemu.git slirp
>   
> +Streams
> +M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> +S: Maintained
> +F: hw/core/stream.c
> +F: include/hw/stream.h
> +
>   Stubs
>   M: Paolo Bonzini <pbonzini@redhat.com>
>   S: Maintained
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

