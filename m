Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C51C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9385820727
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="SgE81jVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9385820727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcam4-0001Jb-Ro
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 16:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcalU-0000tR-Nd
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:29:04 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:35872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcalT-00048d-63
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:29:04 -0400
Received: by mail-qt1-x842.google.com with SMTP id v4so11160147qte.3
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=z8Ge6R5epLvz1Eoho/cNW8d34NBGGtAaMxZrmK+sYUM=;
 b=SgE81jVOopx9KvCOiqT1Ff3wvO9ViW8xDc2K4jDpa8M4dtwqs+NVQAoyKIIHItRpx+
 cnIrFa4XkROjCLTboxvUF9LTrnuJmFoIRVCSKy9yq14yJZsQp4V2IcrC+BDuh5CqnRoK
 gCP3rJNmH77AMn8AT/kuJfdt2tL8PWZUfItEEFichGGBaF54RfxUCAL9VgzxaWTJwaLP
 fParcYNtceo1TauYt0bHWTjMnb04xeElD8MWqIsP1CIRitW0u3klz5u2Y31EeM4YUnXa
 FBj9JDzAkpxVQJ/V1WhagAj+l6HV/GirpDqYbECKXz+HiX0u+AjPlxqDVkoQSHYv6cbP
 9kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=z8Ge6R5epLvz1Eoho/cNW8d34NBGGtAaMxZrmK+sYUM=;
 b=SeY9LRkSyxDDBfIneXcdovfVH0QnrIRJgEAIvRgTAjNY/nkyTUyiseJaSeyKnx4rLq
 hFHjOEEZgBB+vSwwlU5JH5loZ4zrDdGnlOiVrN34RF+R85eeBA8bsXF2rh5jbZF1Rs5e
 /R1ttogLDkhjqWRuezAk7ell7ugoP6vGkAJZwCRoo11hXQoOgC6fZf/SracpyH5D7TQu
 IiZr5f6G1pQbwaTuwAvbwuDvIGQF0Hgv/k8SpGuIKPpjASaxcZC0jeC/ByhqG6+aMVyQ
 9VaWV6QisAnoXFyVK1/a6dzo2gM2ZHH0zdBZAp0d7PUEPiqBHCzAskmyKKCA72JhBBsj
 hKhQ==
X-Gm-Message-State: AOAM533tUbXuG4YHL1tGNtPqtTW0077H4BybkW+dNvn/NFVmHzTbuoiH
 8FJetVVAkMwGCBW/9k8SY62rfA==
X-Google-Smtp-Source: ABdhPJwT4QMDLm/hD+JsG3Ns0tA+C8AdoxKFhh6ypdvf4pXDKOVsfR3VHGM5/2EUngB4++qBUTz5XA==
X-Received: by 2002:aed:2253:: with SMTP id o19mr22727427qtc.236.1590265742046; 
 Sat, 23 May 2020 13:29:02 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id c68sm10761231qke.129.2020.05.23.13.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 13:29:01 -0700 (PDT)
Date: Sat, 23 May 2020 16:29:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 17/19] util: Added tsan annotate for thread name.
Message-ID: <20200523202901.GG382220@sff>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-18-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522160755.886-18-robert.foley@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::842;
 envelope-from=cota@braap.org; helo=mail-qt1-x842.google.com
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 12:07:53 -0400, Robert Foley wrote:
> This allows us to see the name of the thread in tsan
> warning reports such as this:
> 
>   Thread T7 'CPU 1/TCG' (tid=24317, running) created by main thread at:
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.

