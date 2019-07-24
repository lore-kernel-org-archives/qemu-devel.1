Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21137C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E000E21850
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E000E21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqG8V-00056i-5X
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 08:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40767)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqG8K-0004iE-U9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqG8J-00053n-8I
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:12:36 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqG8J-000532-2A
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:12:35 -0400
Received: by mail-wr1-f54.google.com with SMTP id f9so46683072wre.12
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 05:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rTz6keX5hW9hXkWPDnRdZEZBmQ2xuOMDI9Dn+OZCSzw=;
 b=jZPutrYNSOG1XHnZKQ2MWFX1cqeUBOvJj1C5jQkfKWTvxGTLvFOaLzemdRVdlKVbMM
 kFv5g9pHVR8MvfGAQfH7Acgq0h/3HexYrrd4RqnXtqcEuUUGXuv13lSUigWrsod+tyjA
 pdHeO4zp5go+DfoR+Yp3F/yfEGADp0EbTel0ZqsxWwK/XzCk7BCPq8DhD+L1QAp+zpKa
 vqdY0I32YoNHGecVRLxFiv6xeaUCKgnjKvwjkHQUkT7SwvmZ0FCkCu9GL8mdA4FNeAdH
 g588Z/ogokvPlTgffXNYMjunjkW9LLz3GTw/sOgF5rwYLb85HurmY2wwqrm0OwjMhne6
 47ow==
X-Gm-Message-State: APjAAAUdG4rKQqLCJBrajdZAUlhg13gbwIghn2UCokMLkTyosxJmPjEc
 YHBCgFWz/kX2Bgf9gk1kbA2xpFj2LYc=
X-Google-Smtp-Source: APXvYqxOrLrGhWmjeORZqQQ3v6nxddNhVR6yWdMg8nnUV/jj2da3d6Rpx6tf1BhsPWEv9rB7brl3eg==
X-Received: by 2002:a05:6000:42:: with SMTP id
 k2mr44049989wrx.80.1563970353753; 
 Wed, 24 Jul 2019 05:12:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id j9sm51787167wrn.81.2019.07.24.05.12.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 05:12:33 -0700 (PDT)
To: Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
References: <1562823509-13072-1-git-send-email-jing2.liu@linux.intel.com>
 <c572cdd2-d0f4-2e06-99f8-302b798a04dd@linux.intel.com>
 <0f9763fe-af69-e057-9fb1-00527e636fe4@redhat.com>
 <0ffa32db-3615-16e0-71bf-a8c552c2fcfb@linux.intel.com>
 <757b193f-90c6-0516-9372-74463ec4d117@redhat.com>
 <4e381ae0-78d5-afb6-9a4d-b58d0daa60ba@linux.intel.com>
 <3bc3b6f0-a6f8-39a7-b7d4-39b18916cc44@redhat.com>
 <85ea4a12-0aa3-5433-f1c1-97406b7836ef@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3b6b5b94-f8d1-f592-934e-4bc9deea3f41@redhat.com>
Date: Wed, 24 Jul 2019 14:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <85ea4a12-0aa3-5433-f1c1-97406b7836ef@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.54
Subject: Re: [Qemu-devel] [PATCH v1] x86: Intel AVX512_BF16 feature enabling
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

On 24/07/19 14:05, Jing Liu wrote:
> 
> Thanks very much. So would you like me to update the patch with v2 now?

Yes, please.

Paolo

