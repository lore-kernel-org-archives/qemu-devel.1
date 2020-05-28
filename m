Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C4DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6500207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDg3Ke69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6500207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMCs-0004E0-RT
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeMBt-0003Zc-1H
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:19:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeMBr-0007oq-F2
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:19:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id f185so3086132wmf.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rChDjX1koIKuBkiHmvCNose3ExYQuzyWL7z4JzRZkr0=;
 b=IDg3Ke69mZkO7/6ik5WuNEWhabYu/pGFTR0/0P3qEX7MsDP4UJO8Fqvweh2+dNfYRz
 wieYJKj0FAJEZF7N6O/o8vHXOCI6zpmtS0T8KyX4f3e94g49D9TBdQ+BQUBCEKGnPqpS
 AMccbj+6G1pOPnsX/E+TGUArF6Red8yjnOL2stR2t/xKmSmyUDuSjWP0BGvi65/E17sM
 71Nuwgnn+3/JyEGgpv0jhywfYn89Jx9CEPIoYK+yX0tvUAg6z/QLJAksABdMIsY/Jsos
 Q0b6YSRsZ7XBiIO4CfL8bqk4bVKLgKiXo2abKuG4bJiT4Tc8pPYXKBMuBKNDDFlcpZtK
 0pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rChDjX1koIKuBkiHmvCNose3ExYQuzyWL7z4JzRZkr0=;
 b=nL+fMHTY64K131626LdI7sSfMGZ/vknXhF9ozRlhwFhvv/f4SDqQ1/RrV+X7bx6lo3
 v2dc3HDghb/S76CicSthvRIEJcaH4LgWIa+ClerdA9+W4W6yq2CJA5AhD9lew/HZFW1W
 q0wnrC2GZrK7YMTMXSMTT607RjBiMlMpbj2MB/w58dLPtRbwqUocZpTEtqiBzjBfQw+q
 u6eszKMVX0kUa/8Xbw6HgZswrlwsSHCD/GpCCTKlNPzjBRAVRll3YJI4qdSktt8nUoJp
 Q4EZA/MJNZSVECFGVVvoCRgpRZl/9aSSX1wArmqZm85KJFM5czucQqmgIqnyWlFvTLlN
 jsHw==
X-Gm-Message-State: AOAM533eCy1MC3M6fQ6u8zL+fuSBUY2nda9qYDyTIzsEwoIj/+F6I2b2
 8A5V/5au/owUjz7lfycZZXW3SA==
X-Google-Smtp-Source: ABdhPJwK+LyDzPqopUq2RjUApJ9a1oBJdHy3xGwvCrPrY8P3iPNPISYVaIIIT1zwDJ4xSrQJPxrsgQ==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr4315988wmg.8.1590686373780;
 Thu, 28 May 2020 10:19:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 88sm7096050wre.45.2020.05.28.10.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 10:19:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3D4A11FF7E;
 Thu, 28 May 2020 18:19:31 +0100 (BST)
References: <20200527145455.2550-1-alex.bennee@linaro.org>
 <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
 <87blm83y5v.fsf@linaro.org>
 <CAFEAcA_QTkWA7eBwORWMmpcH1E5bF4A3mFtkzdstkucd-2+p3A@mail.gmail.com>
 <591d2690-c2e7-98aa-8569-5f99737c5f71@redhat.com>
 <CAFEAcA-EZ_c01599j+NJH1Vd0aJ4cQzwPYynx=rBZP7x_3h3jg@mail.gmail.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/12] testing and plugin fixes
In-reply-to: <CAFEAcA-EZ_c01599j+NJH1Vd0aJ4cQzwPYynx=rBZP7x_3h3jg@mail.gmail.com>
Date: Thu, 28 May 2020 18:19:31 +0100
Message-ID: <877dww3rks.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 28 May 2020 at 16:18, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> +Gerd
>>
>> On 5/28/20 5:09 PM, Peter Maydell wrote:
>> > Yes. I see them also now on the next pullreq I'm trying to
>> > process. How do I get back to an environment that doesn't
>> > produce all these warnings?
>>
>> Maybe building back NetBSD 8.1?
>
> Did that change not itself trigger the VM to be rebuilt ?
> If not, can we make it so that updates to the images always
> do trigger rebuilds, so that we can catch new warnings
> that they introduce at the time rather than later?

$(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \

So netbsdb.img should have been rebuilt when tests/vm/netbsd was
touched. However maybe the packages have been updated upstream since? As
we also have:

			$(SRC_PATH)/tests/vm/basevm.py \
			$(SRC_PATH)/tests/vm/Makefile.include

I suspect the genisoimage change to basevm triggered a re-build grabbing
the latest packages.

--=20
Alex Benn=C3=A9e

