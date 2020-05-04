Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7493BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415692071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkEqraYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415692071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVY72-0005z0-Fx
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVY6K-00054n-LO
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:13:28 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:34004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVY6J-0005PE-Kl
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:13:28 -0400
Received: by mail-oo1-xc42.google.com with SMTP id q204so2267631ooq.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SWJV4LEKJvjbK2yln++dNu2xdGV/QYWWYugOVX772lM=;
 b=SkEqraYRcq0PddMOW6g3eOzTokDYQsY3oq83TVjCIJo3rmUc3pPFZnALJMZ7KL5oTA
 TScbFZW/IeEDyha8wEI3oGxJH7EBhxhFOrb76EuNmAVA9dx6mY+ATAJTH7bZl1g2kGOx
 FeHZs+LEFjkOitzaCMnJWkQghw78WcAIA6ystF1t0/FuewguuPZRrMZ50pkmg9Xd23g7
 aHFwBGer/fHavMUN9lWCdOTrgrNX3kD9c1Op0ZE/lL4psYPv/wXlVgQsVHiRCVvFzDM0
 fhGtU1b8xtlGKoCeKhOg+vUOtsbCxYdwNPSrwsM4qU/ZPHYemyZq3iZe/ToLvynN2kFW
 Np7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SWJV4LEKJvjbK2yln++dNu2xdGV/QYWWYugOVX772lM=;
 b=C3lHDwTqjEy3obRSSOx/rfqqcr7FaNge6/tGULATfBbfWO41hpgnH+AXl24IV2YpkA
 AsOygvgikpLxCbP5oIYOdXqzAcqE1TYQmXKDGMp8QwgFSRZ7ZrqQhmftsd7wBCoW2PVD
 w1n0YLTHS01PxgsWZzkqEvcPAmf+qjycD9VULsmei0kf6W6eUa+qY82Wv0/f4qAVtEeb
 4hGYC+jT/cS6ROIek6YbggLWfqxOto5IuzJer0Y6YVn9WmhQJfVp+g+bS0O+bkA0AvJJ
 Md3FXKqJJ++7Xq8C59eXfJckLYtJGQO0GjO8A0Gcs9tvLTxcsHlLjDXEpaLjG4XstiDV
 PClQ==
X-Gm-Message-State: AGi0Pub2vguVG5hA2m6d94Jpqr546ryRpJa8qxg6hksQgQzM/b89Y8hS
 ELngzAhF6NcuDHlfhwfHiwuKtr06kzhPlooMVPmBTw==
X-Google-Smtp-Source: APiQypJjWH0LJHNfIILzEdQeDUSvywabzEyCzo61RASRHesJJDO3TRr+xic1vxD4qtRzVdBHgGSQKaKOmGLC+UnNdgI=
X-Received: by 2002:a4a:8253:: with SMTP id t19mr14258321oog.69.1588587206247; 
 Mon, 04 May 2020 03:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200427181649.26851-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 11:13:15 +0100
Message-ID: <CAFEAcA-MJtGvFbvYmqfKk_H_d3_RWP5Q7AeR37z791zMVAq1QA@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] hw/arm: versal: Add SD and the RTC
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
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
Cc: figlesia@xilinx.com, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 at 19:16, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> This series starts with some basic cleaning, continues with embedding
> devices into the Versal SoC (as suggested by Peter in another review).
> We then connect SD and the RTC to the Versal SoC and hook it all up
> into the Versal Virt board.

Applied to target-arm.next, thanks.

-- PMM

