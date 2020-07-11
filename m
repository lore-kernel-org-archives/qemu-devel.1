Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5826FC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 20:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDF220720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 20:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="rJrlR3Kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDF220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juMKV-00019I-Bg
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 16:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juMJn-0000j3-Bf
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 16:41:55 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:38591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juMJm-0005QL-4w
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 16:41:55 -0400
Received: by mail-ua1-x943.google.com with SMTP id n4so2884251uae.5
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=MyiWJbqDfKNZTJewiWc5wbbp1bzkm5KSyteKNF1fO7Q=;
 b=rJrlR3KrZ59KLXnhrOHTSfv35gRZFAKUy3Ie93qbTnTGjHGabbXemoQAGbwF2jQc9O
 q+P2armHcI9J+9o2zKst7jy4zOOOGZuxmCDfWr/IDkPPDiX9FZmfZ3ql8fup84r9O+XP
 d4ZuaBlpx/6vEEojJdtmTNCGe2iGYqWtFdGMvYPJjGCTw4h1KvJX/dl0uevIyFf5X9hs
 Z2mfZXinHKOsYcYbX8jjV6/nZF6j6b78LeV7fG+uUTpHMN4HTCu5TMVnX1fLfOC9Ns8M
 daIi7Ub1aCB+5CoLXE0I4gascBQsH9QLiX8lIdadLrrXV7A2eoXV0b00w8/6+YB8EM3R
 8t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=MyiWJbqDfKNZTJewiWc5wbbp1bzkm5KSyteKNF1fO7Q=;
 b=puBWQcU5CEfOs3vgQD+/LdUlttKZ2qb3togsNSlhe0U1ChHzN3tjeNt3OQancTee4o
 aIuFXTz59xrtPyw+qPtXFP5iAULJM5I6mz67ObWyX1AYMB/pj11E/7WuTtDGeKVLw3+c
 olP3X+kckEPtEFtjoruq7tl5P4Qlo1Exd6QTIa9iMCNA9nRAdsQk39rCOkFAXIrsuYRq
 G+oGwp6QrteemqO308tGrOngQVC9m6wILPNISa6USoFbEFxA14jO0pbMyh1fIlTdeCKi
 b7+nnAK80DQ2+4Xrr1eeWiS9oMAN1YYLI0DxSNc8GzfeAetezXNNJZaAcBuD7WgBpKb3
 rbzw==
X-Gm-Message-State: AOAM530dHvYlkDAIvj5lQzvzIV0Xsur0o+tF4pG+/vNSuCa2UGs2xxxC
 mpg+hHmMkhKLgi/J06wj0/xb8w==
X-Google-Smtp-Source: ABdhPJwa3QnUo8HVV8fQtmSkdHLcbDdi2qF8oWPMd5jRla8iEwlp5El2VucBqTNY/c1v9AQyA/njAg==
X-Received: by 2002:ab0:6950:: with SMTP id c16mr23454699uas.53.1594500111421; 
 Sat, 11 Jul 2020 13:41:51 -0700 (PDT)
Received: from localhost ([37.120.215.156])
 by smtp.gmail.com with ESMTPSA id a2sm1095243uah.5.2020.07.11.13.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 13:41:50 -0700 (PDT)
Date: Sat, 11 Jul 2020 16:41:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 02/13] docs/devel: add some notes on tcg-icount for
 developers
Message-ID: <20200711204150.GB807960@sff>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709141327.14631-3-alex.bennee@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::943;
 envelope-from=cota@braap.org; helo=mail-ua1-x943.google.com
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, robert.foley@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, robhenry@microsoft.com, f4bug@amsat.org,
 aaron@os.amperecomputing.com, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 15:13:16 +0100, Alex Bennée wrote:
> This attempts to bring together my understanding of the requirements
> for icount behaviour into one reference document for our developer
> notes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,
		Emilio

