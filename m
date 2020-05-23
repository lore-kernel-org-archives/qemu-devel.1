Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13250C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 21:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA277207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 21:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="lRK0toxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA277207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcbqW-0007if-19
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 17:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcbpT-0007AJ-2u
 for qemu-devel@nongnu.org; Sat, 23 May 2020 17:37:15 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:34986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcbpS-0008Ce-D4
 for qemu-devel@nongnu.org; Sat, 23 May 2020 17:37:14 -0400
Received: by mail-qk1-x744.google.com with SMTP id n141so1904275qke.2
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CCdZrpzyfbM220focidF6hohpnzKEq6+AidYBz5LoL0=;
 b=lRK0toxstQKQO7BfWxncyAiooItZ3pdOdkzd6WkM+JKX8luIzqRkkN+PiMDmr0DWua
 IAnAn2RsFzifYozoJ3LGQHObbA+BVghXr6KMDgHHI6c3wopU8SBrxLIcKDsXD194jQhm
 nU4K41+fyrQCbclpczh+O4nDxXkWAZfNtXEM/1lwp7z5lFGsJRZS3LILQqBhOE4CAopG
 VWBDsEsfa0Jq/EH7k7E9j9akqcQ0cMTOfF0DiEGlSpmK2iA5QmiD8GN3UetD+rq+KDNe
 PSq37RX4dTAxgPrcevV5nbdoqQ2uRSoBqZebLbojph5XD45vnD/wOHX6beuiOSRNtsAq
 IbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CCdZrpzyfbM220focidF6hohpnzKEq6+AidYBz5LoL0=;
 b=ne64quE+NGqr4W+1wXC4F2Z6Nzjzfn58hO5nnLDS7BB7tj3n6Yhp4VMHiU8jiV/n/g
 /61zrKdLb6ZO+VcyrxHY/bIAVWzzQ73ct+dMUChxVupuv2jcTIy/sqJpWcSd8sbC0bJJ
 C5XCAhWYtaB61mV4m69rJbuJyfh9DR0g8YECj6DkWA3VptoNGyQnM3ezvjjVmBdf7kGw
 qzCEP+ri4BaFLDGxf/CLI/AeYcMcT35mjcKVJI6D7IbEJMKc8si7ordFv2UT0NscJmKd
 mqgMgIBkSGaNgNIflf/9x0/sIR+UqxgIW6agrDJ+hWc5ZZ0wDuMLGuTFSl5I85RGjJKd
 8NBA==
X-Gm-Message-State: AOAM530DhcOpDFUcgZbvOr0hgOENJ2PtQr4mOct5+GuspHtxGKr1DsTh
 czggwkuuyCPR+ujb+PC4s0iUWg==
X-Google-Smtp-Source: ABdhPJycR4GD7Yf9jfT566uJZmkIzlVOMICw8cQE3LV4Sq2gBOESqqgA8MXTQZpdIIuJfHfBDrH2Wg==
X-Received: by 2002:a37:aa8f:: with SMTP id
 t137mr16458973qke.175.1590269833275; 
 Sat, 23 May 2020 14:37:13 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id p3sm10096779qkf.134.2020.05.23.14.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 14:37:12 -0700 (PDT)
Date: Sat, 23 May 2020 17:37:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 10/19] include/qemu: Added tsan.h for annotations.
Message-ID: <20200523213712.GA491206@sff>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-11-robert.foley@linaro.org>
 <20200523172015.GB382220@sff>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523172015.GB382220@sff>
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 23, 2020 at 13:20:15 -0400, Emilio G. Cota wrote:
> On Fri, May 22, 2020 at 12:07:46 -0400, Robert Foley wrote:
> > These annotations will allow us to give tsan
> > additional hints.  For example, we can inform
> > tsan about reads/writes to ignore to silence certain
> > classes of warnings.
> > We can also annotate threads so that the proper thread
> > naming shows up in tsan warning results.
> > 
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> 
> Reviewed-by: Emilio G. Cota <cota@braap.org>

Although consider prefixing the constants with QEMU_.

Thanks,

		E.

