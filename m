Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B473C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076E720865
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6vPcros"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076E720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG5FR-0000nZ-3N
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 13:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <up.mauricio.g@gmail.com>) id 1iG5Dn-0000IG-7v
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <up.mauricio.g@gmail.com>) id 1iG5Dm-00068G-9E
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:48:59 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d]:46473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <up.mauricio.g@gmail.com>)
 id 1iG5Dm-000681-5e
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:48:58 -0400
Received: by mail-qk1-x72d.google.com with SMTP id 201so3192622qkd.13
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=kjk53kpI3XfON4asrTJ29u+1v7NRkio1ElI/09Y+f1k=;
 b=Y6vPcros75mMXZHdVHzRntflJ5pJ2V5htAMP81HpuA9yWPDWXahg7Eidp2tj57TmnT
 cZJSE1Y+wFjJ/JD4f2ot8vLwXYZKjf9ISQ4uD7eYT01E1+xmNKN64Nx0BMzpKWZnzYSj
 L22YKDqdHEe3qv5Z/mXETv6dqRb0GxNWt+DZSuSj6IsbKfT7QrsK1aR0YtDPHFmCjD0R
 cWIv+dGTODGg/FG8ANV4ZcxGfnx3oJB3wWmGr5GT1c2pQEcObgqTDpSlOOlk/+y0oFkA
 iOU85Hjan+KnlXYUL55cfOW6MMy/0dslZvCcOiIZKCc2fFlhlIjZqvU/LrY+BtdvQo/V
 vn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=kjk53kpI3XfON4asrTJ29u+1v7NRkio1ElI/09Y+f1k=;
 b=CBRKlrA/FT15HHcJKoi+fF/t1FXKfc97s4btPyMe/5LYnSPi79UgftDEJS1rMo1ApE
 5nF5yzJkkfAssIAB6OLDvecUwjSbnElr4CmqIG7vtELsUngmpXQKiuixOcJ736BoW5uh
 djlcdPiegq8kZdOMxFvhNykD7VyD4nGA9x9kBbbZNnOFfsrQDieHCrZwhB5DsdOna1WL
 L3dJdDBvRemFVMfxwfkK1dkRV6yYkqA789n4JR5MtPNI1JojiBUctbenJbA9irpRlHp/
 1BVvfrxBz7JuYEmDf4kSeJZb8+coIAkJIvOKG4d8/MiEfOF8OVXzNmEim13KXly7xUmx
 7o5g==
X-Gm-Message-State: APjAAAW37+kdD8VL1VeqJm0cX4+nOWW2f+akN+GhOZKsXGXdQQUOPd6E
 HM5YQ90QotkvtVpoHQVLy7LqdpmuVAiEd35nfivc7Q0R
X-Google-Smtp-Source: APXvYqxTXbxsoaa2TuK5CXYJJKPC7979+eyGPIltO76PALVpASKy4pXLf5LnvYmgsSMGYEaSeJH7GWcYXeTnu9QZb/s=
X-Received: by 2002:a37:7ac1:: with SMTP id v184mr5633739qkc.129.1570124936971; 
 Thu, 03 Oct 2019 10:48:56 -0700 (PDT)
MIME-Version: 1.0
From: Mauricio Galindo <up.mauricio.g@gmail.com>
Date: Thu, 3 Oct 2019 10:48:46 -0700
Message-ID: <CAOx2=+fZ4O_=8jU+XfDvjKVt_=kNyyKEW0UL6jxZQ_qenF76FQ@mail.gmail.com>
Subject: QEMU user mode execve
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72d
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

Hi,

I'm running QEMU in user mode and I'm running into issues when trying
to exec binaries within the emulated process given that binaries are
expected to run in the native architecture. Would it be useful to have
an option to rewrite execve(/bin/some_binary, ...) to
execve(qemu-$arch-static, [/bin/some_binary, ...], ...)?

