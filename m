Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479C3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E18622243
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTCMPWQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E18622243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSyEB-00078R-EQ
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 04:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSyCD-0005fS-NC; Thu, 15 Oct 2020 04:01:09 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSyC9-0003LN-FV; Thu, 15 Oct 2020 04:01:09 -0400
Received: by mail-yb1-xb44.google.com with SMTP id s89so1496474ybi.12;
 Thu, 15 Oct 2020 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VBe4VZKjS5tVK1y7r408nzhAt/xfzpY4zJRS3MIVUqg=;
 b=gTCMPWQWvLMyuODYxkn5iNAnZuxsNq3bZOPngizn8v6BKMlY92VbgkgK35UMbabVGf
 mpq1pkqzyq+q9mWjFeJXXap0wInHxAb+SFteBIcT/nHAOwbsFl9R+Ct73qlSp+pj1BkF
 D1w0mY1ZOZCj5BeaM/BVZo1XKkKExmPO/W/cunRDbOyyp9e9SqRuS8FAtiHdC5HQXVtv
 NhHIDsvGusgd416BSabyS/SUYsZTtSa8t/gShELA7Mojb2L4fLwEOQWDcVT+MSyb13wB
 Jjl+iSyaGq8W+DbSw2C1XkEsmU2g/narwLTkLVGLQG+kIAp2yUiNkm6W5MLyKDGWLg9e
 pW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VBe4VZKjS5tVK1y7r408nzhAt/xfzpY4zJRS3MIVUqg=;
 b=jAsL8Yj73Iv9by42pKN9aIP6ScIbuLxQj68YqmH/bzaM6FwVYChlrXYIYaq51gUIYt
 0kYfBikziF4W/0tBQU0iazAhGatXk9DRE03+RQ99w4Ei+QYmi3Qz2QipuniUJdoVam8w
 h8cmfzFGTREICF2geJsBgTuEAHe/4btMBoGLkJ2KrYtCjJdRCgko2qx2Ob7XKl05op23
 C67HE7//dPzWcoZgAbWZmUZ0PmaXxkyntcNItu6vSiwFxHxQjgH0BVz9q0Ij7cZF1qtX
 0N1Fv8fIAkzNEdJqUc58o48OJtiy9W5cRgt9+hSuiGMVEmVvaPxcuVNAFKeaeax1t6Bf
 MS+A==
X-Gm-Message-State: AOAM530hSewEZdf5hyKf9/Bii/HgsAIgp0cRxMNNx1RsjWU/yutvmTFK
 ShJnGs2+qB6s+ftMPXabz0aQW35Bwv0apGdkNdo=
X-Google-Smtp-Source: ABdhPJzEjEp0HTeVXo4L6OBDqErGibF5YZjSm3+OFi4KKdd5qrvS7hIJ4ek+G0kt2+bnAuxScYjDmp25ZAAtkK2OCps=
X-Received: by 2002:a25:705:: with SMTP id 5mr3905846ybh.239.1602748851133;
 Thu, 15 Oct 2020 01:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201015041424.23090-1-green.wan@sifive.com>
 <20201015041424.23090-2-green.wan@sifive.com>
In-Reply-To: <20201015041424.23090-2-green.wan@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 15 Oct 2020 16:00:40 +0800
Message-ID: <CAEUhbmVViX2MyVuv-UfC11VF2jHULvUe7EyW5633qy7FDnJPRg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/2] hw/misc/sifive_u_otp: Add write function and
 write-once protection
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 12:15 PM Green Wan <green.wan@sifive.com> wrote:
>
>  - Add write operation to update fuse data bit when PWE bit is on.
>  - Add array, fuse_wo, to store the 'written' status for all bits
>    of OTP to block the write operation.
>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/misc/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
>  include/hw/misc/sifive_u_otp.h |  3 +++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>

