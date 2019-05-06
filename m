Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BA1C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BF020830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUk0VMTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BF020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNiuO-0002Pz-Vn
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 15:04:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNitH-00023u-CH
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNitG-0001kT-BH
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:03:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hNitD-0001iJ-LI
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:03:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id s15so18650823wra.12
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=pKxq1OoKpAaW+mncJBoJA+iPdqsh1Xhimw3MFU+a4BQ=;
	b=HUk0VMTyo7ovia7qiMLtSf69oWUvOPU7b0+x7g0X0ivt56i3R89litErKx5wKcjZIy
	RmZ00E2HUPTxovwuk5/mrVn6B1acYiDQ+iFI9HVIRqOFw4/tp9JEbroV72AAHSd1m6ID
	4Pwa3XR8AGm3IJPTlObQ70aOky4e9gvEL7IMRHYyKfx18ujBbdLM7kCfNf33SIKb/BaX
	rq8+iZOE64DyZnf5e6j7KT6CBsI4IGyau9EaVy2WKzeQomDT0wtgBoc2z7utknJOlZZ5
	28qZHw0eNMoPZfN6AF+c5i3wntlslrrQCf8rvPPC6mL880Lj2cY+7R6zv7RrvSb3LA4C
	t4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=pKxq1OoKpAaW+mncJBoJA+iPdqsh1Xhimw3MFU+a4BQ=;
	b=otldFdpWAJfoO1bypBiv0G+20u3bCUd6K3GKoWOvwmUpJ70qk1X5ARv9yD4eW4/5yT
	/alVU6v0N5+WFtA7V6IFd24IXLSeCQK3FGEF0yq41aubAKspCdmp4uz/+6HOIKyQxeg8
	FZAIwtHJetidfaXK9yTSRyN+nNLeNnA0BQ8FUC1VMoMJf8SDtjq1KhCDQXUPuZ0a/IFh
	JgRdy3ylTVZMsQzZX5BQDMONcjFHpdf5Tawiiev54XTmTdN2jVYBOHIQPHQY1pAvceNN
	SaHbymNjItri5immV37+8I5jRaeliSzKZEuDYeJi/DTc8iVoNNoqTO2WLkJ8bVuA2MiC
	rXEw==
X-Gm-Message-State: APjAAAWdiHJjuK8WfXC5McXxtykSEEvrDf0h9mrQwbnzhAQfmeX6oT9J
	EJ8tAa5rInB4wCEPk9qeoBETfg==
X-Google-Smtp-Source: APXvYqwmtk5x2PsoWZRQWusrXVrTIKr2nmCYkzoz0klnQP0fs/tJ83wmWK/IcVwD3XYN3u+H/ZnNRA==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr18531829wrs.5.1557169380556; 
	Mon, 06 May 2019 12:03:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z9sm17571677wma.39.2019.05.06.12.02.59
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 06 May 2019 12:02:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 95EF81FF87;
	Mon,  6 May 2019 20:02:59 +0100 (BST)
References: <20190503143904.31211-1-alex.bennee@linaro.org>
	<98cd84db-2aed-4aa1-1f2d-eaa7ac63b72b@redhat.com>
	<87d0kz4iqs.fsf@zen.linaroharston>
	<0badc17e-90bc-1a09-89c1-20f88ff75d3b@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <0badc17e-90bc-1a09-89c1-20f88ff75d3b@redhat.com>
Date: Mon, 06 May 2019 20:02:59 +0100
Message-ID: <8736lrbe3g.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output
 to for make check-block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 03/05/2019 18.15, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 03/05/2019 16.39, Alex Benn=C3=A9e wrote:
>>>> This attempts to clean-up the output to better match the output of the
>>>> rest of the QEMU check system. This includes:
>>>>
>>>>   - formatting as "  TEST    iotest: nnn"
>>>>   - calculating time diff at the end
>>>>   - only dumping config on failure
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>  tests/qemu-iotests/check | 71 +++++++++++++++++++---------------------
>>>>  1 file changed, 34 insertions(+), 37 deletions(-)
>>>
>>> Thanks for tackling this! The output now looks nicer indeed if you run
>>> "make check-qtest check-block -j8". However, if you add a "V=3D1" at the
>>> end of the command line, the outputs look quite different again...
>>>
>>> That's why I thought that having a TAP mode for the check script could
>>> be a good idea, too. Then we could pipe the output through the
>>> tap-driver.pl script, too, so we get uniform output for all tests...?
>>
>> That would probably be a cleaner approach. What would be even better is
>> somehow expanding the list of tests at make time so you could run your
>> tests in parallel.
>
> I agree that this might be the ultimate solution ... but I'm not sure
> whether the iotests are really ready for being run in parallel yet, so
> it will likely take quite some while 'till we are at that point. With
> that in mind (and thus also not sure yet whether my TAP idea is really
> the right approach), your patch is certainly a good interim solution
> which we should try to get merged, too, when my "make check" series gets
> accepted?

I'm happy to take your series through my testing/next tree if the block
developers are happy with the hack-ups I've made to the test script to
make it fit in. There are a few comments which I can roll in and I'll
get testing/next posted tomorrow for final review.

--
Alex Benn=C3=A9e

