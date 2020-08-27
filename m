Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A51C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBD820791
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd23iq3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBD820791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEdG-0001Z9-RS
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <diego.viola@gmail.com>)
 id 1kBEca-000132-TO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:55:05 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c]:45954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <diego.viola@gmail.com>)
 id 1kBEcZ-0007Pl-3e
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:55:04 -0400
Received: by mail-io1-xd2c.google.com with SMTP id u126so5138001iod.12
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8RY/eysVZE2qWH0Kc8Th8AmRJuHNm/BtFDgiPYcN230=;
 b=cd23iq3Th87D07Nh0T8J655S8opIAigw0Qt19aBNdfmTvCYdeSiyLy+AIuagBvXzgB
 JTP680eA8XCo3Nh9Y1oMM/GaBEIsYG++xwlioqb1rWQ1afM3SWSscQaRA0xeae2Khkk7
 LoZHmNSF6AItVzxAdAs6sI+bnwtjxsaEvtNxurAaqjC//kD5IiMy+DP/cg/JDw/aGUbP
 BPsx0HvgcLcrSrxF3zjuMPAE/U2yAydpN0FGby3LvIN4L0bp1ryfu6JLIR+4mGd+6uAC
 aGSXTDtkNY5I+6D9ApT821+sBAyMeExCEvDMeHd6vleN9sGYXmwCtfZlQyWo1Ri3BTlR
 4m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8RY/eysVZE2qWH0Kc8Th8AmRJuHNm/BtFDgiPYcN230=;
 b=MHHoarrODA5S0Y5oZHAZxJPysw7NhU5Sc9e3VabJdQ7kPUcsNNNNvMFUOy9ezhhXo1
 WFCmcBgEuAuKihQtWo5E5AjmKvi4FXlTiFim27FHWNmvk6OZrRKjMawoYEuj2yoCIJb5
 FT+ThOmJAo8f0mjjGxYPM2nGAloT0FsS9pPEFkzB7H1750EKZNg90JnoM1Djvx/pVmKf
 /jIOu+7RHahyI7HOKfKy9ej6CJbXTs4B3qZ6fmr8Lj/3KymI5juBKqyjDlA/SvHvEMds
 VcdcmEwGcrFcmu+p80ppNYcxXNtnv1m3jqP3mnIMv3nrjCrhevavdBsuJocwjDG1sgyx
 XuKw==
X-Gm-Message-State: AOAM5333Ojr+ilYVerpl+Uw++4eKggNCVJeKxzmCRuivPgbMdnNxd3Bw
 HZBjqgPE3Xq5lae43dah2A3WWNqSIl37yoLpg9o=
X-Google-Smtp-Source: ABdhPJw4lE+S8VqJ4eRlQCuspYEtrMKpDFdJ7E6lxesyc7nmbY20pE/wizQD4U8ZanZHGLt8azQuFLqRzh2x0h5qmhk=
X-Received: by 2002:a02:3003:: with SMTP id q3mr15628883jaq.4.1598522100426;
 Thu, 27 Aug 2020 02:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ToGPGh2JwaHC_6mmJcsiEDn6Qp4=zMD+UTGfiKo-yeHjxKKQ@mail.gmail.com>
 <20200827080052.aquvggd5beedfizt@sirius.home.kraxel.org>
In-Reply-To: <20200827080052.aquvggd5beedfizt@sirius.home.kraxel.org>
From: Diego Viola <diego.viola@gmail.com>
Date: Thu, 27 Aug 2020 06:54:49 -0300
Message-ID: <CA+ToGPE4xDqQFAELiXmN7Rr0ADS2P+8LRYwAZkhQgpk7yv9f8Q@mail.gmail.com>
Subject: Re: Help with usb-host hostdevice property
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=diego.viola@gmail.com; helo=mail-io1-xd2c.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 5:01 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > usb 1-1: Invalid ep0 maxpacket: 64
> > usb usb1-port1: unable to enumerate USB device
>
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20200826145239.6077-18-kraxel@redhat.com/

That helps indeed, thanks Gerd!

Tested-by: Diego Viola <diego.viola@gmail.com>

>
> HTH,
>   Gerd
>

Diego

