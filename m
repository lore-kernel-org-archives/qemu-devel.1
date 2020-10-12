Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE58BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C972076D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsZMoz9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C972076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRznL-0004aO-7h
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzmb-0003zs-Cb
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:30:41 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:41907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzmW-0006qT-EH
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:30:39 -0400
Received: by mail-ed1-x52a.google.com with SMTP id l24so17427764edj.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=aBauw5J3GGlysOot+el1FByNm8LGS4GQJYuQMIz4EX8=;
 b=wsZMoz9GYAJBdBl8IKg2cgxMTNI7ElsUN8UzbVG5zKAd+k0KSst0W/Q1ai00OjfwYL
 EfGIrDG3s1jlBWOvHX76qoTJvwLGy5gHxRpAf/tXSHuZGBqIlKVxaqGRMORNgznHFW7D
 oFDHfSLJJJdQg0I8t8rFr4GGpnbnKf8mKOZ6osO4/VHM59yHp0+KDrduM8ScEhV3sapu
 hjpeohhoDdllVoybAQLl+nVPM6hhIG0q47mJED2FXafnPBaKDBNoptrZI1/zQBQJaqp6
 Sf+WChpdoJqxUu0QVaIXkuRRr7GhwZph5YYTgkhSIJ7+oe1mQPr685UYtO+1v31ZJqj0
 YO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=aBauw5J3GGlysOot+el1FByNm8LGS4GQJYuQMIz4EX8=;
 b=l0JImX7Kr4Ee76GodUJGNcboXhu3Vdg067ZxLm4eIlvqEpwkN4HRguHfmzhxgoAAOy
 Y4rJakAEIkYtUexLzF6BUtavYAIZeCd2sp76JAaXC113A9OSsdOHduoH0C37F1PZmrzS
 hI5/Qt00ynB/LfWZT0WyGkFKCzXtP08mnwQyFnSxthYqcnJ6zj/7jYHA6olFWPZAV0BQ
 g09qfTZLkveTVTIL5tvlfIUJVDWiVqFZW4NNnotTOSIRm81Jyx7uVADk/aEIeZDE/BSx
 7qTJ+hCaSgJySf38CrsXiCfJmcGHLZTcmdio976ZCSTenPu6gx4hwmZPjRpVAgK8PlMR
 E6bg==
X-Gm-Message-State: AOAM5324SpNumiKAnfx1hZlh2660cxXWSRiNsOfmPeYgN9uJBDTM+Hte
 4duEMPrgaV71hm7j0413YOvTw0Y8wYr5EYOmrx+wig2BijXcLoNN
X-Google-Smtp-Source: ABdhPJzpu8Up6TgaoDHajM6qUQHRL6lwNfMaT6r7T1QRpm54kYJ4Zjcwt4/HmZBZwSwuh//Nj+7gJeQt5WxzaB5pYoI=
X-Received: by 2002:a50:c34a:: with SMTP id q10mr15316951edb.36.1602516634297; 
 Mon, 12 Oct 2020 08:30:34 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 16:30:23 +0100
Message-ID: <CAFEAcA9xKiEK-XJVf-=zqwjFVqtKF3pp112-x8E6X6AMrM5oRg@mail.gmail.com>
Subject: proposed 5.2 schedule (softfreeze 27th Oct)
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas reminded me on IRC that I hadn't got round to drafting
the release schedule for 5.2 yet. Here's some proposed dates:
https://wiki.qemu.org/Planning/5.2#Release_Schedule

which would put softfreeze on the 27th Oct, Hardfreeze/rc0 on the
3rd Nov, and aiming for final release on the 1st December or a
week later if we needed an rc4.

(I know the 27th is the day before KVM Forum starts, but
at least this week it's a virtual conference :-))

Opinions ?

thanks
-- PMM

