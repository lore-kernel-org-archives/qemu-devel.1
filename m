Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93132C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 03:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577AD206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 03:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="j7SxhjNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577AD206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfbZU-0004SE-Gh
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 23:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jfbYd-00040O-01
 for qemu-devel@nongnu.org; Sun, 31 May 2020 23:56:16 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:41520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jfbYb-0005iy-OZ
 for qemu-devel@nongnu.org; Sun, 31 May 2020 23:56:14 -0400
Received: by mail-qk1-x741.google.com with SMTP id n11so7874688qkn.8
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 20:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8LUWltuiSD7IEOVLWl1mhgKxYxmmAD9i3SdDJ74iRJc=;
 b=j7SxhjNULxtxiyUs7kyRaCA35k8FDl5MnBMwh/uPLJtmIRNKSVzoqYa9ArkEEGi+dT
 ZB3BSySCy0qTklIQKTfe4M4dtu2Q1/+7GrVpo09ErEY/4nlXSGYvhikvsIeMjF2cmDjm
 1K3B26FWDzCmzxiMHtGvyrdWJT1D0JXe8zHgw/MIBXsstWVlbyy2FNxKbr7BbHPmoZtx
 YdEvtneQ4a47PjynDGrZ7HCuUp0TRpEj31KzrlZRkH3XRYfKY4futuToi2rOFXqL2OYb
 KhRX9fEKknbA6U/kh9sRAHM/Glxdr934VY4A6bFQAX3ZOTveSSInpyEZoZkVXGTQ4p0M
 hMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8LUWltuiSD7IEOVLWl1mhgKxYxmmAD9i3SdDJ74iRJc=;
 b=iYUBGypxCEfmiW3lv2f2PEGDsh0pDluSh+O0NfzJzuWxoRXGmwKHRsaC8gCvyLvLEY
 Qn5Yh29tAEVmF5nxCBXZ/nnHusi+FmPSfsZjJ/2JfpYynL70+LYwA8dqeXqUdfArwsV8
 3YPnaj3srO9cup8PU40ubBB8wa/6zkIGdQBKAoSj336haB24C37SPSqmR0LePuKHrJdM
 KCuVZTks9t3H13gznkOuPpzQF1tvh1HyQghewGlz3NYYQ/0J2t2qyJ1zlFG7LAzlRg95
 t4J35cxT3I0EiLUU6j7Gl2Hm5Hd0YFYXCTegb+M2IXxx/QXGxVE7vk3clTmMdRR8zmO0
 fAFw==
X-Gm-Message-State: AOAM532Bdvcnqjz5oiwGTo/VO3zVfcQYprTNwK3UkC1Prq6ixfqZVror
 k7CmrcaB5v9ujL2B33lNpJ+t7Q==
X-Google-Smtp-Source: ABdhPJwx7KiLCmtj/8+mRq9ul+qOFO4yoEwu0c27G4CmUx6BkNHPeunGnDYTEjQBrV3z9b8vxDKBjw==
X-Received: by 2002:a05:620a:2012:: with SMTP id
 c18mr17002290qka.313.1590983771851; 
 Sun, 31 May 2020 20:56:11 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id s15sm15671071qtc.95.2020.05.31.20.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 20:56:11 -0700 (PDT)
Date: Sun, 31 May 2020 23:56:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 11/12] util: Added tsan annotate for thread name.
Message-ID: <20200601035610.GA2184251@sff>
References: <20200529132341.755-1-robert.foley@linaro.org>
 <20200529132341.755-11-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529132341.755-11-robert.foley@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::741;
 envelope-from=cota@braap.org; helo=mail-qk1-x741.google.com
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 09:23:41 -0400, Robert Foley wrote:
> This allows us to see the name of the thread in tsan
> warning reports such as this:
> 
>   Thread T7 'CPU 1/TCG' (tid=24317, running) created by main thread at:
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio

