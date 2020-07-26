Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC4C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 16:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D8C206D8
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 16:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D8C206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzjJI-0005TT-TL
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 12:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1jzjI9-0004tE-Km
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 12:14:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1jzjI8-0000Gn-5z
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 12:14:25 -0400
Received: by mail-io1-f68.google.com with SMTP id j8so2171496ioe.9
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2020 09:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y5BJkSlWzrH48SCGyZbSHFEm/72HnlU8UUFj+4XI/YE=;
 b=IW6a1cDh8rgEY9nIwKzwrbQbnjR4qygul2VrjYDe6M21IxkfTR7IqIiYbxHGwHXozW
 H7Fwe+P/VYS8v73N4Y5yAvchEu/8AmK6dViA3pJW7EllG1QzHkWpq8OeFv/szQtETSqd
 hfGyCta6H+0XnUHhfd83nUdKJPbwChDS0Ng0vrLA9QjXZ3NmHfHRg0u53M85sBnShOZt
 dYUjBhnggecb4sj7s2WjW8tHwh9j/fEPgCAWT6m9GIKw1rZRUIcTQdjfmHqUSmhdF7UQ
 wAG2kIA94wukDELnV99zCIo9UWG4knsLXgUOrTQ3jPSrcponSgixtWlhUphQ+/LVAYgh
 4+Pw==
X-Gm-Message-State: AOAM5316/kBAcYzsx+T5Jjs2M1hje4K6U+wUopXtWs5xC3skdwk5YPwd
 cKzi5m8pRfQc4vf/rwH89ERPADn0GJb+4Tsm6p8=
X-Google-Smtp-Source: ABdhPJzUBIRCfL1y1wYOPGWCisETjjcr2npz9usOfdISwZI3sWFWQ9rD076j7O0yCSq4yK2twvcpm0AiWWG2sTJ3smM=
X-Received: by 2002:a5d:8a04:: with SMTP id w4mr10684669iod.15.1595780062757; 
 Sun, 26 Jul 2020 09:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-3-thuth@redhat.com>
In-Reply-To: <20200724143220.32751-3-thuth@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Sun, 26 Jul 2020 12:14:11 -0400
Message-ID: <CAPyFy2A-7gLhsCAdAohdnm9BDcHyR2y7EZK2nAKTkp0zYtYC9w@mail.gmail.com>
Subject: Re: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.68; envelope-from=carpeddiem@gmail.com;
 helo=mail-io1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 12:14:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 at 10:32, Thomas Huth <thuth@redhat.com> wrote:
>
> Compiler warnings currently go unnoticed in our FreeBSD and macOS builds,
> since -Werror is only enabled for Linux and MinGW builds by default. So
> let's enable them here now, too.

Reviewed-by: Ed Maste <emaste@freebsd.org>

for the FreeBSD change; I'm indifferent on which method is used to
address the macos deprecation warnings.

