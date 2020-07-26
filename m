Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D403BC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 16:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CF9206D8
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 16:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CF9206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzjMv-0007Na-Ts
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 12:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1jzjLv-0006ZU-Bm
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 12:18:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1jzjLt-0000dn-Vf
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 12:18:19 -0400
Received: by mail-io1-f66.google.com with SMTP id z6so14568000iow.6
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2020 09:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YCDQAm0B+YopdpIO0aC1z1jJCzTC1ONYPHI0snGKBUg=;
 b=frwMhREm88oOxbqffSpq9jk6ccQy2GsDkaI/fu6Y4V9NUgCxAAsxP6w8906P4ZbQ/S
 J01Si0e6uPcQC9TTnzDRcKWWMxmhJO9w8CIuC87qb1YsbTjFIKSW5N08hO7NBBaIAxd1
 2tAXK0ntLdF00D8a2bXfUTifizizh7BZtVDaguZMT/4BbKSxVT2uGPkKa6EKphxYeORw
 EWOVoIk3A80OAMGofCP+vZ4CU4/GDzv+cTmf/2N/jHlIA3+wpz2NJGmt/olpsaugPE36
 GZRZMHRlDZt/IL9swz8VLDAkeA3YZx0GiXEUBtJ0eavzj7LL6bH0BlIQHCM7BhieuO4M
 vrVg==
X-Gm-Message-State: AOAM533SZ1kkN6h8dyqEHqtBP2UifcaPeX+vCCm8k0Ze7X72DtzUODMT
 JnzN2swjyze8YixCPZ4aKy5ECLGJpAMAwp8TcT4=
X-Google-Smtp-Source: ABdhPJxgpdzWk5D4Y8sJC+o9cafpwDigHQ5gUiO2reuwwtYsLgj/dyx+ZCmFt5LtytuxuE3HBe5W7n8a+qoWoZUZJ4w=
X-Received: by 2002:a6b:6303:: with SMTP id p3mr20497851iog.111.1595780297032; 
 Sun, 26 Jul 2020 09:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-4-thuth@redhat.com>
In-Reply-To: <20200724143220.32751-4-thuth@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Sun, 26 Jul 2020 12:18:05 -0400
Message-ID: <CAPyFy2BNOKvyNe9G4xfpoVq0eHEQCo=QpGsTR=7jNvMSLK2O3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] cirrus.yml: Update the macOS jobs to Catalina
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.66; envelope-from=carpeddiem@gmail.com;
 helo=mail-io1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 12:18:17
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
> When looking at the CI jobs on cirrus-ci.com, it seems like the mojave-based
> images have been decomissioned a while ago already, since apparently all our
> jobs get automatically upgraded to catalina. So let's update our YML script
> accordingly to avoid confusion.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Ed Maste <emaste@freebsd.org>

