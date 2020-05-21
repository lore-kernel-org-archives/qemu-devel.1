Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F6EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1745207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcBKGwCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1745207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnQ7-00021c-2M
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnPS-0001EZ-IW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:47:03 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnPR-0001Vk-HG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:47:02 -0400
Received: by mail-oi1-x244.google.com with SMTP id y85so6534578oie.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DMAmRsESsVaiXOEOCuUhOQFWDk/U9e7hEkT+oRLG0gM=;
 b=tcBKGwCcU0lLzrRJYbqr5Fzz4nOtMXiav6wgRA9ZPcBVg5yDAXZGwMBVU+QLfMR1hN
 C/GP3SI4fMYgqTGAYYwKXBZntijIv+nHFuy6eYtlca/PdM0wDIc9kRLWa66E48R3W7Oc
 frTjoDEsPM2WyVSi+9KTJtsQ8KvsvQ07Bs8R3y96UrmF8z/1sy5GDeZP4OHrjwf9Oxku
 9xZLXTqzirHZ7y7wMLHHYXDR3a+27xRidSXZ7rutR+P0GrjgNvZ8gcCYoYWFbQPJfLxU
 w3OjQnSebpKuHsB5AK5YlnbTNedOVN59oDZtlLxEajt0Ltk2r7+7of+oMjlhlf1vul+w
 qGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DMAmRsESsVaiXOEOCuUhOQFWDk/U9e7hEkT+oRLG0gM=;
 b=DX6ybQgkB3DaR4Bq7F585JeN2d2qNoxU4t/duAVa4TYSaBtxnEumgObM3htkVwTIla
 Fi/5xUz/Lflzo1h5c8L9HeOX1oedzfYMCweNd7ASwMLBdPN5mjwySYxi4rOetU0T9Ir8
 49oI7xZajp6lBfmNiE9CSwKQ6DdJK81rNtqzCMM9xjzX6BLEv22oADoi61jLoAn9IzOM
 qBJgGoAPDMMjz+zW/U2Fy19O5S/q6bXsya2NVfIIic7kAj64oXCzoPW0RXsUKKenv8NX
 +3fgCbq6tTxuTZ5qTzijaKPAN5G03j4sUN9N3FcPCNvD/PJan15rdDks5WHLbSZVAk21
 Q38g==
X-Gm-Message-State: AOAM530aUWLHlIfstfM5YLMC+nKZNQGdjE/DILkJVQvefNdd44tm368R
 prwWkGfKNdTHDF7pGlyRUZoiV7xSm5NFSRLnUNLNfQ==
X-Google-Smtp-Source: ABdhPJwVynKI1/9NKpKzPuDdyr2kosB11e5Z7fEvzm6V4EVzDxuh3dt2fiGWZ8Ghbtu23C18bKAti9J22CiPd6SrM28=
X-Received: by 2002:aca:ed16:: with SMTP id l22mr6821973oih.146.1590076019663; 
 Thu, 21 May 2020 08:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200520084316.22057-1-kraxel@redhat.com>
In-Reply-To: <20200520084316.22057-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 16:46:47 +0100
Message-ID: <CAFEAcA-ihkKnmGODR8_1SkUiFThst_5pK-jy_ge6qm_qPPHQXg@mail.gmail.com>
Subject: Re: [PULL 00/11] Ui 20200520 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 at 09:44, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit debe78ce14bf8f8940c2bdf3ef387505e9e035a9:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20200515' into staging (2020-05-15 19:51:16 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20200520-pull-request
>
> for you to fetch changes up to 7b23d121f913709306e678a3289edc813f3a7463:
>
>   ui: increase min required GTK version to 3.22.0 (2020-05-19 09:06:44 +0200)
>
> ----------------------------------------------------------------
> ui: windows keyboard fixes for gtk & sdl.
> ui: require GTK 3.22 or newer.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

