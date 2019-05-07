Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BABC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83879205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPOgpa63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83879205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50209 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO3U7-0003u6-OU
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 13:02:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO3TN-0003YU-4A
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO3TM-0004wh-8k
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:01:45 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:38789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hO3TM-0004to-3d
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:01:44 -0400
Received: by mail-ot1-x329.google.com with SMTP id b1so15657761otp.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=RU+OciKc7oqqP0StmbSOCcSNkE7KJSjRgAGt8wBTFBY=;
	b=xPOgpa63jExld0Ncvfzq53GePcDhqmqXDo5u9Sx9wy2RgGMmILeE89bV7I5YTxco8Z
	FpmA+vr8WVLXt4mxlzUZEqAdAMw5KTnBfRTfQyQ3bva7uR+FQyXdGHn/ocqHvUyQ+rGN
	e08fmAh0xcW9tQTFOVVCJDJG5dI7tewZRNG5ZPoQGnGma5czR9GgR2i7Z3UzvRoCRir3
	GLhGb+7BKT7MfIgnqURpwRapSuLDpQ/fkm7jmnZ1i6qlEBULgQ4wJsjag2lJnjBj3EGt
	DW3MfmDIo6EhvyylQ3wOJArBDERriM9VegVAs41+oUty5MS4/64nHJ5I4dxpeapRP3EM
	G2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=RU+OciKc7oqqP0StmbSOCcSNkE7KJSjRgAGt8wBTFBY=;
	b=J5QVlJ4fjD/gi59fzXH+jlGVXOhUIAP06eMWn+FLKZ347/B750+zm/TdNZ0hqtIS96
	FZrbLfyrYQxndcIfMxNXy3ISN7mbxYX0lgAliAoMfEN0gC/k9KPupopaccmeWehg72H9
	nu2BBsVvITQdRNW9gnZw0X0HsQLLUq/Oj3J1PQc03YkOVWVQc6rLSHrpT2EOMlFaGssB
	MKbWShRVwiVraCSik832wy66hm8mtejm+nvpdlBVbRmCdNBZX91DAkiwUFWLC2szMYop
	9XP3Jb72zTiuBx3Lf06mjpuW/aXABVGMR6EwK1uo4Mb5G1UhG5SRnsspPO6ktUWp6kOO
	95aw==
X-Gm-Message-State: APjAAAXitMNeN3S1kjt2PIsYAdkVHb08yRFTO49JIt1sR7EKkAmraGDV
	lwzB2a1KsCPmV5u+4/u8gBUsr17kfVZiHJIVzj1T5A==
X-Google-Smtp-Source: APXvYqyBKLf6Y2IxIPWPg7U8dsZ1G/qjdaqMPSa1gy2aFZOS/b16iikZff9ouP5QvtYenBK57SRp73kx/FJOOd+RRPs=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr22001897otk.363.1557248503239;
	Tue, 07 May 2019 10:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
	<0da3ec00-9040-f367-7666-a54824f1dcde@redhat.com>
	<20190507141906.GT27205@redhat.com>
In-Reply-To: <20190507141906.GT27205@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2019 18:01:31 +0100
Message-ID: <CAFEAcA9NM8c0bX+D-VFOvO7iOWjcyv1U=F5K5810mHRb-zgDZw@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 May 2019 at 15:19, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> On Tue, May 07, 2019 at 09:11:09AM -0500, Eric Blake wrote:
> > In the meantime, where do we stand on our goal of disabling in-tree bui=
lds?
>
> The view was largely positive when we discussed it. So I think it just
> needs someone to step up with a patch proposal, and at the start of the
> dev cycle is a good time for such a change i guess.

Pitfalls to watch out for include checking whether any of:
 * the tests/vm scripting for the BSDs
 * various travis/etc CI configs
 * etc
are currently using in-tree builds.
Paolo will also need to update his coverity build config.

thanks
-- PMM

