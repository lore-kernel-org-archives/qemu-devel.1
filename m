Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52489C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251212081B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251212081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbwN-0001k7-8K
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqbwD-0001Kp-NE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqbwC-0006N8-RZ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:29:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqbwC-0006Mw-LQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:29:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so44644891wms.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xytbfmKheDCMTgiGc3Xsnqta33PBGYcFs+9h1vdGzUs=;
 b=S8BAW9ZXutqZOUebyHsde32Mmc7TQiahUl/NeuSIexZTk+Q4xDGMev9w9BqHpXhP85
 dftfHjxcgm+C/gsNMINzj0UiprbNeS9YV/fZLQkj2Po8Ep4rQ71RscC2e+hZsWBefljv
 GIuALEWduJPEPOC7JY2HyLFBeGEPeOZYwJJQvN6hH/Qlj7SOLrhmuK+igg9daN3lefah
 siav5QT3+FzJH1zlwqVfIVR5iBhRPtPgcl0yF+oKQx6RarkIoDdio5vBYQx7NTaL4+5e
 NA/VNOnik7iRRG8yqUWqmG4YFquby1L8cfsuCQB1SddUEr3bRcPKLil3WktoLW3drCUz
 sfew==
X-Gm-Message-State: APjAAAVbuJZeB6Oktsskx8HVIvjpUyIvJtGxsKct1dlvKUUGUVoobck6
 jyP52UgGz/lDCSA1OD0DCCfNsg==
X-Google-Smtp-Source: APXvYqx4ImoF8BYyVpcks6hpFineCR4tzR+oo0tE0lQBVC4m8kbl3qK0FF+wXaojTfluqH6jKvl1iw==
X-Received: by 2002:a1c:238e:: with SMTP id
 j136mr77510924wmj.144.1564054171600; 
 Thu, 25 Jul 2019 04:29:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id o3sm40403701wrs.59.2019.07.25.04.29.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 04:29:30 -0700 (PDT)
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
 <156404429499.18669.13404064982854123855.stgit@pasha-Precision-3630-Tower>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ee05a066-194a-5a5b-7989-cb5690c85ebf@redhat.com>
Date: Thu, 25 Jul 2019 13:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156404429499.18669.13404064982854123855.stgit@pasha-Precision-3630-Tower>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [for-4.2 PATCH v2 8/8] icount: remove unnecessary
 gen_io_end calls
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, armbru@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 10:44, Pavel Dovgalyuk wrote:
> Prior patch resets can_do_io flag at the TB entry. Therefore there is no
> need in resetting this flag at the end of the block.
> This patch removes redundant gen_io_end calls.

Nice.  I don't think the comments are particularly useful, I'll move
them to gen-icount.h if you agree.

Paolo

