Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF80BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA1120671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zC3h1COm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA1120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxGg-0008TP-Vs
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxFq-0007n0-QX
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:06:18 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxFp-0003i5-VD
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:06:18 -0400
Received: by mail-pj1-x1043.google.com with SMTP id q24so755697pjd.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xsQMtdzQ9Pp9Q1Pbe+tPvOkKNBDDtRrjGAPG8XpVmEE=;
 b=zC3h1COmHDHwYdzJlj3X8iD7eg6vFX9wkNV1CyF6RzbJzko9If0cdEiKx9DD7A0Vj8
 rw7pb+tig5b3JFQPu38nWJy5k7cbDwf82iSwOeFH83bOJ2lj0ViwJCNbGsw8UCasrSvn
 Lh3pMWHU/vb8mHC0o7RkJ58cZ5U58RQY504XHUJH4CxefDjEz9U+P5et3jJS9Rntr5nF
 wwYtlZ6+xh9TLWmog9qeqivdV6ubyykgciZB4zTh1iDYcYpHB1OV2pP1dFMxnAiuT1Y/
 WBkmKixB97hkoI3v8wbFNa22KtCCQIdQRYI4nuDmos4+tvuu+3ejh11nhgVZ/FMY6MMr
 7dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xsQMtdzQ9Pp9Q1Pbe+tPvOkKNBDDtRrjGAPG8XpVmEE=;
 b=AArBahowM2ok0cGfc5ALKUg7j7w8rWR+CK87RVY7Ex5r8GjP+8t8HxECSgkoms3bJd
 ebx8C63Zjw9pyy5lhMU5UoEglFmprpRuH9g2FRUDTPaGuPsM5b9wR0O64VpGxZ+2wtBg
 O7aZ15pkRqmdM+tht9MUIVi24nVYnICzz7Br5sIPld8/vD/GZkd8MiqaboslA5/dSG5k
 IeWq5W1p9ZzVXDw25eE0OeGOop9xZ5+GOhW6kt9box4UVaOotyedlWnYi1jhz0hYd4e3
 bNPBeDU2Myc3PEM/171NMXS24AHupPl60Zm/by8Pycd6LXKQTvaKwlBIRtnpFvT+rk4N
 A/Ow==
X-Gm-Message-State: AOAM531ZRFrzyzjywZmLFdPafYSNBX99du7WXePnmexpPJnr9tfiGDaW
 zo0xgqsZa+e1TLZpePLIj5iHww==
X-Google-Smtp-Source: ABdhPJxmL69WPPUuZ+HeEZcPC+C/5oerSOyw052cbu+W0htAso8s9bpRyNK41PJt4c8MSX3iHsfFqQ==
X-Received: by 2002:a17:90b:50d:: with SMTP id
 r13mr2860959pjz.94.1591067176442; 
 Mon, 01 Jun 2020 20:06:16 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j186sm678118pfb.220.2020.06.01.20.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:06:15 -0700 (PDT)
Subject: Re: [RFC v2 03/18] target/i386: sev: Rename QSevGuestInfo
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-4-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db54b6ae-5bfe-b580-b6fd-6f80a3fd333a@linaro.org>
Date: Mon, 1 Jun 2020 20:06:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:42 PM, David Gibson wrote:
> At the moment this is a purely passive object which is just a container for
> information used elsewhere, hence the name.  I'm going to change that
> though, so as a preliminary rename it to SevGuestState.
> 
> That name risks confusion with both SEVState and SevState, but I'll be
> working on that in following patches.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c | 87 ++++++++++++++++++++++++-----------------------
>  1 file changed, 44 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


