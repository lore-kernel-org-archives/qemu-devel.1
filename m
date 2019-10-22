Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51648CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2061220684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrWXOjDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2061220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58667 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMv2L-0003DG-Uz
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMuWX-0005Wz-50
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMuWV-0000SO-NI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:48:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMuWV-0000Rd-Gz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:48:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id r1so8363586wrs.9
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AMzrIGbN2EkcY9+UM+dIQ4bBwlEUmZgf8B47GERYb4Y=;
 b=YrWXOjDSJd9U65DRacJuQvkPYFT3xBdWKWnIz+L8x4UNLyMCjleca6dFivlPe0HEPW
 yU6QKpnsSA+s/3PYNIVtBZ2GoSQa8ZEXNyJlH9NKfOCj5nlCypknttnikpjQmJvMq5Is
 5JugZT5c9kYUlo3LWdgjToBH74+ZL5H5hZyDU/iRa0nKVjYdqgK3dhpO3t8q4icUfaAu
 275FVLVrgxwuJUHoWMUSE99TsIhcLVtlmztEcrC2H+TwpdUGkBU790vSUenT6GLykzKR
 f0+PxXf8G86Wd8MJV3KoVLibC3xZQwbD84QJjrapGd6MXcnxX1PjbiKc8vN/Qce7Q1Tm
 HF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AMzrIGbN2EkcY9+UM+dIQ4bBwlEUmZgf8B47GERYb4Y=;
 b=QRpaOXcgh8Tp/3RN4gfLB4sWc+B9VtPzZyLvAjlk6LRfZXndD6hwyqvcZtWmx+tKwP
 yszKsTuc0rPNU4ZZNgMJwhVkD6UiFKH3h4GcYNt1yMMX8i2qt3f/8Ed9k2kA+awCBCPI
 +UuTZhX/xsF53kutVypIpIwCB6t5eNg455vXx/QbauInIchytS+/uFBkBhkiXEUOZ9Kf
 x+SZP7IJNde4J+4T5Rm4lLA584Nls/EZeZd4Lfms6W6kkaorTXlboGnN8ZYU8JsMTmVP
 RmTtW+Em9qSYDKVQKRcu1u4hTybboaID/DI2Xto4Yn+SkLmd4KVGun/urBu1BWZwAqRA
 jAzg==
X-Gm-Message-State: APjAAAXO1DPJu53V5+GAHVjI1c3r6VT7XewTUqd6pYhn2jeav75Z0EnD
 9Kfl6AxtHQfcvcvfSemqNLMIDg==
X-Google-Smtp-Source: APXvYqyW8CQ1WvEsDJOhqkDuPZfP8JUA0oovH4CM4fbaAc1xQ2AVJelXGGkK9KqUmYWOA5tBK9cYIw==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr3833467wrq.385.1571752109744; 
 Tue, 22 Oct 2019 06:48:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r3sm32235090wre.29.2019.10.22.06.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:48:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6574F1FF87;
 Tue, 22 Oct 2019 14:48:28 +0100 (BST)
References: <20191022072135.11188-1-thuth@redhat.com>
 <87a79sx6uc.fsf@linaro.org>
 <123b2e94-3f43-1a8e-2420-12ae09483e2f@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 0/6] Enable more iotests during "make check-block"
In-reply-to: <123b2e94-3f43-1a8e-2420-12ae09483e2f@redhat.com>
Date: Tue, 22 Oct 2019 14:48:28 +0100
Message-ID: <877e4wx55f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Reitz <mreitz@redhat.com> writes:

> On 22.10.19 15:11, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> As discussed here:
>>>
>>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00697.html
>>>
>>> and here:
>>>
>>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01388.html
>>
>> Queued to testing/next, thanks.
>
> It should be noted that this series depends on my SOCK_DIR series (which
> I have in my block branch), or the newly added tests are likely to fail
> in the CI environment.

Ahh I misread....
<snip>

>>> it would be good to have some more valuable iotests enabled in the
>>> "auto" group to get better iotest coverage during "make check".
>>>
>>> And once Max' "iotests: Add and use $SOCK_DIR" patch series has been
>>> merged, we can indeed enable these Python-based tests, too.

I though these weren't enabled in this series. Do I need to drop all the
patches?

--
Alex Benn=C3=A9e

