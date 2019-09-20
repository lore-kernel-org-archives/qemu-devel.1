Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A2DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 21:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF4020820
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 21:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcgQFTKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF4020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBQKd-0005iv-Tb
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 17:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iBQJ5-00055V-Kw
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 17:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iBQJ4-0000Hw-12
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 17:19:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iBQJ3-0000HS-N3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 17:19:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id l3so8122645wru.7
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UDmSei4slaX3kYd3qy8Tc7w8Yoe03eHEkjbUupYh64I=;
 b=FcgQFTKBYKrs4sEmsEiLnVQhifeWOC5wFqqlHnFBIYXGe45Oc+q1Ufk289PM65X1zu
 ZHSN6PjCqsPFCtYq0tV6Jdg+XStBdIo9Oc52ewui/Bny2iO6IqcGLmnZAM4WibOnToOv
 JD60YP0JXu3aZtIPzYKLyuCCcA8NhxO57syxXxETqxAFjxx/iCq+dwkIY2v1yMtrjbzm
 i2iLqK6q9AF3IgBjUnnswKT3UZeAE/3D4DAX83kjQBsyjTFJ42WNi5XB6f1Ev94sRBOW
 hXDulKM1cLt8cQ0Z5UJUbOimXyDU7Frlxb6+C17UeSWVm/q5ZOSBI58Y0no/PonCNu9J
 m4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UDmSei4slaX3kYd3qy8Tc7w8Yoe03eHEkjbUupYh64I=;
 b=OnhiI9FZyMJyD4o7juk2VZvxzyurkj8aiVaFMFSeBsHPoPoPx1beoPR56HmcGYqD/T
 dqmnLpCUeyzegTWBF3iyUvXWMrwgdFzEuXHNTPmxZm+GcXoWZbB9l4SUjRZiLMusqCDf
 5WLuXNl94uYUtw1KPdVFkQDfagjTwlm3lKB+U2PYBKHzQ93fNigfw5CFXAQgzq/GTWXD
 3yLrdDOF/BIfLQX86+eaC64eD6dfVHjLPzAzzbYqdorjydmOG3KR72m72lh83hjUP4qW
 6drqJwWE/L1AlrsucswAH4MyQ1Dqomb9WxAUtwZusIU+d2yo4IqnxZ+mgBdWlQwunPrk
 uk8A==
X-Gm-Message-State: APjAAAW44xDlqBTMJMAR2bPTmtbMGBDRUPbq45XjsgWsYbFArofb+txg
 COmAqs7+IHoNNS7l5xxOz0W5mQ==
X-Google-Smtp-Source: APXvYqyDBJVOqyzsV51fhE9cJs3+hLnLWErRbIBPU8pWhuU6kogjExX5J1rnoeYQGLQMbUIeKRN9/Q==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr13702582wrr.64.1569014348150; 
 Fri, 20 Sep 2019 14:19:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z1sm6135388wre.40.2019.09.20.14.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 14:19:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5B461FF87;
 Fri, 20 Sep 2019 22:19:06 +0100 (BST)
References: <20190920001413.22567-1-jsnow@redhat.com>
 <20190920001413.22567-4-jsnow@redhat.com>
 <731ae95b-7c70-43ca-bea9-28b00de232d5@redhat.com>
 <c7b12028-0294-0d9c-3e94-60b2ba7d3528@redhat.com>
 <87d0fvym64.fsf@linaro.org>
 <00e77307-d386-7ea1-3e1d-b3970bf25b8e@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 3/3] docker: remove unused debian-sid and debian-ports
In-reply-to: <00e77307-d386-7ea1-3e1d-b3970bf25b8e@redhat.com>
Date: Fri, 20 Sep 2019 22:19:06 +0100
Message-ID: <87a7ayzmwl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> On 9/20/19 12:20 PM, Alex Benn=C3=A9e wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>>> On 9/20/19 4:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 9/20/19 2:14 AM, John Snow wrote:
>>>>> These are listed as "partial" images, but have no user.
>>>>> Remove them.
>>>>
>>>> Well, I have WiP users from them. I could restore this content when th=
ey
>>>> are ready... Ports is the base of deprecated Debian archs. On the other
>>>> side Sid is the base for edge development I use from time to time to
>>>> test latest gcc/binutils.
>>>> I'll try to find time to raise WiP branches to PoC.
>>>>
>>>
>>> I think that's the right thing to do. Right now, the docker tests
>>> directory has a lot of stale entries and unusable tests. That might be
>>> fine for the people working on it, but it makes it hard to understand
>>> and use for those of us who only occasionally traipse into the director=
y.
>>>
>>> I'm removing all references to python2 -- but if there's no way for me
>>> to test debian-sid and debian-ports, I can't test changes I need to make
>>> to these "partial images", so they should be removed until they are
>>> consumable.
>>>
>>> While I am sympathetic to the idea of having a library of partial images
>>> to use for future tests, they're prone to rot if there's no way to
>>> exercise them in-tree.
>>
>> Don't forget some "partial" images are only used for building TCG tests
>> - we want to keep them. But as git is forever I can drop the sid/ports
>> stuff for now until Phillipe has something to use them again.
>>
>
> Oh, where? Is that defined within the tests/docker/Makefile.include or
> in the TCG tree where I have not gone spelunking before?

Now they are selected by tests/tcg/configure.sh but generally they
DISTRO-ARCH-cross images.

>
> --js


--
Alex Benn=C3=A9e

