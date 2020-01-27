Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A737C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 20:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF222467B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 20:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eM1MRGe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF222467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwAfx-0003nT-D1
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 15:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iwAfB-0003Or-Cj
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iwAfA-0001mo-7p
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:07:13 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iwAfA-0001k4-0Z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:07:12 -0500
Received: by mail-wr1-x444.google.com with SMTP id j42so13031975wrj.12
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OZDr/PwKY2vwqw/QN704nc7dMZn1lt3s749Q6x+ZlDU=;
 b=eM1MRGe4bT6eVZxMHt4Yu8I/IisPSjcrJSCbjxGVw7SjakRLR2zF/3V4JTdQ/465RT
 b97dDW3NYEsNM3jnGED6yPz+2v75iqu5L66yWw0YiJe8l5S6Iv+Bf5gWbiYkESg7d7fk
 TT0hPnPEBNn2J+CHPFnyBs8mLAIiUgOxDV4Xp4RjQMX2UoGXElN5fvBU/LLbHJfxoqKB
 +O6BqlLGTporHp5nFStQng153ktigldp/oLg5h0QbMIT50WjQgIXUH5DrVLRQBGNyuWk
 c+599xPPouKeclfLJ6MSB7FK811wv3IbXVUhefTfJSv7on2aRHTXcXrT1j4KaFXTK2eF
 9a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OZDr/PwKY2vwqw/QN704nc7dMZn1lt3s749Q6x+ZlDU=;
 b=chZ+fAgQE4PHv0l9YM4it6NRaBXTGl26dnekYXVU5Yu03FmqlNW1YmaFz2Txz/ccGW
 0PiM9HIhnVdE96NxXytSrqPevN08h8YZOfWRvyHutW7pUZP5GirGpCmG2wI13iFnsVVJ
 Us8+5YIUtaGOjF4yr0k4v/KhatQbyeNQdUVmgwpaQYRcW5W9dZhZKECsOW4nFKwLeBFf
 DL8vOoDmUkO2qFjvWpT7fE7xEFlWMqyO6iHlc/nyHzeiCcMhVHVDdDan+IMrdJQtPyR1
 NWp+LenWsPk9ziBCi0Fpn4ns/I4/qeAwz/aN03L/q2BDrtGHyGuFsUHk1bE9EuHns969
 ffxA==
X-Gm-Message-State: APjAAAXNUMKspqBSBQTpZKmgMQkRQNyAnE0khJ12maRuNRHORwzz6eGw
 zthQ/y4GdJJqxiBNyFbZ+H8sTA==
X-Google-Smtp-Source: APXvYqxViDVlnJGJyhc4l1dkcTC0O7b3Bh5DpBURCrEX8+0vISruespiILW73zqu+Iz3BSA65OuNiA==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr23080778wrm.290.1580155629357; 
 Mon, 27 Jan 2020 12:07:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s16sm22802620wrn.78.2020.01.27.12.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 12:07:07 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DFF9D1FF87;
 Mon, 27 Jan 2020 20:07:06 +0000 (GMT)
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-8-robert.foley@linaro.org> <87imkxeyew.fsf@linaro.org>
 <CAEyhzFtRV_4oss4gxYJi5ojGrXvNZExXfM+Ae-idLqidtcPpcQ@mail.gmail.com>
 <20200127172716.xvfkyhqznjlxefgn@kamzik.brq.redhat.com>
 <CAEyhzFs9-b4QzemPGY9+3KABV_maq7iCQ1u7m-HKcHWjTN3Cug@mail.gmail.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 7/8] tests/vm: Added a new script for ubuntu.aarch64.
In-reply-to: <CAEyhzFs9-b4QzemPGY9+3KABV_maq7iCQ1u7m-HKcHWjTN3Cug@mail.gmail.com>
Date: Mon, 27 Jan 2020 20:07:06 +0000
Message-ID: <87d0b4fytx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 Andrew Jones <drjones@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Hi Drew,
>
> On Mon, 27 Jan 2020 at 12:27, Andrew Jones <drjones@redhat.com> wrote:
>
>> >
>> > I suppose we could check the version of QEMU and use the above
>> > defaults only for earlier versions of QEMU.
>> > This is something we will probably move to aarch64vm.py since it is co=
mmon.
>>
>> What versions of QEMU do these tests *have* to support? Because we could
>> just skip the tests for QEMU that doesn't support cpu=3Dmax,gic-version=
=3Dmax.
>> 'max' is indeed the nicest selection for using the same command line on
>> KVM (gicv2 and gicv3 hosts) and TCG.
>
> I believe these test scripts which build/launch the VM have to support
> the older version of QEMU since
> this is the version of QEMU currently used when these VMs are
> launched.  I don't know the history on
> this, but it seems intentional that we use one older/different version
> of QEMU to launch the VM,

Well we defer to the system QEMU as it should be stable. It can be
overridden with the QEMU environment variable which worked well enough
when we only had VMs of one architecture. Perhaps we needs a new way to
say "use the appropriate QEMU from this build"?

> while we test the 'current' build of QEMU inside the VM.
> It also seems like a 'nice to have' to automatically support the
> latest version where we could
> use max as you pointed out.
>
> Thanks & Regards,
> -Rob


--
Alex Benn=C3=A9e

