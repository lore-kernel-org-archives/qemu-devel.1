Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D383FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3C62088F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wY61faPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3C62088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTtQ-0006I7-PE
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXTsR-0005M4-Fv
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXTsP-0003kU-Pc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:34:50 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXTsO-0003jq-4S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:34:48 -0500
Received: by mail-wr1-x443.google.com with SMTP id b3so763592wrs.13
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 09:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SWOGjDF70lQ+y2SahLhXe0XUOyqQScDDkHWYhcffNb4=;
 b=wY61faPLPRQcXU0pR2/hykATtnxx0I6ku7bZy/St+Yf61JlCAPr6NmaCpThtjIK8rh
 Q6yCAgf8cOX5xEXu/5FCAU1qXZn0Hm/VXPyEM+OMZNHbJdPVDka/yM+/Qf+cHya6zwpO
 mYWK2kACaIc72tFupF71XoNG3HvW2bOi2j0v0aX6H2T/9nHFrdXwToAONAUFwbdrnpQH
 RxHPBWTCYsd2SH/I5LT0YLMIyHgDJ07Advrgur6yvruT1RmxxCHatplNds8M4ROG9qaY
 hVuiXyJr1Bo20LSBiX6hHSPkZD0fZmsyzDV57tXs6FWDsO1L1zSG2S3MLQEEeAk3iZv7
 WhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SWOGjDF70lQ+y2SahLhXe0XUOyqQScDDkHWYhcffNb4=;
 b=BbBcLy45sS5ROEU5bGC+J1t/8vE17sUxXW5QJlTd4br+jHt5NcSueTvSpAsTjb517c
 XA/wh+CW4eemqxqHxSJH+tXFBA8pbzldOHos6jHOal3R3fMdkkE5vegzSxI22LhggGAM
 ycQwwOz/z5iVvy79EACrMRTBHDFz3eXE1r+FLp54ZfZlLVyt1zVi9iB5NYm8j3k6HJCT
 1LaFGG8GwG0SMtEOnLtbCPLZ219RdIupk9THTAbOfoQ7ppmnAAU6vrIybYhUNINCHk7R
 UamLVbXQySXkPoDYUQPKP6BACPLK3kuQXL7ynDwfFYFetlWt9tlq5nLVmlmm1v4KI6mX
 9ZvQ==
X-Gm-Message-State: APjAAAWSD2bnlYlxb8+lhQ2hdX8anP+APU4qtILLgNguthW1Ce6VH1Kd
 bXEeWJLNcaNjdzHagSEf8kM/RQ==
X-Google-Smtp-Source: APXvYqwQTMm9DTdcZ697wubIPs8uEXTtefxmB1O52D7lp4GjKQl9mssGxJcxgzpSt+R9nDYyBLfQGQ==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr4651935wro.325.1574271285966; 
 Wed, 20 Nov 2019 09:34:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x9sm30973997wru.32.2019.11.20.09.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 09:34:44 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A0721FF87;
 Wed, 20 Nov 2019 17:34:43 +0000 (GMT)
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <82dfa44e-0a27-080e-2653-b004c27fc3d1@linaro.org>
 <CAL1e-=gmLywnyUoySxuDPS1FQRx=WiH1kYrqEJDGAAcO5vDg4A@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of
 patches - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon - Files in target/hexagon/imported are from another project
 and therefore do not conform to qemu coding standards
In-reply-to: <CAL1e-=gmLywnyUoySxuDPS1FQRx=WiH1kYrqEJDGAAcO5vDg4A@mail.gmail.com>
Date: Wed, 20 Nov 2019 17:34:43 +0000
Message-ID: <87h82yfo3w.fsf@linaro.org>
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Taylor Simpson <tsimpson@quicinc.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> On Tuesday, November 19, 2019, Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 11/19/19 6:22 PM, Taylor Simpson wrote:
>> > - Laurent suggested I split the patch into two parts: linux-user and
>> target/hexagon.  If I do that, which one should contain the changes to
>> common files (e.g., configure)?  Also, note that we won't be able to bui=
ld
>> until both patches are merged.  Is that OK?
>>
>> The configure parts should be a third, last, patch.
>>
>> The series is bisectable, because before the configure patch,
>> none of the hexagon code is compiled at all.
>>
>>
> I don't think this is a good advice. Yes, at first glance, that would make
> the submitter's job easier - since he could divide the whole code into
> parts practicaly arbitrarily - but the resulting series will be of
> suboptimal quality. If the submitter was forced from the outset to add
> segments of his solution so that each step actually (not only ostensibly)
> compiles, he would also be forced to organize patches in much more cohere=
nt
> way, organize his code in much more modular way, possibly improve initial
> organization, additionally making reviews much easier.

You can do what I did for the TCG plugins which is put the machinery
patches at the start (or near the start) while developing but move it to
the end when it comes to the final series and PR.

It's fairly easy to move patches around.

>
> Aleksandar
>
>
>>
>> r~
>>
>>


--
Alex Benn=C3=A9e

