Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC45C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAAF20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7hilh0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAAF20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqPl-0007Vb-HC
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 14:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqOo-0006fU-7W
 for qemu-devel@nongnu.org; Thu, 21 May 2020 14:58:34 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:34817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqOn-000574-36
 for qemu-devel@nongnu.org; Thu, 21 May 2020 14:58:33 -0400
Received: by mail-ot1-x334.google.com with SMTP id 69so6369336otv.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VUXXS2b4NKm0Um/uK+1jXkjiOxSziLQSg6mTY3/bpkY=;
 b=o7hilh0u3YRVigo6FWrFuJtElYKVQcF0Iwep5ORIds9PNIhkGvLHEHMcNV1k80zp87
 I/JpwreRHZ0LIyTfUnJDFeOGuYaGVrM/j0XaHPAOzf/MsGu0pgE9wRnVfl6aEcocEhRd
 JUcKE8qcN7DFMPcVff8Lk0PhmpPw9SuhOrlSzx/SVDYucpZ8oSKDdjUGmgRAiQvH5pUp
 cwg4vaUW1B3jOSICEkfmNIbOI0YeTEAhFL3sr8Q0JqQMMaRT+o7dy/N3Wk3Pp0wPznTj
 Yf5Tb1PvSGInbRme3iZNJ8pRcfBwAtOgscyeN9BgX86iOBzObdNdsJtno947O3flNy//
 vgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VUXXS2b4NKm0Um/uK+1jXkjiOxSziLQSg6mTY3/bpkY=;
 b=Wa+tUUXSExw3XXmRAlzpp50+2bKGKvBwvldQlOhSXxB8Xr9APReMLUb7XmJLb4hgNk
 RHiNRGiNouU/lSiRPgToYfNe/1f5NJBDrX2VN03EQjQSGJUeToyEcxBIUnvyrLGMh5ef
 hzwb4ywNgv7XcdbMCzJITcS7cHhlnfd923LHGfT6ERVvOKvrGhba18iSi0d3+ClI7weh
 7NByIJ3UQivWZWun3f0lB8jTEzuF0xAnDlt53yonhF0znReqo7+Fg0RW/RwJC+2Rafew
 cM4C9ta0SI7ZWn8GyMYOG3ynJt1CMvVpL66PGELyTnj4xnjlQBLN9o2ndmn7lLTM+rnJ
 22IQ==
X-Gm-Message-State: AOAM53278wdAIT5ag2jgd6djWIJ+DvI0y4x/Adp5gWPE//QRt6y9lH1d
 OFK4YOcdSTSjAo/XNzybp+4zSGbr/GZCfiNYl57f9O4c
X-Google-Smtp-Source: ABdhPJy0XMZBDBkdClFZcIBxqUyFD5S9rE1SRo/g1L7V4NJshGO84Q08INJ7y6nIi33NTAitd4CON+xQSERVcwYl6+g=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr7763235oth.221.1590087511851;
 Thu, 21 May 2020 11:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200520130025.2201467-1-berrange@redhat.com>
In-Reply-To: <20200520130025.2201467-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 19:58:20 +0100
Message-ID: <CAFEAcA_KQZysxZ3xx9xznh5xEdD=ja7pxh7U4oqb-XmFPP2WCg@mail.gmail.com>
Subject: Re: [PULL 0/3] Socket next patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 at 14:03, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit f2465433b43fb87766d79f42191607dac4aed5=
b4:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2020-05-19 13:42:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/socket-next-pull-request
>
> for you to fetch changes up to e339273bfc514824410a49837e4f16dd4e51ae8e:
>
>   qemu-options: updates for abstract unix sockets (2020-05-20 10:34:53 +0=
100)
>
> ----------------------------------------------------------------
> Add support for UNIX sockets in the abstract namespace
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

