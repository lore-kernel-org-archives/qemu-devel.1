Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF21C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38430214DE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6jW1hvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38430214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9q1a-0001kt-B2
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 08:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9q0Y-0001IX-P2
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9q0X-00077I-7U
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:21:30 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:33768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9q0X-00077A-16
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:21:29 -0400
Received: by mail-oi1-x235.google.com with SMTP id e18so3843859oii.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=/DJ2QqMeAVZC4fxmKB106Kh1U5tmpfSgsdNG8qyBi60=;
 b=T6jW1hvEuFpgcFnXg7Lq5HG1iBlq6THCgWzH5ggT6jzRBFeGS1tmcTjQHXvYaH+M+H
 ZP84qYIXR+kEpkH3B6yk3xWGuTNlluamszcFjGq0g1qjgUFbiF9q8HtUSAZ0fUvxBgRZ
 Olwa4621Il1AcJvcMJ7xL4fkOV4j5JxCdP5hL9SE/OLWSVUYzm6ZYcz0NJOueJvLUVmM
 e+0107JrjjlcBa1saY49U/J5h3QZC6pOPXlCCarmDQpOHtGH//kH0PJnFuwcaDvGwQgZ
 0VoT0p9AQWeOTeRn077pfDa3LiirxjAi2b+SuyNG37VFak0sXI+GvE79Cmo47dWPrt1K
 cQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=/DJ2QqMeAVZC4fxmKB106Kh1U5tmpfSgsdNG8qyBi60=;
 b=ByjhnSqHuSrjD7t/KKuzHGbJ7OOz8lJ4c5MI9GI+iDSsJJ7KJ/VzJeERgxPTwDxOxx
 Lm9wxrSdWm4DmlyWILToCFcouf1Hlcy9MgN+ABQGzFdTPHj8wgRJHKYAjsaLTAd4Hgak
 gAAT5PpFTvuJ//j1egTrEeOx4JtulXcMFerrX5uznGO5oI0AkeKEC20wZEfnSrORCcQs
 UwZ6Batx6hCQS9lj1iRKXWUfaOd3+UMHZSAEUNB7blRh28MEACEvyuE5FsDrgPHW3nvD
 ZhUkLbanKeB30i0dDsi4aa0Up3xK5/ooDT2F1LgwOvyXZALIkkzBNX5a7h5Cgfl1hfvT
 tb2Q==
X-Gm-Message-State: APjAAAX3JZ/oC5kFodkJO4W62CYaKIbq+ZUKCe/yOTgKsPqUsKHL029Y
 +ENP+PHC6dMsE80Qm6SlHvBUcXaFfprVIcy48xzXy5MVSP0=
X-Google-Smtp-Source: APXvYqzafGtpLfMhh8iM7o4G9uaJfqle7cDXRu6GGlUcQPEhsmfAQaoqTvly6UvQzZE8T/K77BKb5EsuP5r/T2JQnqU=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr13789332oih.170.1568636487830; 
 Mon, 16 Sep 2019 05:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190913154952.27724-1-peter.maydell@linaro.org>
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2019 13:21:16 +0100
Message-ID: <CAFEAcA-H7v57szWuaY+tPKy5A6ma_os9JWewM2ZVySFM85wFJw@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: Re: [Qemu-devel] [PULL 00/12] target-arm queue
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

On Fri, 13 Sep 2019 at 16:49, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> target-arm queue: mostly aspeed changes from C=C3=A9dric.
>
> thanks
> -- PMM
>
> The following changes since commit 85182c96de61f0b600bbe834d5a23e713162e8=
92:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2019=
0912a' into staging (2019-09-13 14:37:48 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-ar=
m-20190913
>
> for you to fetch changes up to 27a296fce9821e3608d537756cffa6e43a46df3b:
>
>   qemu-ga: Convert invocation documentation to rST (2019-09-13 16:05:01 +=
0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * aspeed: add a GPIO controller to the SoC
>  * aspeed: Various refactorings
>  * aspeed: Improve DMA controller modelling
>  * atomic_template: fix indentation in GEN_ATOMIC_HELPER
>  * qemu-ga: Convert invocation documentation to rST
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

