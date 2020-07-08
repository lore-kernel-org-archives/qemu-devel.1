Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF509C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8877B20672
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUZy0M5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8877B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCeW-00053B-Pv
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jtCda-00048I-Ja
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:09:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:36915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jtCdZ-0002wM-8P
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:09:34 -0400
Received: by mail-pf1-x433.google.com with SMTP id s26so6530829pfm.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cSfW7swPtf9W5qYNFaxoQbgmanbiHWZP73CaWNGOiKI=;
 b=VUZy0M5tjGWs0Q6vyeYnt/njF8MCNpU+ecYz1z2ZwSZw46HxhF2X+Jnj2VH6U1a54f
 uzMJjMwJuDxGhx8rvuX1b7SM8nFR09cwMTNip6O5PqEub8rq1+Sb71h2qoHdK7yk4OX6
 /Qfi20eljYNfjI85I4t8mLMdyBFVVlPBvJN2xBbVJRB8m8F8RpvRPYXet0KYtqwgYkZ1
 RzHhJM3EDYDgiTBK+QSRx+WjIg5en15cNZHWqUFbyBmUkq9TjZWr0KIPZ3dRjR9hdMFo
 +y/3gE4aPVf4uBkl1qpPYiJPy4HbJYtStMmltA047oBR3mUoT4tcsHz4iM0V6CRldKfy
 AWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cSfW7swPtf9W5qYNFaxoQbgmanbiHWZP73CaWNGOiKI=;
 b=AT8YFAjhQQ2/KYR6NzJ1eE3tUm9bUhxz6kjGpEQCfizJ34x42EsMbw4nDi/sM58/1S
 f4oD/xFIfNAgFukwzrOZnPzzX8fkJG8p18Sg20tbnoNjRPOm30hPO4jmiglbJwVMbLtg
 B4Myl4EBASQ59WN6zdmIKQUQ8tYukm5frOp9K3r33ABzjaIUzODO+BvT3iOq6OQRDwA/
 hNjR8AN4+cMn0agu3eDt24RF0hVkTzt9YIXP75fuaQok0eNuPvJTcKiG/yNokNi4AIoz
 LJjQrdtLZNuOsfHMiYWWqRLOnTpFQG3scvNtF67/PPJ0LzuU6S3itf0U9+Saeetak7mm
 qALg==
X-Gm-Message-State: AOAM531rGNtFi3AbdGTNTJAfaVLfiqaBH29Rl7QKh9GYb8DldZ2j0gFA
 70Kx5N2wo5xI0kzJDavQdIXowgVuVJUFRNat54Al0QSiivg=
X-Google-Smtp-Source: ABdhPJw/fNWJHKXX2gq2HTmyopyUJ+9I3BPvAfsUHtFwQ5IX5a0ylk30dfJGF/CBbrDOcxyiDEkkL3SYZiOmLZwFyFA=
X-Received: by 2002:a63:2b91:: with SMTP id r139mr52803339pgr.61.1594224571432; 
 Wed, 08 Jul 2020 09:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
In-Reply-To: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Jul 2020 17:09:19 +0100
Message-ID: <CAJSP0QXeOCG+7dQjm38gXrbPZaiyfMKzHFhaaG5s+Ya7_0n7yg@mail.gmail.com>
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=stefanha@gmail.com; helo=mail-pf1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <cleber@redhat.com>,
 Jeff Cody <codyprime@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 10:52 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

Great, thanks for all the responses!

Since others are interested in qemu-web.git, the wiki, and the bug
tracker, I will investigate git repo hosting (mirrors).

I'll send an update once I have more experience with GitLab and a
proposal for how to perform the switch. If anyone objects we can
discuss their concerns.

Stefan

