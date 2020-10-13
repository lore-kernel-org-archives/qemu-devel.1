Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6321AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EEF252C4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX10eVsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EEF252C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNPB-0000H7-N7
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kSNLu-0005cf-Az
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:40:42 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kSNLs-0004Zj-Ig
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:40:41 -0400
Received: by mail-lj1-x242.google.com with SMTP id a5so47881ljj.11
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=svWn01L0ewwGDboXKuINQZ2sSLpcpfsk7X1TYth0+o8=;
 b=TX10eVsy0lGjMZNvQcmtoq92BQlZb3Egys2D/brtUpnCocKRhiD+mx7gT2Qmpob+/0
 mccRCtTsKhRT1BSoO3rjRqrTXMgxIObMHUqOXq6gWJUJZAY7sPC7a4yyANl8+a5crMqg
 MkOyNh/Op89Y72/NfqEUcMRkD1CjC6TY0URIXzSsLi43SPmhjsWyNyjkY81QJkdRwUif
 Q/zjcMSDvQL1r4TsbGAqkwYjYyEp9wcGrnsipG+5PsnnxH4A/MyK0wc0siN1mnkISAQg
 TCIMkqWlMRxn+GRTgBn+Zi0gHM9SnbE54gTf3iv3/QFCN9UZfy1s1ss8KxdXAxIXHd7X
 3vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=svWn01L0ewwGDboXKuINQZ2sSLpcpfsk7X1TYth0+o8=;
 b=rTzbtnVgX4sAWjw9eJ3iefPjsISmwmhVg8ebHGiGl+fsrI37OFdDlAX7y45DBvZf+x
 dsV0Wbs6ywnn5UGLP88UBY24BNjYhE0iBPoZyhz5RBxeiC17tT6o4e+qvk/BLE+XP/nw
 LDXwexNvmL3AraG/NVqCBuQdX1fh/kCy96wx6VzjHbOpO+ribqoiaMH2osJZkZqaJKiW
 eNfNSdhf0tJ9dsbpF1Fgdt3QbcDP/XDuAdupYdVBdUG7UgcxJ+qcohKVteKGCFzpYaPw
 iTkn/cTuWcaZDCXvKe+nlgqG63v0KCOHxosrS2+G9tZ3nYHlddm3IjgHVX/4M7bvfFQn
 8D0A==
X-Gm-Message-State: AOAM530bC4Vadeeya/Xgx0eE2qbRVQ+xTGewPJbSaC7m/f0uLBo2J+hJ
 2nqKd/d9LZM4VfJZ0aIoano=
X-Google-Smtp-Source: ABdhPJyAAiE2bV4T4qazQiDShJOMofGhoQQxlFBLszdIw4g77kyw4UM80TBKhxCtCSRqqHSmjsejTQ==
X-Received: by 2002:a2e:a30a:: with SMTP id l10mr150257lje.122.1602607238717; 
 Tue, 13 Oct 2020 09:40:38 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q27sm69483lfd.261.2020.10.13.09.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 09:40:38 -0700 (PDT)
Date: Tue, 13 Oct 2020 18:40:37 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/2] linux-user/microblaze: update signal handling
Message-ID: <20201013164037.GG2954729@toto>
References: <20201010173130.99652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010173130.99652-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 10, 2020 at 12:31:28PM -0500, Richard Henderson wrote:
> The linux microblaze port only implements rt signal handing,
> not the old style.  This allows our linux-test to pass for mb,
> if you have a cross-compiler available for the build.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> 
> r~
> 
> 
> Richard Henderson (2):
>   linux-user/microblaze: Implement rt signal frames
>   linux-user/microblaze: Remove non-rt signal frames
> 
>  linux-user/microblaze/target_signal.h |   1 -
>  linux-user/microblaze/signal.c        | 186 ++++++++++++--------------
>  2 files changed, 83 insertions(+), 104 deletions(-)
> 
> -- 
> 2.25.1
> 

