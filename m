Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD26C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582E12075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvHymc9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582E12075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40367 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMXjn-0003Pz-Mv
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 08:56:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXiB-0001Ov-HG
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXiA-0002rP-Gp
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:47 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:35309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMXiA-0002r8-AD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:46 -0400
Received: by mail-oi1-x231.google.com with SMTP id w197so4342466oia.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=850eNT9xES4ZiYhtXNtnwHmh/iOFhHVfhZDEtmPQGVE=;
	b=UvHymc9WqcglLx+yeDtjDiQ23iAD45GBqOrqiZ1/gW1jpcBZbJKIW8quSk4TXYxUtk
	G3loqTP/R3cFE0SChT8s6OMZdmw8WI4UteLHN89Gmf7Rpz91Be969Um/71CSVMppjLkl
	66YqXDtu3PYP2uaIlhbPO04YUIKPjSmOMv0OX772a4RsO3CD7X+sQ7EEjhQ/+Pa4Ts42
	CGUIxbVVct6FySHKdy34ip9Wq3KVuzeI84QfqznAkYEsIIMWNm4cZJRSI2LYE2OG7a71
	XbAfrSHn5EjcdyGTlrF6xDrjHmG4CV9km5UzTuHdXaMRQiDiRVXd52EVs4UlGvkKEiJH
	V0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=850eNT9xES4ZiYhtXNtnwHmh/iOFhHVfhZDEtmPQGVE=;
	b=g1eSvn80WqvaA6ItKTbLHximBrwCeJXX6jxngn823zxszSeJ8GFh6i8mjjb92lzkDI
	KceT7RX6/7WQFfE2mN0yaCx59ZjmqgDG4ZYR0rU9v7zzxM1kGnrV5AEOCWCojfmOPUu4
	zH5nO3erVmnP3nq31zE/XnHWJzjUU4EHemsxxwhKSaoAW+oqdtrTlyl2wlXHFtc590Sq
	6wr/tH5u+tCSUElU7YSZZHT2pjbWmkae/SwWkKfBIZDfypL4/7gG99puh31N15v3OExy
	hSyrw29Z33to7gX/l4LlY5LOj35uljEEI9AQCb9MvsS33pCdTmby2RFKIGww6PCXfcDr
	+gWw==
X-Gm-Message-State: APjAAAVuixfSy1mRxyJIJxzhz69LTkhJ/UWlR8D6wQtlDQnRz0PQshwD
	P4OLkD+Nvu3CCy6A7Ae9fPyV839NSMfDbc+uDz7NBlqRUQ8=
X-Google-Smtp-Source: APXvYqxj+wyHsc2bSNFBE34gyapC0hSZEbGUifo2APUSw2LP3FpyxzUkPEuG5N/wdotetN2+9J9phNGUF4tdSuSHXEs=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr5417881oie.48.1556888085656; 
	Fri, 03 May 2019 05:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 13:54:34 +0100
Message-ID:
 <CAFEAcA-eVOZhXj+OLB+VvxXZTniny_sMCFaeWsv+2uEErM-=zA@mail.gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::231
Subject: Re: [Qemu-devel] [PULL 0/2] slirp: move slirp as git submodule
 project
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503125434.fJj-19FjRIx6fr6M5y0jQtVwOtg41eiUiPcey4XOQJU@z>

On Thu, 2 May 2019 at 23:30, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41=
df:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-05-02 12:04:51 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 7c57bdd82026ba03f3158bbcd841afde7c2dc43a:
>
>   build-sys: move slirp as git submodule project (2019-05-03 00:15:37 +02=
00)
>
> ----------------------------------------------------------------
> slirp: move slirp as git submodule project
>
> Marc-Andr=C3=A9 Lureau (2):
>   build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
>   build-sys: move slirp as git submodule project
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (2):
>       build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
>       build-sys: move slirp as git submodule project
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

