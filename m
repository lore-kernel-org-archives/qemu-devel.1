Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A274C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664B32072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8CLofGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664B32072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgA2q-00048Y-K9
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgA1f-0002cZ-Kd
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:44:31 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:36110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgA1e-0003Ut-8F
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:44:31 -0400
Received: by mail-ot1-x32d.google.com with SMTP id h7so11454370otr.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tqd5by54gZFbBsAGcQeUM9GUvtvQtPNN+rkhCD51G7A=;
 b=A8CLofGrUZ4DTMwMIV+jQURFXCsXAvJcDrZHnuBk8HVw9KwDZAOtu0uR7bYnv3r1l6
 Dr7Fm1MTbH5L1sqejRfCNKOxZ9iOlOEg6i/QbQh7SKkMxhNXK0UD/I2GEcVIsAIuHX8W
 bASfGPMTP/7A9AWfRhFKhtKiMPJwU/4sr2E2CDz/rFL9V/U8m3d9M9fE1r2XFScTYyyK
 ZokTCx2AocePGDWtIY0VH/IPwVYikMxU9n+/oP3hYfi9t43YBgQc/wsMPL0oJ4FuNS//
 HAsluUulfE74m5Kn1RsOdf3agAyQ/tOrsAqglB10rBcewLGSpgtzyK9U+vXpjLnhgLnY
 acXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tqd5by54gZFbBsAGcQeUM9GUvtvQtPNN+rkhCD51G7A=;
 b=qzeFxv07jk/Bln62cFAL0kDlKkacGNHVei6HnZPFUfNmAkBky72CiT9JU4l0eRu+oT
 nc+BF+tn0G2vQ6mm3G8UAXhfaKLrXadJtJVWSV2IVENKEAoUydX7jrSfuYHDE1wwwVPb
 4Rw2DwllbI9zXeYj4TWTMZCH7ojlPTxH+Yw2vYL8fqYvTzGBCpsbGzTRMd6mYstoRhig
 6aD/iEMirAkwncBLM0StD2cP9MWffAzLa0F9hW8ttAKOlCsj+wkEK/UrDMSqfIrehHgv
 hoBFQnK/+hk7rdKgHIMtm9Q/KgpIYMmGwixRTSsl3uKHm4zUngp2rT75HdiY0mExo9u8
 s6Xw==
X-Gm-Message-State: AOAM531W7C8qPBmyJ4semDgzP2rIoHTUDbUEg2GrW7Sz+pKMFV/VHtq9
 eLAd8D8WB8csY4aAVEAYGh++1bfjr52u0BmFe0SxEw==
X-Google-Smtp-Source: ABdhPJxlygXCGZ5wgZjoU4UNtwdDM9BteqHwOShrtQdv2WRCgOWy+dGR/AujWc3sTz1m46IKCzeaIpTBYPxLDarXpd4=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr142715ote.135.1591116268839; 
 Tue, 02 Jun 2020 09:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <CALQG_Wh7eMt9U3gWkZZGDq0RFvWfuSVoiNBRNnPS_cDVfUc30w@mail.gmail.com>
In-Reply-To: <CALQG_Wh7eMt9U3gWkZZGDq0RFvWfuSVoiNBRNnPS_cDVfUc30w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 17:44:17 +0100
Message-ID: <CAFEAcA_1+rDcjD7Lyk9ESSkPAKmJwF=0ZdwkgQYUDp8Gtn6jHA@mail.gmail.com>
Subject: Re: gdbstub.c CPU clusters not handled for ThreadInfo packets
To: Fabien Chouteau <chouteau@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jun 2020 at 17:25, Fabien Chouteau <chouteau@adacore.com> wrote:
> Using the sifive_u machine on qemu-system-riscv64 which has 2 clusters of 1 and 4 CPUs respectively, when I use the "info threads" command in GDB only one thread is displayed.
> This thread is the only CPU of the 1st cluster, the CPUs of cluster 2nd are not listed at all.

By default gdb does not attach to all clusters (this is IIRC something
that can't
be influenced on the QEMU end); are you explicitly asking it to attach to the
second cluster?

https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg07035.html
is a mailing list post from January which gives the gdb commands which
ought to cause it to attach to the second cluster on this machine.

thanks
-- PMM

