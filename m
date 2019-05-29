Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC5AC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D7A20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Znbai7sN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D7A20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50891 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVvLi-0001Bh-5o
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:58:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVvKv-0000sX-3b
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVvKt-0004xz-Vm
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:57:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVvKt-0004xY-O6
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:57:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id x4so1273890wrt.6
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=eY6SFgv/z6eluNAah15F++QHeeqx+LSdBdJ9eXtyln0=;
	b=Znbai7sNWPwUSlA4GlkEoq1J6XI1+7q7BrktwUf1JO6TB7+PWIS2VFIAeBjk2TiJQi
	/1Ojt8+cpTgJ4rUG2U+MpE0kaOfrVsgWZPz43S6psqPm4B6GCA4B5Sho0gsG/yTw6/Fy
	Sxgw727BIuu8OibPNnu1wz4LPmCcvGoFsN3u953GbCiuoYUjrDUnSxIx2ifeoqJYHCO+
	Ca1KP9x3HqQ0K8THveu4e83RYWTdMGHunw+5RX3DNDPsjCdb/Z3h95rP6HP8IWwgRVoV
	23OvE5gewfjCPGKX23YHoVpBUacw92f/1P0JYGKZl8R3q9/SqhEZDZJBC3HV4vbIig4A
	/ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=eY6SFgv/z6eluNAah15F++QHeeqx+LSdBdJ9eXtyln0=;
	b=gr7Hn7ZR3CPqjaDS0qEwpVI1ap6cX7SKg3vnbHs9kTG885dhoXqd7J01NG+UOPy66e
	blqO7dF6oI3/JW2FiYFUkI++8yJDp8PYs7tQM4/kLoaOSW0b4ogZQ8+p2MPRxdDqrDw8
	sPnOvcbo8Aw0/RJrzNx46jfZefFIGbGscQ6Z9W6LaocMD8io7zsp+NiyR54s+yZLqTGw
	xVqmXdRlB1EYK2r18sblEG7SBgBGHiNnMfSqiFYagwERGDhOO8V6PZpM5dxW3cJtgyfX
	P8DzJItQdlYxUnHHd+nttSvn9X44VYJ0kPKDMIm5pXkVe7pf94jsiDOU+XX5TVM4louE
	+TDQ==
X-Gm-Message-State: APjAAAU6QsPm1FLHj7UhwpuW+3xmyhXZU3g0vSqXuCWLEqInlJgEop7L
	1vFjNYNS9zaTxwUaZY6b6thdjw==
X-Google-Smtp-Source: APXvYqybAwEOKY4AwUiCN2pXH6trAHrfELlKeOcVdVK2+dKqBupR+vS0rLGf29VzzoUgfDBPPwDc+g==
X-Received: by 2002:adf:c98f:: with SMTP id f15mr32906674wrh.279.1559123850402;
	Wed, 29 May 2019 02:57:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	p13sm5376992wmb.23.2019.05.29.02.57.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 02:57:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 722D91FF87;
	Wed, 29 May 2019 10:57:28 +0100 (BST)
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190529050950.6s26nirxm7i3ceqz@sirius.home.kraxel.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190529050950.6s26nirxm7i3ceqz@sirius.home.kraxel.org>
Date: Wed, 29 May 2019 10:57:28 +0100
Message-ID: <871s0hshvb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console
 autoinstall, misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> On Mon, May 20, 2019 at 02:47:02PM +0200, Gerd Hoffmann wrote:
>> This patch series changes the way virtual machines for test builds are
>> managed.  They are created locally on the developer machine now.  The
>> installer is booted on the serial console and the scripts walks through
>> the dialogs to install and configure the guest.
>>
>> That takes the download.patchew.org server out of the loop and makes it
>> alot easier to tweak the guest images (adding build dependencies for
>> example).
>>
>> The install scripts take care to apply host proxy settings (from *_proxy
>> environment variables) to the guest, so any package downloads will be
>> routed through the proxy and can be cached that way.  This also makes
>> them work behind strict firewalls.
>>
>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>> was struggling with.  See commit messages of individual patches for
>> details.
>
> Ping.  Alex?  Fam?  Are you going to pick this up?  Or should I send a
> pull request?

I'm just looking at it now. It should be in the next testing/next. I'm
just checking to see if there is any crossover with:

  Subject: [PATCH 0/5] tests/vm: Python 3, improve image caching, and misc
  Date: Fri, 29 Mar 2019 17:07:59 -0400
  Message-Id: <20190329210804.22121-1-wainersm@redhat.com>

--
Alex Benn=C3=A9e

