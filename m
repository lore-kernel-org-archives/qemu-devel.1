Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF9AC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28338218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQ1IVot3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28338218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7LNV-0002s2-BU
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7LMr-0002Qy-31
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7LMo-000895-RJ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:14:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7LMm-000868-UA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:14:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id w13so14287312wru.7
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=134oQQbaTBKG92V+BPny4d27kS54NfmsW4R+mSsQgR0=;
 b=cQ1IVot3YRFhafqBP4p2lFCPK4I6UGpvIcfTx0V8pcXY4SO7fG34LkpUd400Sl1xXh
 lIdiUJUVauXuBDRm1spB24iGIgchzZFLlN7N/07dqWqDpxKhdWoKyymLnFttVD/VLPi/
 Ww+f1aiTRG3dCKBUpsNTZMnGugRHjwylG0Ko6f1RVPBmuurbhp+hmx3zuvBBXkIp4SCg
 NdBJx9uObn4YdoGLclGCmnzTclZC59nIaPdiMIkEAaIfdFPqDhaJ1Wxn0rD35b5EBcPJ
 3giFFEkerkf4VaIRsGbp31jZn7wIwK4w8PcH95Fm/StW91GCf5m7lT0GThIWUxErrHCm
 ICgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=134oQQbaTBKG92V+BPny4d27kS54NfmsW4R+mSsQgR0=;
 b=rq9KdO6zkQYkkvKA6GxsXUIP4RXOAoDqUvx4qUvZvF/mF5ac9Jez1MQKGAV2BwEchB
 3TOSbnabXO8qxkchS20eeMRP3irwJs5zJJwBrKoHQIxsGV/CcSJD4dBqRDdpAh2nTNkW
 lftwoACYBQ0NIgNQB0203CBo7YFQBgVgOdWt0iA1p1HxLxnrAAiMt9NZS6zLH3/6uSSX
 j5HHpvQCiVOMosF6RYbBbZxxBk60DfJhT47oUN+VxVaw46QJmEnfSQg+ZxVZ/+T8sqyG
 bIso+JfEm4v/7hygc0SiuVPRR7xpPqBc4GLCEH73lhdmu+FCmIaVI/Ne+GVFfzFJu9xS
 a7LQ==
X-Gm-Message-State: APjAAAUsUlba1UybNWG5CgLhentBcHLMCAzaeMEe4h4gyhv3r4ZSUk+c
 fWPJguWYXRE7SeFs8ZRx8Jj5MQ==
X-Google-Smtp-Source: APXvYqwR/MIXk7emV5KlCy2gE+8FBACC877O3MQvVibeeCbdbXKSBVXijA4FJb08DUU8gvpw8Y300A==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr18491173wrs.296.1568042046162; 
 Mon, 09 Sep 2019 08:14:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z21sm13365270wmf.30.2019.09.09.08.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 08:14:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DFB431FF87;
 Mon,  9 Sep 2019 16:14:04 +0100 (BST)
References: <20190829165036.9773-1-berrange@redhat.com>
 <20190829165036.9773-2-berrange@redhat.com>
 <15ffac7c-e7f2-17e4-f4e5-e54500ae3ecb@redhat.com>
 <20190909131510.GG24509@redhat.com>
 <429ee8e3-e6ce-5a37-f4fe-a8408b1cc7b9@redhat.com>
 <4babad28-f2d2-40d1-fc5b-6eaac479676a@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <4babad28-f2d2-40d1-fc5b-6eaac479676a@redhat.com>
Date: Mon, 09 Sep 2019 16:14:04 +0100
Message-ID: <87pnk91ozn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 1/4] docs: convert README,
 CODING_STYLE and HACKING to RST syntax
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/09/19 15:20, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Doh. If we care about NSIS, we really need to have it being tested by
>>> some part of our CI system, and by pre-merge build tests.
>>
>> I believe Stefan Weil does, since he regularly sends fixes or opens LP
>> bugs during freeze time.
>>
>> We do build nsis/win32 with CI, but for some reason patchew was down.
>>
>> I'm not sure we should duplicate the build on another CI, we should
>> rather setup something to watch patchew and warn us when it goes down.
>
> I'm not sure what happened since I (obviously) was not monitoring
> patchew during my vacation.  However, the recent Python 3 port of
> docker.py bumped the requirement to Python 3.6 to run "make docker"
> tests, and this broke patchew which had an older version.  I have now
> updated the tester.

FWIW testing/next fixes the over eager python3 upgrade (I hadn't
realised how recent encoding was as a check_output keyword). Expect it
in a PR in the next few days.

>
> Paolo


--
Alex Benn=C3=A9e

