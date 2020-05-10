Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B15C54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 20:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D56220737
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 20:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="aoDt+471"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D56220737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXsMp-0000wC-47
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 16:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jXsLn-00086c-3P
 for qemu-devel@nongnu.org; Sun, 10 May 2020 16:15:03 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:38464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jXsLm-00031a-2Y
 for qemu-devel@nongnu.org; Sun, 10 May 2020 16:15:02 -0400
Received: by mail-qk1-x744.google.com with SMTP id f189so2049622qkd.5
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=hX2R1RWxpEhvyTijKWVn7q08cfvfUch4RDo/el+QvE0=;
 b=aoDt+471dihpltzDYK6ZLC/dop8mje5IeKwrtNAHS6cRTDfJLKcnfWPxDEZ8CfD5C0
 5GRsH8O/3LLq37Hfmu2cwNC3AmYzhM8l6SEv9HT7N29mLTa7Ok8k8wepejNf0kcv9+4w
 VXHNoKIfte0GtcycPKr7m+CHHEKKBgPojmRLV7GiV5CuBWFmCn+8meTv0Ynh0wmx3aBD
 6d4bzAou4FE8A2Z2cZeR+1gU8HirjevYohQHSecbvk3xGxdhe/UCLRztYNVc6MMiaSnp
 FauTNAVWMfJ0pRwk0j5tKhXxp6XLLywfFblasPwigu63tDqxDGEOw/Ky/7Qa1g77gY4D
 SbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hX2R1RWxpEhvyTijKWVn7q08cfvfUch4RDo/el+QvE0=;
 b=JIB3uPS1YzbJZzDRbsw5QEwA7KmrXdbLd0ac8Dcosls0HbYYrQ6bnYM+OJj6iy0fqD
 PWhQaMmk1keDWfCBx1tdhIlt0NWDN0uKf4wVcyPcHZjH3KVVebfN2Yy4Xar5W2kLW/QY
 9rjrBDUDXBdHFxHS3q2SDemRLpFsVkarTTaKxIM8rzWOktkJMueo8catYkkwLTBQJOKA
 pRx4OvquYTI4q0vGEyhjcqDhthxN1oYJ+ySD3vXU3H7/BOBdmP+cR51VetMKGm6LBAu+
 5a/C3O4sldijM15oD+TQ4mbSFcIqhu7YjAz69LQDGR7fgmMrgqQbqRHaQxm7uOMxW91u
 lLrw==
X-Gm-Message-State: AGi0PuaiQj/0TXVNpz5IMtvaQQvHb4vcP7o/nYr+hY59G95ZUC3VMGOn
 WBaZUCwlG2XAEySDCigCVP1ySQ==
X-Google-Smtp-Source: APiQypIDGKqrcOgN9NZ5pJIwEKyviY1gDkzTj8I5S8s6f784W3goS2ff5D9Lyt3cLH3Ht9Cl5282zw==
X-Received: by 2002:a37:a50d:: with SMTP id o13mr12418341qke.121.1589141700879; 
 Sun, 10 May 2020 13:15:00 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id c26sm6482838qkm.98.2020.05.10.13.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 13:15:00 -0700 (PDT)
Date: Sun, 10 May 2020 16:14:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/3] plugins: Move declarations around and rename
 'hwaddr' argument
Message-ID: <20200510201459.GA125078@sff>
References: <20200510171119.20827-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200510171119.20827-1-f4bug@amsat.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::744;
 envelope-from=cota@braap.org; helo=mail-qk1-x744.google.com
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
Cc: qemu-trivial@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 10, 2020 at 19:11:16 +0200, Philippe Mathieu-Daudé wrote:
> Rename qemu_plugin_hwaddr_is_io() 'hwaddr' argument to later
> allow declaration of the 'hwaddr' type to be poisoned (see [*]).
> 
> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02254.html
>     "exec/cpu: Poison 'hwaddr' type in user-mode emulation"
> 
> Philippe Mathieu-Daudé (3):
>   qemu/plugin: Trivial code movement
>   qemu/plugin: Move !CONFIG_PLUGIN stubs altogether
>   qemu/qemu-plugin: Make qemu_plugin_hwaddr_is_io() hwaddr argument
>     const

Reviewed-by: Emilio G. Cota <cota@braap.org>
for the series.

Thanks,
		E.

