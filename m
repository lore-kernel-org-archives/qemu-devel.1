Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B4CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCC820739
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCC820739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js9Pn-0008BR-2r
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 14:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js9P9-0007gc-L8
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:30:19 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js9P6-0006DT-Kl
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:30:19 -0400
Received: by mail-ej1-f65.google.com with SMTP id l12so40092679ejn.10
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 11:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HH+J/ResC1Bfb1Iyy3JDJyT7Kkl5jfdnjTJ1OzbDDpc=;
 b=n5t0DBNpyP1+wAIYg0mSnNA/rDXW/pgkmgsX2gJKThKN/+sQJXEr0a8tKIowg8ncq4
 QDTGqQ9KH+sdsUYLDu8vv+M4Qw77Q1GNdPuflf2qwXc5ICIO+upRPOeq/IxfUVNXDI8o
 /Tbix68LnCfDZu1sVkQdhBGhuvCjsTxEyEAocigZm78mCloZl1ywWxH3smHNbcUV3FSg
 peAa0ZkqgcVNo/dLH5nqO8s4puRWEJI89EQe85XicELZ3TuhL47IQDd1Pp+PF7rK7Gj3
 vL+NkIqOdrdopVw+rrWDMHFNBjpQ0bdRmAgjSCEURPs3haM4RExsL1mMrPZjhTZ+CtyW
 eOmg==
X-Gm-Message-State: AOAM533RYRrf2BhmKOtUXbvSdkExMg9GZLbMLP/BPP3dpHqgclmki35s
 GON1kImgfEtnUiYBngt9rcfxa1Uv
X-Google-Smtp-Source: ABdhPJxuNvtpUpVbPFdZDAIddI2tW21oZSLIKeBHyRiw9cbJvsi3oI7/VowBGw+IGQaYCd99T9sRBw==
X-Received: by 2002:a17:906:edb3:: with SMTP id
 sa19mr39737702ejb.21.1593973814959; 
 Sun, 05 Jul 2020 11:30:14 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id o20sm14757500ejr.64.2020.07.05.11.30.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 11:30:14 -0700 (PDT)
Date: Sun, 5 Jul 2020 20:30:13 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: <qemu-devel@nongnu.org>
Subject: Re: [PATCH rc6 00/30] target/avr merger
Message-ID: <20200705203013.26739b5d@thl530.multi.box>
In-Reply-To: <159395934458.22113.4571211972557020419@d1fd068a5071>
References: <20200705140315.260514-1-huth@tuxfamily.org>
 <159395934458.22113.4571211972557020419@d1fd068a5071>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.65; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 14:30:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Sun, 5 Jul 2020 07:29:06 -0700 (PDT)
schrieb no-reply@patchew.org:

> Patchew URL:
> https://patchew.org/QEMU/20200705140315.260514-1-huth@tuxfamily.org/
[...]
> === OUTPUT BEGIN ===
> 1/30 Checking commit b5e3116a3591 (target/avr: Add basic parameters
> of the new platform) WARNING: added, moved or deleted file(s), does
> MAINTAINERS need updating? #42: 
> new file mode 100644

These warnings are really annoying. The target/avr folder is added to
MAINTAINERS in the first patch, so they should not occur...?

[...]
> ERROR: trailing whitespace
> #39: FILE: docs/system/target-avr.rst:20:
> + - Continuous non interrupted execution: $

Ok, that's a real one. I just already fixed it in my local branch.

 Thomas

