Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708BC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4213923DA9
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEd9+kgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4213923DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWcjm-0005hM-D5
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 04:18:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWci2-0004Qo-Nr
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWci1-0007Ip-QO
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:16:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWci1-0007H2-J4
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:16:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id f10so5454183wmb.1
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=O97IgFMCFRZwWXFBnbvNNbEqWTuVBiX4GIEEOnJTGbs=;
	b=JEd9+kgdQ7jIPV+yJxgetVI15zsvTnIUkwV5zyTQyl5gC+OXhO3T1lrF8tO42ap2G+
	g1Uvjt97/WwZaxXSOfrSt5mDa9HNr48j53aZQlHgmzEurjS4nm+PYYpIW774W92GJhV+
	+zBXgxlnFG/cslmKjUgN4JvaG9WELvM9HVCGmIm+YO12CGLfk6+ZvvIboctPub4VKlVt
	CO0tCge0JFx2wZZd5F4GUM9arPw190cSNx3OByzBbazHk3t5VnJC83P1S7Nrcelg/2OG
	/Azeq3VU7hFu3zPP9UOFhyqRc5e+I2k8g7v3czunly8ulDbjTZULjv1ucFELDbh6fJNb
	HizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=O97IgFMCFRZwWXFBnbvNNbEqWTuVBiX4GIEEOnJTGbs=;
	b=OtwXPEPJXnnjpK+YmNzhffi4mXqKwFQ+6E718lnZ3/dKoBq0Q5IYUl0IGveNHTHp5k
	B0vQ2XjlsdRnN+LIWLbXMDtWVzTpVE9gXejPA9kN0HKZ4MASn/mlA93Ul+WvPqjUgocN
	NUz2CgeQ2PKR51XdDIq7BuNsoPQZBeeqOAAFjVX8pUTrAK9X/EqDMcBt1VuO/N2/MhmL
	HRCrF5jepfP33E9KXhiCH+Sd8seY0jnH6zO2icfA/D+6DjB0pVVRn1DqyckmZs2RXBMr
	sHJEY5HETalCQ2q6nUQBG6Cc0j/Z0hPj0+r2r/OwDWsufCaVrlCUXWsgGG0b2th/S6WH
	qeTA==
X-Gm-Message-State: APjAAAUw0Ni30ROpYSqwV33Y38HuS/QIeMuL968poaQ2MYNY3WQBFtMY
	uomDqAcNWxUWZyaFhpLQurp4MQ==
X-Google-Smtp-Source: APXvYqzB858Uw+k23uG541wloTi4Am/RST7U2uPUP+7Y9hDtJj+xo3KLMy2qtPxGC/cfySpSugAQrw==
X-Received: by 2002:a1c:dc45:: with SMTP id t66mr4969048wmg.63.1559290576337; 
	Fri, 31 May 2019 01:16:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y132sm7739568wmd.35.2019.05.31.01.16.15
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 01:16:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D5F481FF87;
	Fri, 31 May 2019 09:16:14 +0100 (BST)
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-8-alex.bennee@linaro.org>
	<20190531075638.thjpihktz7zxplvy@steredhat.homenet.telecomitalia.it>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
In-reply-to: <20190531075638.thjpihktz7zxplvy@steredhat.homenet.telecomitalia.it>
Date: Fri, 31 May 2019 09:16:14 +0100
Message-ID: <87woi73upd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 07/26] .travis.yml: bump gcc sanitiser
 job to gcc-9
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
Cc: Fam Zheng <fam@euphon.net>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefano Garzarella <sgarzare@redhat.com> writes:

> On Thu, May 30, 2019 at 11:15:44AM +0100, Alex Benn=C3=A9e wrote:
>> The toolchain PPA has it so we might as well use it.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index b053a836a32..f0aa37f2d12 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -240,8 +240,8 @@ matrix:
>>              - ubuntu-toolchain-r-test
>>            packages:
>>              # Extra toolchains
>> -            - gcc-7
>> -            - g++-7
>> +            - gcc-9
>> +            - g++-9
>>              # Build dependencies
>>              - libaio-dev
>>              - libattr1-dev
>> @@ -270,11 +270,11 @@ matrix:
>>        language: generic
>>        compiler: none
>>        env:
>> -        - COMPILER_NAME=3Dgcc CXX=3Dg++-7 CC=3Dgcc-7
>> -        - CONFIG=3D"--cc=3Dgcc-7 --cxx=3Dg++-7 --disable-pie --disable-=
linux-user"
>> +        - COMPILER_NAME=3Dgcc CXX=3Dg++-9 CC=3Dgcc-9
>> +        - CONFIG=3D"--cc=3Dgcc-9 --cxx=3Dg++-9 --disable-pie --disable-=
linux-user"
>>          - TEST_CMD=3D""
>>        before_script:
>> -        - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3D=
thread -fuse-ld=3Dgold" || { cat config.log && exit 1; }
>> +        - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -Wno-error=3D=
stringop-truncation -fsanitize=3Dthread -fuse-ld=3Dgold" || { cat config.lo=
g && exit 1; }
>>
>
> What about describing in the commit message that we are adding
> '-Wno-error=3Dstringop-truncation' in the cflags?

I was sure I'd written that commit message, but obviously only in my
head. Will update.

>
> Thanks,
> Stefano


--
Alex Benn=C3=A9e

