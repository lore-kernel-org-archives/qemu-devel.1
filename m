Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC23C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7396A2064A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xstoGZSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7396A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htYHN-0003Ws-QE
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 10:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32870)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htYGw-0002wf-Bk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htYGv-0002nj-9u
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:11:06 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:39609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htYGv-0002nN-3g
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:11:05 -0400
Received: by mail-ot1-x32e.google.com with SMTP id r21so72248238otq.6
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VMwKg6cKsBo+BU00rfS0YKkciqoBntqCNaO5DSIAG0E=;
 b=xstoGZSieXWmjg5Q+NhWSJYcOjhGZtDgtUqabNUgDBNF+DizYrBCy+ce5nGJgFwNUA
 yc2xDVZD+0LwKSrIcccMtaQppE4KQYvuIff/eNnUeCoLrt6yogxzr+6TJ8P78pgDw816
 Wq6deVa0nB7zw/siyKLT7X0Zt1d1H4XldjyErZtACn3YQHSmAyU2FQ0SZfs6OK8O57v1
 CDC5C9bmh+3czc08zvFRpnK4myi69/UwWgFpzEGzh1/Y7W56JDT4iUQP69lVf/9Cd+Or
 QLyNsai9Hw88UifH/VVE192ylTeCiRK6Pm6zoa0DnvT/Lj466UPhNFijS+hX417jf1hb
 7x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VMwKg6cKsBo+BU00rfS0YKkciqoBntqCNaO5DSIAG0E=;
 b=ZjQSABzaebHDNnZYmsYP0q0kROx5p0pi4l4BI3rqXRj+ojq9oarDMLK3sMrgY1HaNz
 UW3PX7UdsFIkGSWS5CM7saGSJ+++16vVm7dxH3pTHzxEzs/Qo+ucpttK7nHB4sUWWZ2E
 JWZqrypCZzf1gP2YpnR0ITw+obRkeVqBy1xqKRvzm06JN2XguGN7M3Z7nMo2Wm6RfnIO
 JwUSdItsRmC8qSfjlzRtN/sULbdaGdJOgI2pmSCTDN6+xdgS7vZit9/inUlKbEfJ8m7d
 4adfO7aBUbqghUjabcDH69QKG0u1EHkZS+ChCtdtVGWfzkfsbtv2nrM4TrthB9/YNbL9
 2x7A==
X-Gm-Message-State: APjAAAWCrkFMVJZnhZpaRVgkMyvUwmgqydID9HhXOy4qrGwm8xSRR+Ec
 MDZ6Lmu+q3Y5QOaU+DaEPti/VSLI9h6h8HF2rv0D63a6
X-Google-Smtp-Source: APXvYqyf8RZcaGw0ksUlnIh1KnQ5o4oFwMl8RC2jwTcQjyq6K6kXGVMovvT8ko87E6VniFFTM36Pw8CTS5CWK7xmtjg=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr72062333otn.135.1564755064251; 
 Fri, 02 Aug 2019 07:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190802111833.32187-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190802111833.32187-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2019 15:10:53 +0100
Message-ID: <CAFEAcA8RxD=+BJhiRg9c6QnjC7+UU2ie2c574yg_y8qbnT9qyw@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 0/1] Slirp cve 2019 14378 patches
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

On Fri, 2 Aug 2019 at 12:18, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 3bd6cbbb181b6ae60a1d1f33ccd325b45f71aa=
2a:
>
>   Update version for v4.1.0-rc3 release (2019-07-30 22:02:05 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/slirp-CVE-2019-14378-pull-requ=
est
>
> for you to fetch changes up to e1a4a24d262ba5ac74ea1795adb3ab1cd574c7fb:
>
>   slirp: update with CVE-2019-14378 fix (2019-08-02 15:14:56 +0400)
>
> ----------------------------------------------------------------
> Slirp CVE-2019-14378 pull request
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   slirp: update with CVE-2019-14378 fix
>
>  slirp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

