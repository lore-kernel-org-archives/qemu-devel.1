Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F9CC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C372B2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H26lmreT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C372B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPS49-0000Kv-0J
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 10:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jPS3Q-00089u-A5
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jPS3P-0003UD-1w
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:33:16 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:33161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jPS3O-0003Se-U1; Fri, 17 Apr 2020 10:33:15 -0400
Received: by mail-il1-x143.google.com with SMTP id q10so944161ile.0;
 Fri, 17 Apr 2020 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uiNViT9fYax+iMO1ynhvuX33SM8iqyUJVdcCDtlD7hc=;
 b=H26lmreT4mFoRGzwbQu4O+MjnyzjRfQm5vOnRcyTYxhSNNfH2BKQe1U3oo+vAV+WT3
 6CwckoyhO1PQ9PQlRT5NQWUiQlIL+wa4C7PIczRUCEqUE7GJpCQ2AD/H7FtalqeH5IVF
 EyDNaKtkqVKTTSZurkGR09sV/a3LohyFyjIjsFHxMQDDanNT8yWsw4uJQsrdBeH+YzEa
 TqMZK/xE3ZYUbwhFA2fucqb7zwMT0mKI7Pw11+/67x9FkIharLEps8LGTKbAN+gxLdi/
 ce1iHw2/IciRODlN1hEk4gG4bM3fjXqVJtsQISIzvQzmPsbmlIe3+Xzfp2+uIipjyPJN
 0axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uiNViT9fYax+iMO1ynhvuX33SM8iqyUJVdcCDtlD7hc=;
 b=gGGNME3WHKRDZi6nh+nowQ8ygK03j7vxldU6aqUrl+UBDFmSQQXdl+Jm04VgHjuCtu
 TCobVnuuUxt1VmmtCnRaPkKvKsWrNlDYxiPFHGL/gKfaamAPRopSMRP/W4V3url4+tjF
 781oAhPh11IyakRQz09JNJ1DojRQF2oqOAz4W1XTx9bkekK8OkSNmMCWKMyqO578IbNw
 UTnazkWTSZfgJW059B2baLlUF3lqk2fGtm6DT/OxxuVInB8L05G0MfxrthTzNuyUFQZT
 WwPVGw7465OErxYF+/0AwAZhObV2t8O9b4G55YJicnRYa5pFzPvQK0taW9HtYPrI5WeB
 ayAw==
X-Gm-Message-State: AGi0PuYMxyQdt0Avjo6PhmXsVGAw96VBZ8p8gUMZo8HMLJXKxiNCWe2g
 LyCkZFAzGds1M8QBR8V1vdtp8gmtL81cn9no7To=
X-Google-Smtp-Source: APiQypI4+70jMvGAuj/bC9TCUvFZ8IZ04YHUEZDDwV2J7hBswDPu5I+MID5PKAiBEmtOS8mZZi/M3HzwGgVMf390ZZ8=
X-Received: by 2002:a92:aa0f:: with SMTP id j15mr3267731ili.211.1587133994054; 
 Fri, 17 Apr 2020 07:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <1587048891-30493-1-git-send-email-sundeep.lkml@gmail.com>
 <CAFEAcA8AOSEK4w+AvyLgOc6gX83_XN7FVvU7kkxpuTuSO3cz9g@mail.gmail.com>
In-Reply-To: <CAFEAcA8AOSEK4w+AvyLgOc6gX83_XN7FVvU7kkxpuTuSO3cz9g@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Fri, 17 Apr 2020 20:03:03 +0530
Message-ID: <CALHRZurOmKAO64VM=wKtTFMVSU5hwZm_XyZjCrzY9r4AzkDRfA@mail.gmail.com>
Subject: Re: [Qemu devel PATCH v6 0/3] Add SmartFusion2 EMAC block
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sbhatta@marvell.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Peter,

Sundeep

On Fri, Apr 17, 2020 at 7:27 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 16 Apr 2020 at 15:55, <sundeep.lkml@gmail.com> wrote:
> >
> > From: Subbaraya Sundeep <sbhatta@marvell.com>
> >
> > This patch set emulates Ethernet MAC block
> > present in Microsemi SmartFusion2 SoC.
> >
> > v6:
> >  Fixed destination address matching logic
> >  Added missing break in emac_write
> > v5:
> >  As per Philippe comments:
> >         Returned size in receive function
> >         Added link property to pass DMA memory
> >     Used FIELD() APIs
> >     Added mac_addr in emac state
> >     Used FIELD_EX32 and FIELD_DP32 APIs
> >     Simplified if else logics in emac_write/read
> > v4:
> >   Added loop back as per Jason's comment
> > v3:
> >   Added SmartFusion2 ethernet test to tests/acceptance
> > v2:
> >   No changes. Fixed Signed-off mail id in patch 2/2
>
> Applied to target-arm.next for 5.1, thanks.
>
> -- PMM

