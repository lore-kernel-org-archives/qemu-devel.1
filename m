Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26426C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E392087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7+rJZ63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E392087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9W5-00018B-1F
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:52:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9Uv-0000eF-U1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9Uv-00017p-43
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:51:21 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:34214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9Uu-00017O-SB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:51:21 -0400
Received: by mail-ot1-x32f.google.com with SMTP id n15so3191211ota.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=SKiMQmc+Kubdp9R00/VmSeRI0Okt7QtharzHi3LB5uQ=;
	b=h7+rJZ63NFIogzbHMrXeGG6/TK5g4dsHkjAZ9iRrigGsssTUYc4lBvYDXszx6UYR/3
	EMWdhtN8TC8jDymDgBTN4sZBUzcAJabD370Q1z1ANDRrNIvwDqo5qFXROopHPVDBYrQW
	6ItYvDTrprZd1GKiV86tXeDA0tF8p/eyZfHjjAa8Puxodror28G22SIE8TfOH17jClCk
	EZjaKrHjycaID8m1lkw+jFS0IZxjjQ1zsKSi0bCI1uBdWDSpX2nUSooA4MPE8hFwv/1u
	6BGDHM3GZi8LL/so/4uq/CLdKuEANipLUmcmpuyPSXNBbGgb7kq3IL11wQjezzGzpcNL
	FF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=SKiMQmc+Kubdp9R00/VmSeRI0Okt7QtharzHi3LB5uQ=;
	b=uhLSyoJxk0aLuldtPCsW3wW6UK9fi+bi5Z2ZU0NAcRGY+ixzTnQuj5GYnMhpD5oX64
	kSoXVIRBbtwta38qYNN288pAleNangfRk2mNvD2kYrqAJ/rm7YQct62AxpDDSqk9PLvk
	pDvihhcmCjhDhAjzOoecUgHOShjFauOP3aOWO6TUAQIBgqZsALL5MVGXxF30ZsOJvuH4
	XDTQjgV+LKOPR5ePMENRc/ixEaQOzTuOZ7N65ySFj0kWe68V+kvnqBCZx/26nKdDDmFP
	TgGekKVieKkJBBqkAeL0WLTmyyQwYhtAUxZoCTacsD6ednN+84qmWAnEZLZVIKdy5TFg
	Qbnw==
X-Gm-Message-State: APjAAAWDM81yzNP1ZLqRA8o3wF4jcsAMk5KWuF194DFlnUS5U7wEjrC+
	f5AbASpD6iBGNuzXQafIDJLkzVrNphpPtzNpKNEeYw==
X-Google-Smtp-Source: APXvYqxC4HkEujC0JdrOgzTzy633x1bSZxyKqkLg37eOThW8MBYKJncghTeqeLBBv6ScEWLL+9tMFbT0RU1N1H4miDo=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr1874471otk.316.1556556679948; 
	Mon, 29 Apr 2019 09:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190412165416.7977-1-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:51:08 +0100
Message-ID:
 <CAFEAcA90Pv=zEqaonGV=c022T=CYMo11nkqNwBnGgocESnBNmA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 00/12] hw: Remove
 "hw/devices.h"
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
Cc: Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429165108.DJHNbtaRDWZcy8n8FjYYjQXxrTT_S25jWlAcChFLvyA@z>

On Fri, 12 Apr 2019 at 17:55, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi,
>
> As his first comment describes itself, the "hw/devices.h" contains
> declarations for "Devices that have nowhere better to go."
> This series remove it, creating new headers for devices covered there.
> MAINTAINERS is updated.
> I also included 2 cleanups while working on this, in "qemu/typedefs.h"
> and "hw/net/ne2000-isa.h" header guard.
>
> v3:
> - rebased
> - added 2 patches suggested by Markus
> - addressed Markus review comments
> - added Markus's R-b

Since these are almost all arm devices I'll take this via the
target-arm tree (I'm going to make a pullreq later today).

thanks
-- PMM

