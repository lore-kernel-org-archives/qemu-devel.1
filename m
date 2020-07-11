Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259D5C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 20:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF82020720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 20:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="nIWU+KTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF82020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juMHF-000052-4M
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 16:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juMGg-00086X-RK
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 16:38:43 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:36120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juMGe-00052n-Sj
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 16:38:42 -0400
Received: by mail-ua1-x944.google.com with SMTP id b13so2884270uav.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ROn+XEfxqcfZFDhCqbHRB0/p0Eetpd6lbLEPadBRC1Y=;
 b=nIWU+KTRs47TUSxZTd+1MzUAiTEKF3VCQFUbYDxjz8K0QN96j0FtOzvcX4wy1gzl8f
 vWMakDfPxlB9Ekm4JEt7XJdJ/Hy5GIHbzLKr2zG2KHR7SRDLgCA7E5SPpnmKowSag9rH
 ZvCgvbgJl4/X4L/BsgirtO3dCopD5SFRHzklDNHwDZddq6aVGRcnXKza2aVBLRCZqfoK
 Pv1ELEOoKPecdkC8OLlEFJOhYDnvNMLhzF/pHGDQ10vD74RueOKzgUoJ97iwiQpi8kAA
 mE+tdzsTQ3uUbphx7f6JiWWupBB2s0MRezMvtN4SDCkBixCmAdycjhAmbD/bTBvA+i4/
 vLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ROn+XEfxqcfZFDhCqbHRB0/p0Eetpd6lbLEPadBRC1Y=;
 b=ZUG5GDk4cJK46Tuim0DO+DZlY65UOK6zxqpdooehlGZdCIYX0djHKmuR2K+Z/h5fMJ
 e6PYHgL4NUuuuKOsTM2uerSrNufETcse1u3KCnv6D5Q5lZq5NkFCLJ92DanlIV8LF5CA
 HjS8MdDWGq1RFP6X8vyocAOzyFpXV/LOIHdBYIdqRjQnesiEv/DkMTM+dsybWoXzQzoa
 NVqEVkSD+if0WZhbjttHJsBHlOFzEF2RJZ7/SN9YlifiFCLnxE2bKWOalfn/vp8MwG2v
 EE00heUSsuKvPEJpScyO63igjuVMiqb504/68lNfXAM4wCxm+AJMBJLk8uYWKbGqLKy5
 d+VA==
X-Gm-Message-State: AOAM531+ucE4Yku4odSTRNORoaCQFAqJw8NaHwD9lqEEKhPUkPM4PtD1
 EFJcVflsKsXPuE+s51VjoQ5fOw==
X-Google-Smtp-Source: ABdhPJxxEdN4Eutyiv6hHeULF2+PRHoSFPPwJ8BbK7aXe5WVyPIdruG1FS247axYy6gwjIMzxgi9IQ==
X-Received: by 2002:a9f:384c:: with SMTP id q12mr21666976uad.63.1594499919422; 
 Sat, 11 Jul 2020 13:38:39 -0700 (PDT)
Received: from localhost ([37.120.215.156])
 by smtp.gmail.com with ESMTPSA id 79sm925338uas.2.2020.07.11.13.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 13:38:38 -0700 (PDT)
Date: Sat, 11 Jul 2020 16:38:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 01/13] docs/devel: convert and update MTTCG design
 document
Message-ID: <20200711203837.GA807960@sff>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709141327.14631-2-alex.bennee@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::944;
 envelope-from=cota@braap.org; helo=mail-ua1-x944.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 15:13:15 +0100, Alex Bennée wrote:
> @@ -92,6 +107,7 @@ including:
>  
>    - debugging operations (breakpoint insertion/removal)
>    - some CPU helper functions
> +  - linux-user spawning it's first thread

s/it's/its/

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,
		E.

