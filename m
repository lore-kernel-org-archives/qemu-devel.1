Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BADC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7142206F1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eO4DE7LR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7142206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlGfu-0005Xj-3y
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 14:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jason@zx2c4.com>) id 1jlGfG-00052O-1y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 14:50:30 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:60829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jason@zx2c4.com>) id 1jlGfE-0008Iu-KW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 14:50:29 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2b1af5d5
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
 :references:in-reply-to:from:date:message-id:subject:to:cc
 :content-type; s=mail; bh=yKG6wKH74SABWHcPXI6Wj0DXZWY=; b=eO4DE7
 LRbsfCAZQG9btEM5xxG2ubHEcQMIvA6IThtnsE/hYJ4iDoeqnFrT+rD/TAJUbxWB
 kevafEVcLZrNmmrxwhTDhzWhgWREh2P5FLVZRuvu0f71+VvUhajoBZTnYiTtiuQk
 Iw+IxeQZHPEjUbrSVf9EGgv6TZtmdH/mJ/6BbZdaHC14uJ0zVzYIoKb57bKc2Ez5
 auJrGn7W/KBlYuYffafHpwqrdCmm25abHC4tZ6fnVEa6mi1+6uPfNNg5Yj4VXPRC
 wQhCCuJeZNjqxoJXCUr5XhckawvBbaGGSL6YuFnqZGIpEeHZF0tnGSpIzugiq7ZF
 lmOtkUYZe9g11ITA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d53cfca
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <qemu-devel@nongnu.org>;
 Tue, 16 Jun 2020 18:32:27 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id w18so3127597iom.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 11:50:27 -0700 (PDT)
X-Gm-Message-State: AOAM530Xo2OnyhbGOOYPws48y5SOCXQ19xUWSntdCCb2L/KhMn/PulWk
 XdwwU3UsF+4TNPWw9g6BLZ9MYSP38niOyEPhg30=
X-Google-Smtp-Source: ABdhPJxr/DwJulqrEubaMsKuOKnmSpHZDx7cjVqmaFEVqHNmlSGrGq/seMbcc9fj4t3I1CZ79q96HkzcyvOoriWq3Lc=
X-Received: by 2002:a05:6638:216f:: with SMTP id
 p15mr27751758jak.86.1592333426829; 
 Tue, 16 Jun 2020 11:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200616003654.1058035-1-Jason@zx2c4.com>
 <20200616101627.74dd1542@redhat.com>
In-Reply-To: <20200616101627.74dd1542@redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 16 Jun 2020 12:50:15 -0600
X-Gmail-Original-Message-ID: <CAHmME9ro9FeGvKjO+QLgWHFHQvChNYz=T9sAGjkAMu41-YS9mw@mail.gmail.com>
Message-ID: <CAHmME9ro9FeGvKjO+QLgWHFHQvChNYz=T9sAGjkAMu41-YS9mw@mail.gmail.com>
Subject: Re: [PATCH] hw/acpi: specify 64-bit acpi table
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=192.95.5.64; envelope-from=Jason@zx2c4.com;
 helo=mail.zx2c4.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 14:50:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 16, 2020 at 2:16 AM Igor Mammedov <imammedo@redhat.com> wrote:
> On Mon, 15 Jun 2020 18:36:54 -0600
> "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> > SSDTs cannot address 64-bit physical addresses in 32-bit tables, so we
> please clarify what accesses waht within tables (i.e. be more concrete).

If you add an ssdt or a custom_method in, say, Linux, your additional
methods are limited to 32-bit address space. For example, this is
invalid in current qemu:

DefinitionBlock ("blah.aml", "SSDT", 2, "", "", 0x00001001) {
  OperationRegion (BLAH, SystemMemory, 0x1ffffffff, 1)

But it becomes valid when applying this patch.

