Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A50C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057B420833
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+t4iD+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057B420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDpPe-0005gH-8c
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 07:59:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpOr-0005Np-SL
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpOq-000590-Qz
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:58:49 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:39561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDpOq-00058c-JP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:58:48 -0400
Received: by mail-ot1-x331.google.com with SMTP id f10so9136219otb.6
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=xMtGn7UgrpO4HS2mgOd7t18tw9u3U55fON04CqwR2aU=;
	b=W+t4iD+TL64lmmHo/RHLQu0cBxiAvwwTh1T06kaBklF8mEkcC36CtPAbCkL7FH80Oy
	4yNucuuhfjo6ay/ruoGo9LP0rkQqdmaQRAfJUV7dkcUJB4ikROzl1mFhowxFxv9g6dR4
	N2QPOpG4plKZWFSUsfa87LxiouDj4cbpnbJx3IB79ivNdEy4hEGn00NlBMSqwQRWz0Ho
	UPl0ZN9K4WobbTPGnwpNVek3DT2LbGBiHUZxmaFk7L55l4cOqS2IH060mt5ycz09EJHC
	wa82SjR8BVSIQD9QS7J8V7WUurSLc7d8driie2iH8Xnzu5+EICpnD8AS8CzgiiEeDEyn
	URxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=xMtGn7UgrpO4HS2mgOd7t18tw9u3U55fON04CqwR2aU=;
	b=f6HWL8zmumAJjTMzcVBS6dM/JLid/0CyebTNeGqBeVhmvCzmOTNL4X58VcbizGCuEc
	IQvx6wW90xeTGKqDY+87Bws7wBvj1QPBau0punJej4HhnF0b5pEgOtjThA5PUV8JA7Gt
	1b3GAiwFAweXIhOl0RgQcb5glXoPPos30w6I++IGnSqj97/Zi+gZOXN8rocyDYg1rBMr
	jfcRlgmiy0YlWXEKJH+NRn5gR95+UYXn+PHQ7lMkHEcz+Yz1YtixGy/2xfwb20jkVyJC
	9aUisLETxR0tP1Gu9v9CmHv6F0ZTZHMmsSt+QOsrxjAnEd2Xyd0VsNfwd830jrsNT+y+
	K40Q==
X-Gm-Message-State: APjAAAXrSsG0Gpb4j0Stc2h8TMric+DHy6fu5dx9kuDevhDoRqqtDf03
	SvYuIGL9YVU5hSOdoFRi4UmVTv+e+Fro849dzBCGXA==
X-Google-Smtp-Source: APXvYqxEKvx2UIdvJPYFN7jYU4fVvvtnkq0tTQG0RUkiFhDvs8NQlm9EqZ2keDSOmQ7wc3my116CbPNOUvQqeVb66Hs=
X-Received: by 2002:a05:6830:164a:: with SMTP id
	h10mr24181634otr.323.1554811127755; 
	Tue, 09 Apr 2019 04:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190408193711.32680-1-laurent@vivier.eu>
In-Reply-To: <20190408193711.32680-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 12:58:36 +0100
Message-ID:
 <CAFEAcA9Cc3i83kqjm0Yj9xZyRy0SMDpg7yvcNeTet4LJGB82WQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [PULL 0/2] Linux user for 4.0 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409115836.SArwoIs54N9qV9OYJSGUHGp6gpwGn5kWqCGgyk0wuxc@z>

On Mon, 8 Apr 2019 at 20:38, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit f55a585d1037e5de6088f25e75443c2776786e=
29:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-04-07 14:54:55 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request
>
> for you to fetch changes up to 71ba74f67eaca21b0cc9d96f534ad3b9a7161400:
>
>   linux-user: rename gettid() to sys_gettid() to avoid clash with glibc (=
2019-04-08 17:27:13 +0200)
>
> ----------------------------------------------------------------
> fix gettid() clash with new glibc
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (2):
>   linux-user: assume __NR_gettid always exists
>   linux-user: rename gettid() to sys_gettid() to avoid clash with glibc
>
>  linux-user/syscall.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

