Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5DCC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 13:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8246E2078D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 13:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW3w4r/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8246E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Tid-000742-MR
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 09:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9Thw-0006dj-D9
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 09:37:20 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:46004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9Thu-0006Kb-Kw
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 09:37:20 -0400
Received: by mail-ej1-x641.google.com with SMTP id si26so5770043ejb.12
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YSkv3bbGd337dWgAItmL8ABwJUKZdISj7p1H3+EDufg=;
 b=HW3w4r/FAuc4ejzL4E4iKS+LV7cr9K+NqT7vqY6087yJVnZYfJicd7JZq6WvB5zHFW
 SYNfLscSWtYcQgWxu2XCXVeZPxoQ8c8OhSoe2rwBYWyMtArjz6OGZ9A9sVDJllPixkBS
 nrPKG1eaLQOCxFJyuhrnAGvI7+Mzm0XX+P5xQqjg1zAkd/niKHL8eq/2fWnULV/OdvoF
 OhzE14T7P11SRrDUxwMHf2za0huAdgIJMRJnH+izUP3oMKVNxio6hoMCyleMm+6KzQK7
 t/t6frg9l371nN+Qr+N0nDjim4uHBYXAlESey7PRP4nnBYXUm6xeUFMs1N9PREzM19kz
 dH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YSkv3bbGd337dWgAItmL8ABwJUKZdISj7p1H3+EDufg=;
 b=U2RzSEG8lCEDf2knc4BwqK7/pkFxFZn69m5ojyY4+6HYt0dcXuRtKlKg+LEIx4qXU/
 VnBOP3y1LCm2ddKtI9HDeJX3D11bZWAh8A1gRbh9XDDzXJWsI8XWnb33OP0FwhhsE2Bk
 UOl145AfAJ/+c+i4K4PiQkOKKaz36OgvCH8MnPlYTdPr2WhZWUWBmNipnYWIEun25BQf
 +EmyqPrxhPrvIrARig0wRcStV1sysvsyHExATFZq1Bjg15mX/zfmaRTLF9/zMhttFZo2
 Lz0OyAYQ51n1JdONKj9g7z47p+bUSLS/MkBshcL0uzS58nwXYZs2HjPAGGXXGEVxNSUS
 DL/Q==
X-Gm-Message-State: AOAM533Cug7WLr6FPPiDoYzMkPLRken5FiTKYI9vnHXFc2RpAUyZyHpN
 1/kn6qeshKaPWaUILIC/Yz38MzVuL6JNK1IvdKGVPg==
X-Google-Smtp-Source: ABdhPJxXGakVEuANILjDaksy57mTl8c3rWtI9cWQvkJ0JWtiHBYNcWMsxmwxQBND32xcrh8IFlfKN00K+z0ODmQT6R8=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr7503983ejb.4.1598103436926; 
 Sat, 22 Aug 2020 06:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200819063659.16082-1-kraxel@redhat.com>
In-Reply-To: <20200819063659.16082-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 22 Aug 2020 14:37:05 +0100
Message-ID: <CAFEAcA91-4Qqhtmg9P+zyUiHcX=e8VDoO61=J7v4cjd6wxMJRw@mail.gmail.com>
Subject: Re: [PULL 0/1] Seabios 20200819 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 at 07:38, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 672b2f2695891b6d818bddc3ce0df964c7627969:
>
>   Open 5.2 development tree (2020-08-18 13:44:04 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-20200819-pull-request
>
> for you to fetch changes up to c180ff4c7946cab99dcfdf3d2579cb8230008534:
>
>   seabios: update to 1.14-final (2020-08-19 08:35:24 +0200)
>
> ----------------------------------------------------------------
> seabios: update to 1.14-final
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

