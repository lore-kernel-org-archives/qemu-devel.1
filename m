Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6AEC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14727256AB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWC1laJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14727256AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWHjm-0005fP-9y
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 05:52:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWHiz-0005Oi-2c
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWHiy-0002We-0e
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:51:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWHix-0002Vn-Mj
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:51:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id b18so3722814wrq.12
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Z3biaN7oZCkzlCSjB3tHHfF6NrBBgvnm+opDI+3kb0k=;
	b=LWC1laJmdIQovzZgTBdiJEi/RDsDppW3Q+FptHDY/0ocu7afAKMgbjWFmCB8BOPDVg
	AWl0+PUdoE1wtE87EYG3Pw3cOF6iBnNcylR7LvlvB1hWAYphSsRlDEmiwJpP1H+pu0jg
	JoBTtZXUn+9BZUt7gp0MIxJxaHhhTkHhq49Qw737g1intylyxUvYOmZNbyMy88tqYsNe
	NJDp6e56crIP+JFlqVuBb0zvaG2Stv2okLTC63jx5tdVgb0/T4QPOGepzBSZ4utj1RQ6
	ZoRgdO9Qxha8MEUJLxTYFzO8/i03IxnayT+tOiR/UEqV0idByriYXe7gI0RzZLnAo3Pe
	tZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Z3biaN7oZCkzlCSjB3tHHfF6NrBBgvnm+opDI+3kb0k=;
	b=AJpgVn6ZmQkpI0TWJwkghgEaPwVghAvnsL9u6/hLuIR8XSuWMEAFOX2K/YX4Z/D8lQ
	1NgcoSUt3R/iAtvBjxNbGmzb6Mf8UIjOvOw1pU6IoAotcKIgVGoVHTR2t5lFpTqcNT9y
	gtsJfsPaKu+iDNx4mD3tgSE96Cl3i1iVMwMHCPtKJxDSzCpC152Mi7fQ2jc67ixERsXl
	9xvV1rhKuJg7rjZMBv9cMCF8PZKiITlPRQ/JPRNaEqUwAt1qOczQsWISEig6Mx4HuAWp
	h31AT3WTnJGjmA/M4YjU5J1OJ/Ykrf+1mfxLkORyrDD0zyo8y5eyFSjMXMTdYjdka2sq
	OBGg==
X-Gm-Message-State: APjAAAXGW0PDqGvKAokk3oPsN0KuyMgykbe51te//9uhvXbfRot/DuS6
	AnAU2kFAery1Zvdaec+LOLvumw==
X-Google-Smtp-Source: APXvYqwlPLuDeOsjMlbNKOTk79KPFMIaD1f0E52i/cAdToXAPIcmDhjslSFfDSxMgQO/lp8sF+Lvag==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr2026358wru.151.1559209910311; 
	Thu, 30 May 2019 02:51:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	205sm2474190wmd.43.2019.05.30.02.51.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 30 May 2019 02:51:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id ACF691FF87;
	Thu, 30 May 2019 10:51:48 +0100 (BST)
References: <20190523234011.583-1-marcandre.lureau@redhat.com>
	<20190523234011.583-4-marcandre.lureau@redhat.com>
	<e0cf3112-62f6-aaff-0821-f472297dbb93@redhat.com>
	<CAMxuvay+ZrdjhJg-juU0aTOtcy=cLshC+WGyPBQ6VysXZksa5w@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
In-reply-to: <CAMxuvay+ZrdjhJg-juU0aTOtcy=cLshC+WGyPBQ6VysXZksa5w@mail.gmail.com>
Date: Thu, 30 May 2019 10:51:48 +0100
Message-ID: <875zps5ky3.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 3/4] docker: update fedora to f30
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
Cc: Fam Zheng <fam@euphon.net>,
	=?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Fri, May 24, 2019 at 9:41 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 5/24/19 1:40 AM, Marc-Andr=C3=A9 Lureau wrote:
>> > Released last month.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  tests/docker/dockerfiles/fedora.docker | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/doc=
kerfiles/fedora.docker
>> > index 69d4a7f5d7..1496b68ba1 100644
>> > --- a/tests/docker/dockerfiles/fedora.docker
>> > +++ b/tests/docker/dockerfiles/fedora.docker
>> > @@ -1,4 +1,4 @@
>> > -FROM fedora:29
>> > +FROM fedora:30
>>
>> Hmm this patch is pending for review:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00819.html
>
> Oh I missed that. Maybe we should use "latest" to avoid bumping the
> version every 6 months.
>
> fwiw we have different versions:
>
> tests/docker/dockerfiles/fedora-cris-cross.docker:FROM fedora:latest

I'll fix that

> tests/docker/dockerfiles/fedora-i386-cross.docker:FROM fedora:29

The cross compilers images are different as they generally don't want to
include the "native" libraries. For Debian based ones we do have a base
image that everything builds up from but we haven't bothered for fedora
as we only have a few so far.

> tests/docker/dockerfiles/fedora.docker:FROM fedora:29
>
> In 62559b916 "tests: update Fedora i386 cross image to Fedora 29", Daniel=
 said:
>
>     Using the "latest" tag is not a good idea because this changes what
>     release it points to every 6 months. Together with caching of docker
>     builds this can cause confusion where CI has cached & built with Fedo=
ra
>     N, while a developer tries to reproduce a CI problem with Fedora N + =
1,
>     or vica-verca.
>
> But at the same time, Daniel bumped f28 to f29 in commit 19a9978db1.
>
> It's confusing, do we need some stability or follow the latest?
>
>>
>> >  ENV PACKAGES \
>> >      bc \
>> >      bison \
>> >


--
Alex Benn=C3=A9e

