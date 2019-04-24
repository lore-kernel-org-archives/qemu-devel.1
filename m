Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBF0C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B353821773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5M4JmqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B353821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJGqG-0005U2-Pp
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 08:17:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJGoP-00045x-8q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJGoN-0007IK-6w
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:41 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:34628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hJGoN-0007H5-0t
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:39 -0400
Received: by mail-oi1-x229.google.com with SMTP id v10so14074961oib.1
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=m5O6OflBd4ICJEU4u3P7LhmxxUSuQdQ2qEoI3X1Sebg=;
	b=r5M4JmqMkXwA0hDLEKEKHLQp4Znfn46nHZ7UDgRc7TDVOwFjshnMyW/kxB/2Vdo2Ci
	9yk7/6bElIWmBH018mLXnJUv8msoehJ+yNXuU9EJj5TmMPZyg1JQh0Es39tm2Avv2cxn
	iuqYB5/uxwPxTvCPwBhq8DE3NDOb4qgp3gjWBNplVjPmBuoXL72qRVsIvwDTugup2M34
	uE1PHjeGIA2Dq0XE0I5OU0k+EDuQabGt3yjms2O4SYuvXxiVhp3Vw18AsRpzD2HlSLMQ
	b0K7Xut2V+cIUYF4xEi1rQpwzC27hLKzcsDsXeWwrjDOo3OOBCJq76efkawyARR1GF2L
	VbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=m5O6OflBd4ICJEU4u3P7LhmxxUSuQdQ2qEoI3X1Sebg=;
	b=NbaESfUJfjfZK40DtEoPgnaakxCDfKG8kiFJxckr1NXb9VqaS7wy36ay1FqhdFFXnL
	Mf8ASRltToCllRvQa+N5IlF6y/1VTXtGD+GU0YrAVPYia1dwdw3blEzT0Kec1D5l9Ebc
	salm5ThJQUg4z+sqDjmgGYIC8+BCK/csb2wAUKmGikuT6EGghBKBTw9hoAau47CoQBUB
	Fs9UvIzWbOpHZ2KCVa83Jo08mRM5E0iU9e2vUBWUNDw2aI/SAvxe9uQN1SPoWL1mEsYJ
	70C2/KwTDLdoSN1usmS6dXOv4/4Nstl0GZaKh9JirhiDpmwpBOTrBuX7vjstbf2foMMw
	DHdg==
X-Gm-Message-State: APjAAAULFdvw7zZMQwq1Nk4ttkx23ew0yHL0zi0RUTshqfrQEZuVKaKT
	ZaibCBHMIShhr+WI8RG22Hwm7wTK10J20WJ65zWF+A==
X-Google-Smtp-Source: APXvYqz5roRXr3GUQWAxKvKDMbTWZlpn82MrRjymvqNahGQ0pv4w9bS42HVrKbRROA6YexkUg2Tbr70mCQYlPZAovuA=
X-Received: by 2002:aca:e84c:: with SMTP id f73mr5268061oih.163.1556108137456; 
	Wed, 24 Apr 2019 05:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190418205135.6686-1-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Apr 2019 13:15:26 +0100
Message-ID:
 <CAFEAcA8SPuiUHEcXHBfTigo79TRp6Qr6QHnXN3SY2odUr=0HvQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL for-4.1 00/36] Error reporting & monitor
 patches for 2019-04-18
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424121526.GJvjpmcnNOXTEQm2bOKm0UeFL7oya9YLoAWeCR0RMJo@z>

On Thu, 18 Apr 2019 at 21:53, Markus Armbruster <armbru@redhat.com> wrote:
>
> Early pull request because I'll be on vacation when 4.1 opens.  Hope
> that's okay.
>
> The following changes since commit eeba63fc7fface36f438bcbc0d3b02e7dcb59983:
>
>   Update version for v4.0.0-rc4 release (2019-04-16 21:53:00 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-monitor-2019-04-18
>
> for you to fetch changes up to ede9a8a656c992deecce45f8175985dd81cc6be9:
>
>   include: Move fprintf_function to disas/ (2019-04-18 22:18:59 +0200)
>
> ----------------------------------------------------------------
> Error reporting & monitor patches for 2019-04-18
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

