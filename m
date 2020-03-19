Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFFCC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5C12071C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9RmwiJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5C12071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEuNd-0007oH-45
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 08:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEuMl-0007E0-Ja
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEuMk-0001Yj-ED
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:33:39 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:36326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEuMk-0001YH-7n
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:33:38 -0400
Received: by mail-ot1-x334.google.com with SMTP id 39so2167855otu.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K5tEMVBP5CTSTwVX8RCh3vxJKBlUzd6wujHFCvzurXg=;
 b=b9RmwiJALnr1txRvFWo4D5bx2yCFFaAqmF8fOOt+FM7DSkU/iz0VUn29l+jBJB/pHN
 qiVaT19Y7yVrr7QtENoxEPVb2riaYKuvG/KJqCaAcoZb4MtoBqr0waSvZ200ku8iM14U
 Aj+4qvHYX4OTtOjI3EgQGFeWIrQoWGTnb0Ehskc3/VV9dzlbFUf3X/vfe6+IpCTOvD5a
 /0zJHSGWTXVfZgFtdJfH8eAOdvHLaXSDFU4JhTFmpVHZvec1ry+P7IcqbV9WxwTEY6mu
 aXmC6SGG75wvcYu6fm5QXQh2ltOf6NxZAXvkrm27z4hmKpHI76HO8kFYN0VK0JrBgpD2
 Retg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K5tEMVBP5CTSTwVX8RCh3vxJKBlUzd6wujHFCvzurXg=;
 b=JCK1KeDMBkiGT2pJAJOlj3p0XJTzIdbVTi8YooCtFd9/vgJ3i9+1Xo6E4sI3cTX0jN
 fV0A9bQG7FkgssvqJ7YOYufdp+9vtrYR4owWyw1XRuIbrnJRZ8on1NYbmhbxr21T6N8h
 tn9nivoftzYn5us5HPzaTpJ75lgUmcRHJsdgcryTLb6jSXx9cK9872U5k7tqWLDd7g0Q
 uaxkt+tIQU3guSHUWRGRbBh0xGfn5uvghAelA6IxU+6javRWlD6zhWjHss9OhPYO8pwK
 y0tKUptGsMvDsrMGr4Uo7YCZjlz12LYfk45dNSbYEbXNiTXKHGo2nzYtTEV9GVSvCvIS
 BdZA==
X-Gm-Message-State: ANhLgQ2metzfRguqP0EMLtfn0es9R9MdRB5QC2xF9J1c6fOLn+D+DB9x
 ROVS8AuVPHvA3nl7trp9fN4KnZ3Dn6xzvlBi/oA/BA==
X-Google-Smtp-Source: ADFU+vsc7NsUZk5EVIgxTbX+TF4vpPS+uar8RA9py8nThtOWteiQ5j079NScD4BJO1vGPICe9qV2Y616mQlXxN4efKg=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr2098980otm.91.1584621216858; 
 Thu, 19 Mar 2020 05:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200317232329.22362-1-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2020 12:33:25 +0000
Message-ID: <CAFEAcA_7p_B8U3W4gV2rT5JE3djE=gy_vs5vUcWVjqYiVan3dw@mail.gmail.com>
Subject: Re: [PULL 00/20] Ide patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Helge Deller <deller@gmx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 23:23, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506:
>
>   qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 7d0776ca7f853d466b6174d96daa5c8afc43d1a4:
>
>   hw/ide: Remove unneeded inclusion of hw/ide.h (2020-03-17 12:22:36 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

