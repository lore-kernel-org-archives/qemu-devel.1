Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24179C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA93823F04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2DMNqvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA93823F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48839 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY5CM-00062t-3O
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 04:53:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hY5Al-00058W-FM
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hY5Ak-0001Ox-F6
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:51:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hY5Ak-0001OL-4Y
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:51:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id c6so10870302wml.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=E+0gdnk2zFsqvhIMvOxfAZSOkzi7ahsa38Rv7Htkmd8=;
	b=I2DMNqvYyrPIupnpdaQI/vxNoxNH3Qims/ePWZNZNS2cYkRen3Lp8MJ4TCyQ7WJsLd
	/Xi++0ueA4bBvvKYf+/bDdpRVknCVoPuQJeBtZDnN/yuIucSIfKD/RLWMZeKJAOxbGfM
	0MX+rJrxWkDXVszAAQmhSgtafF28XCF9XduYcp7FehgrDHGEHyfXr3Hv5ufajeJhsXCg
	eFuZCXfVQYUyGkn9JKTy+QuNXdC61PCJj6fiTCbg5MYZ2Ff08+PPPYaFJDQr6s6d/MkA
	NNSkOzKosjtfJSdoF485HQmiQpS4TY6Bmz44J0m7zmfH3PUHRGlloKT8f7fA1FAM7plc
	2Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=E+0gdnk2zFsqvhIMvOxfAZSOkzi7ahsa38Rv7Htkmd8=;
	b=CPT12A1U3CzcjsMerWhhyNtk0k340HT27I0KI0k4NXo8b7CaOTW8kGSPi1fQGShI1L
	JcSr7/F9RADiOT34VKlwTW47aqSS1BGb0YDylDW2X9r5BwwIRqew/giB1lhsqcJySl4j
	gMp1hZcr/lXVWN8F9jpczFtj85Ul7ZWTYjTj9ZW+vEj2AP3qz/HzOhEkDLeiH7QBA6om
	nKCc+NMr1JDKZvn8NQEvSg62ZnVq1ygeZYA4aL5aEWWmrnweeIoXyuxk3lBZBcoYCUVj
	LRmZK19TloIJEA/R7mewSHTa9s9lGtAtzFUh9+3DzpI/1hKTpe32zFz1KZ5/fUNk0h/e
	Ng6A==
X-Gm-Message-State: APjAAAU9uerRdhfDaTW5B33lEz2ZcpdXQNM2tolt1O1CyZlPVT2y+B7i
	780o1O1dPZqNZANDPn+bmZUNhg==
X-Google-Smtp-Source: APXvYqzy2N0MwDd/Qg0EPjfhdR8J3cioub7fDEpM1fRsKgbmSNVHGCQv4tLlGZC8iCjPJSMAhy7/GQ==
X-Received: by 2002:a1c:21c4:: with SMTP id h187mr17631216wmh.27.1559638316486;
	Tue, 04 Jun 2019 01:51:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	u205sm20552858wmu.47.2019.06.04.01.51.55
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 04 Jun 2019 01:51:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 293C61FF87;
	Tue,  4 Jun 2019 09:51:55 +0100 (BST)
References: <65b0acd5-e919-73a3-e313-cb01da12afb4@redhat.com>
	<78b8e397-8bf3-ac52-02f5-dba79372480f@redhat.com>
	<ae439814-4ed1-eb40-7a44-cea1a566a850@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
In-reply-to: <ae439814-4ed1-eb40-7a44-cea1a566a850@redhat.com>
Date: Tue, 04 Jun 2019 09:51:55 +0100
Message-ID: <871s09u40k.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] "make run-tcg-tests-s390x-linux-user" not working
 for me
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 04.06.19 09:25, David Hildenbrand wrote:
>> On 04.06.19 09:17, David Hildenbrand wrote:
>>> Hi,
>>>
>>> for now I was able to run TCG tests using "make
>>> run-tcg-tests-s390x-linux-user". Lately, trying to run the tests always
>>> results in
>>>
>>> t460s: ~/git/qemu vx $ LANG=3DC make run-tcg-tests-s390x-linux-user
>>> make[1]: Entering directory '/home/dhildenb/git/qemu/slirp'
>>> make[1]: Nothing to be done for 'all'.
>>> make[1]: Leaving directory '/home/dhildenb/git/qemu/slirp'
>>>         CHK version_gen.h
>>>   BUILD   TCG tests for s390x-linux-user
>>>   BUILD   s390x guest-tests SKIPPED
>>>   RUN     TCG tests for s390x-linux-user
>>>   RUN     tests for s390x SKIPPED
>>>
>>> t460s: ~/git/qemu vx $ LANG=3DC make check-tcg
>>> make[1]: Entering directory '/home/dhildenb/git/qemu/slirp'
>>> make[1]: Nothing to be done for 'all'.
>>> make[1]: Leaving directory '/home/dhildenb/git/qemu/slirp'
>>>         CHK version_gen.h
>>>   BUILD   TCG tests for s390x-softmmu
>>>   BUILD   s390x guest-tests SKIPPED
>>>   RUN     TCG tests for s390x-softmmu
>>>   RUN     tests for s390x SKIPPED
>>>   BUILD   TCG tests for s390x-linux-user
>>>   BUILD   s390x guest-tests SKIPPED
>>>   RUN     TCG tests for s390x-linux-user
>>>   RUN     tests for s390x SKIPPED
>>>
>>> I am using "./configure --target-list=3Ds390x-softmmu,s390x-linux-user
>>> --enable-sdl --enable-spice --enable-kvm"
>>>
>>> What am I missing? Why is the build skipped?
>>>
>>
>> BTW, docker seems to be working fine, just tried with "make
>> docker-test-build@debian-armhf-cross J=3Dn"
>>
>
> Turns out I had to rerun ./configure (it didn't include HAVE_USER_DOCKER
> for some reason).

Yeah that was a relatively recent addition rather than dynamically
probing everytime we ran.

>
> Sorry for the noise :)


--
Alex Benn=C3=A9e

