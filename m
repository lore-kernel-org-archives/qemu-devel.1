Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F731C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCC021556
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8WN1XXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCC021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nxk-0001cc-Nl
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8nws-0000fF-RG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8nwr-0007eH-0P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:29:42 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8nwq-0007dj-PI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:29:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id r17so475688wrj.7
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 08:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=D0bx2dNh3+TNcQBLPlLZk0X9uMBN7Fd0OnzNSGcA1Vk=;
 b=M8WN1XXr89yVTcvYH6uGG0usvrdV5sG3NF22Y6qsLp2FPzDn4RVWe/IigAeRnA2aWy
 aEBL6YCG1mK5U5cl6URpAJHWbhmptpa1XcAfav88zTmMQQFI3rAxVGVVaxN7qpuIgRnC
 D+4cqwIjoUOp5HJG67sWcFNYFJZ5WKKdCRbiaJzAz1wxiw2zkazyZgaGXlfamxlzp/NW
 z93PucLoVWPtjBxpwIHvwrHfAVsW5SmOmcOhBCfrDj/4zqHw1fxRuk38MVEQE8pFYclx
 LqLKYzFH4fkQ4QQvcUIoD9kglHxC8xzd3JWRPy5MSb0XRfW+eCcwmshWiTC7RYvcdvuh
 qJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=D0bx2dNh3+TNcQBLPlLZk0X9uMBN7Fd0OnzNSGcA1Vk=;
 b=mojRmGziWhi/KW9B0JKTlS5S+dQrjC8jJUHBPzJOlz6IIlxrVEUgdmIS/1Ip4/l7Dn
 mNxqFBwwJyYMlwNUwOh+/AtpyBhbovMkY9yPj/T9Oot0CiOnpPegCHDW0okgHdfvruCG
 FOX9H+ZlbRZMRxopQvUvqTxkoPwE1Xkqls+w0a/BSe2fQNdAdqCi6RBdHzSb+jmfcH2r
 zmnI5zXhaX4/rnBMvwgKlbzu98Knwg3lmnCAvEofWQ+YRRRY1k1GY+UDqxI0JhMt04X/
 F4hR7LTr8AF2AOoU6Lx2J1sCoUJWc8xmKp7rcLoEtTHRXzBHR1arow4Wxj1hK1EMkK5H
 5awA==
X-Gm-Message-State: ANhLgQ0B41+cMXwXpot1trMLLMgncInwjAmjBqg2fqnVZPg6oFDFjXCR
 mHgSisOKumKY8UdjuLaz5FPgcA==
X-Google-Smtp-Source: ADFU+vu81mA43XtLjXuUH4TKKk4eIxD8Bv1sdufESHLs4OwQfieeqGQ3s6GGEgB08MeCQ2exZzzhdA==
X-Received: by 2002:a05:6000:114f:: with SMTP id
 d15mr412116wrx.130.1583166578806; 
 Mon, 02 Mar 2020 08:29:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h20sm6058359wrc.47.2020.03.02.08.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 08:29:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CAF921FF87;
 Mon,  2 Mar 2020 16:29:36 +0000 (GMT)
References: <cover.1582576372.git.jag.raman@oracle.com>
 <8736as5lto.fsf@linaro.org>
 <792aa6ff-3669-9e92-8d93-ec6d82e08df7@oracle.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 00/50] Initial support for multi-process qemu
In-reply-to: <792aa6ff-3669-9e92-8d93-ec6d82e08df7@oracle.com>
Date: Mon, 02 Mar 2020 16:29:36 +0000
Message-ID: <87imjm90un.fsf@linaro.org>
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jag Raman <jag.raman@oracle.com> writes:

> On 3/1/2020 6:57 AM, Alex Benn=C3=A9e wrote:
>> Jagannathan Raman <jag.raman@oracle.com> writes:
>>=20
>>> Hello
>>>    Started with the presentation in October 2017 made by Marc-Andre
>>> (Red Hat)
>>> and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum 2=
018,
>>> the multi-process project is now available and presented in this patchs=
et.
>>> This first series enables the emulation of lsi53c895a in a separate pro=
cess.
>>>
>>> We posted the Proof Of Concept patches [2] before the BoF session in 20=
18.
>>> Subsequently, we posted RFC v1 [3], RFC v2 [4], RFC v3 [5] and RFC v4 [=
6].
>>>
>>> John & Elena presented the status of this project in KVM Forum 2019. We
>>> appreciate the in-person and email feedback we received to improve this
>>> patchset. We also received valuable feedback and direction on future
>>> improvements from the bi-weekly KVM community conference. We have
>>> incorporated all the feedback in the current version of the series, v5.
>>>
>>> Following people contributed to this patchset:
>>>
>>> John G Johnson <john.g.johnson@oracle.com>
>>> Jagannathan Raman <jag.raman@oracle.com>
>>> Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>> Kanth Ghatraju <kanth.ghatraju@oracle.com>
>>> Konrad Wilk <konrad.wilk@oracle.com>
>>>
>>> For full concept writeup about QEMU disaggregation, refer to
>>> docs/devel/qemu-multiprocess.rst. Please refer to
>>> docs/qemu-multiprocess.txt for usage information.
>>>
>>> We are planning on making the following improvements in the future to t=
he experimental
>>> Qemu multi-process:
>>>   - Asynchronous communication channel;
>>>   - Performance improvements;
>>>   - Libvirt support;
>>>   - Enforcement of security policies and privileges control;
>>>
>>> We welcome all your ideas, concerns, and questions for this patchset.
>> There seem to be quite a few CI failures with this series applied:
>>    https://travis-ci.org/stsquad/qemu/builds/656432858
>>    https://app.shippable.com/github/stsquad/qemu/runs/1275/summary/conso=
le
>>    https://gitlab.com/stsquad/qemu/pipelines/122030403
>>    https://cirrus-ci.com/build/4577637150490624
>
> Hi Alex,
>
> Thanks for pointing it out.
>
> "Patchew" also identified some errors which we are working on fixing for
> the next version. Patchew summarized the errors in the following page:
> https://patchew.org/QEMU/cover.1582576372.git.jag.raman@oracle.com/
>
> To confirm we're compliant with Patchew, we are running docker tests
> before sending the patches for review next time around.
>
> We'll use the following wiki to trigger "travis-ci" tests before pushing
> the branch for review next time around:
> https://wiki.qemu.org/Testing/CI/Travis#Testing_Changes_to_Travis
>
> Are shippable, stsquad & cirrus-ci redundant if travis-ci & docker
> tests

stsquad is just my user account, hopefully I'm not redundant ;-)

They all test slightly different things but you should be able to
replicate the tests locally.

Travis basically tests a bunch of different configuration setups on
mostly x86 hardware. Unless it's a weird library interaction issue this
should replicate in your normal build environment.

Shippable are cross compile tests. They use the existing docker
infrastructure to cross compile for various target architectures. See
"make docker" and the notes in docs/devel/testing.rst.

CirrusCI tests MacOS and FreeBSD builds. You can build on the BSD's
yourself, see "make vm-help". MacOSX is trickier unless you have a Mac
yourself of course.

> pass?
>
> Thank you very much!


--=20
Alex Benn=C3=A9e

