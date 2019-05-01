Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AE0C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F62620652
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGN4JRgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F62620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLuA5-0004zL-Qu
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 14:40:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu8k-00049g-PG
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu8j-0003za-Rf
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:39:34 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLu8i-0003sk-0d
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:39:33 -0400
Received: by mail-pg1-x533.google.com with SMTP id k19so8664416pgh.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Kj0keHvXRKBv5NJEBu8JraLrYMQq/S0KTlYv84qVXxA=;
	b=vGN4JRgnQuhs/tknmZkgyeM1T+BF7qTB15kOQuwB8voBKgqkWR5xIJKKN00tVytHoS
	p+EXE3CSczUjaleeGdO5B2MGNjHXxuwryBki7KSIzfYfNvXq+DcUkmLRpBZUTnDU7XYg
	CZ9fRf6x2aUaGmsswwAp23OffSlekrS7hAymQaYmE7EDLdTFjFzLuYbGtmAQEFTSdyD7
	oJo6VTm6ZxWG7kV9pELCK63MANL6pPKRrcaZf7AmYU6iL/oceCRaw+aU7zf55auqJbud
	hA7mRLa6qW0rWI3zlPeHd7Gxlnt5A8k+67JylZKOvxd7JscFSGYn/hPtJPqTHNTfHL8W
	m8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Kj0keHvXRKBv5NJEBu8JraLrYMQq/S0KTlYv84qVXxA=;
	b=VyKbrnXK2toROei5Aa/KusTRzxyCNdldEmBllGV3EpvSkB6sWG4fIEZcuV69HYZ/Fx
	wb0DoxJYN+CSla2cXZQqo35dtvaCUjfYFCrBayeasw7+kiA2lW7qYZUhwcm3IYFsRJM3
	+xTAHl8odKNMgnfaAER4L7p8zLGcXl3tEY8XoZ12T+sLwZc7DmfoG0A03JEQNhva/CHw
	vzDVSPZenUBNjX5zn53SUAuEBM0l6olhhsEoMRhHDVeY42ysdQiKsjMwZUhy+N52uD0l
	TmXW0NzdAsqIAEivKHoWufRYbVSna2TqX3n5PcYmxxtCJS4NVwnh9UoXnZ6N//DSI1dR
	vZdg==
X-Gm-Message-State: APjAAAWD2FLRvXCKmpoEPSUOGvJqS2s3BSHVhESMHBP04rjlUX+i1kA2
	PFlgQDXsQbF8oMNlLdIouq5aFg==
X-Google-Smtp-Source: APXvYqzgK9FKeWfUTvMLiTEetR43z2xqnoPWIJl8rxsgLEvlGpT0K0iOZovy+1s4e/OEaGSSj/qu5w==
X-Received: by 2002:a62:6086:: with SMTP id
	u128mr81330484pfb.148.1556735969184; 
	Wed, 01 May 2019 11:39:29 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	b1sm45452573pgq.15.2019.05.01.11.39.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 11:39:28 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190430165234.32272-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9a538ea2-358a-dc61-b2f3-f8155c1a2283@linaro.org>
Date: Wed, 1 May 2019 11:39:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: Re: [Qemu-devel] [PATCH v5 00/15] demacro softmmu (plus
 tests/coverage)
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
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501183926.GngIyNwV3TSgw78Lwj_ikJGMLMwGtzzjBlJyciyIMGs@z>

On 4/30/19 9:52 AM, Alex Bennée wrote:
> I've also moved the existing system memory test and made it multiarch
> and added the bootstrapping for aarch64 system tests. I would like to
> add support for Big Endian as well but I didn't want to delay the
> posting of the series. It would also be nice to exercise the
> ioread/write paths and other handling but I leave this as an exercise
> for later.

Somewhere in there you're adding

  -chardev file,path=hello.out,id=output

but there's no corresponding use of the chardev.
Which, somehow doesn't seem to matter to your aarch64
testcase, but when I try this for alpha I truly get
no output at all.  I needed

  -serial chardev:output

to populate the file.


r~

