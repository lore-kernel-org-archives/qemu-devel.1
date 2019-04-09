Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6ABC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093DB20850
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNSGOLrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093DB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE0DA-0003YD-BD
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:31:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hE0CJ-0003A3-M6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hE0CI-0000QX-BT
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:30:35 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hE0CF-0000Pe-H4
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:30:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id b3so154191plr.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 16:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:from:to:references:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=U+P2tF9FYYTIbq1rv840MAIkji/zpCbpoIP3DbAksQ8=;
	b=iNSGOLrCZeIMLDrR3VMa+JyZKEmsK875GW0493g8mGE0E2bTW9km/YJxBW0uy6uJqQ
	KUEOc9tdxfbU+FVfzOHXabEjBDgMvVwnaPEAdnAONM/19LEPaXmyiVWpmYciRE8T+bB2
	2dg45mdMAdUVd4qw2z6nH0pMeftSddniHgqnc51BFH1TN/00OZE4YFi0KVEJ+gi2I//r
	ZNisHFjJEFxHYwg/csK+lBRLwJr9ISHu/CwJ1qsocgvMYps4hFvKhQoIWJenDLVRXYA3
	P7CwsKfGqIo3CDgJCgJy8BYBPHoV5zPzlCIf44ofkpDli4AIcWKSr7QXq+INK9GoxhNl
	ORRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=U+P2tF9FYYTIbq1rv840MAIkji/zpCbpoIP3DbAksQ8=;
	b=kG1v7mfxYhKD4IzTDsU/KFK1w8nDcztkDSiolqTvRHhRW5wKQQzIFEL3T9MDO+Fd3T
	pppst3Bct401o69QwBfI7b4A1VOZ5Kig+LCR50elQvGToIv/BHtNwE95wsLNoUGv6T5Q
	4CS54x2ovtS5MEatUYzzZw0TReZBB8xLAN6Rwld03IswCRn8frmhgxrDGrVNjrAho1F4
	MxZgJJDCoo5OlSessSh1FfFtno57jInl1tahH04yPgaiKiO0xAi9i7iopA/EXewCH9FP
	XekAJBfKN3l6Fz2FDLEEJLuagimCeqNWr0kCy4SL02UUdsY6BdLrOTLGKLyReXzYdzbM
	gBAQ==
X-Gm-Message-State: APjAAAVxL1HL/wgQQ9sogd2bniCOLjJOXsZNvhK5jIUugwAZUEY+Eq7i
	6BtzxZYd/p3nYnSC80WQrtHDd+OfQyw=
X-Google-Smtp-Source: APXvYqxbo7Xq8OOYt40b9QCE6Ad3ZLu5eQRyt3G2+gpzVyyVRX892ZKIBceZhId+4DzSz+bxczKMyQ==
X-Received: by 2002:a17:902:8ecc:: with SMTP id
	x12mr40219732plo.0.1554852629728; 
	Tue, 09 Apr 2019 16:30:29 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	j19sm19128790pfr.155.2019.04.09.16.30.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 16:30:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190118213122.22865-1-richard.henderson@linaro.org>
	<20190118213122.22865-48-richard.henderson@linaro.org>
	<86bae9b3-75c8-64df-92d1-b4efc35b646c@vivier.eu>
	<c1dc5dbc-cbc7-16a3-9d14-c93b52c362fd@vivier.eu>
	<2004b6c4-0aea-f535-d2bc-80d5c14537be@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d0735945-f5de-5ddc-327a-53eaec40d0d1@linaro.org>
Date: Tue, 9 Apr 2019 13:30:26 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2004b6c4-0aea-f535-d2bc-80d5c14537be@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v6 48/49] linux-user: Split out ioctl
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409233026.t0ZUT7Qq0oy-bzLvnt3JiCqA-z_40ScO9br2DTVGKoM@z>

On 4/9/19 1:15 PM, Richard Henderson wrote:
> On 2/13/19 3:46 AM, Laurent Vivier wrote:
>> In fact it happens with sid, with ppc64 too, but not with m68k and sh4.
>>
>> And only with "unshare --pid --fork".
>>
>> Without "unshare", the result is:
>>
>>   Unsupported ioctl: cmd=0x80047476
>>   bash: cannot set terminal process group (11507): Function not implemented
>>   bash: no job control in this shell
>>   Unsupported ioctl: cmd=0x80087467
>>   Unsupported ioctl: cmd=0x80087467
>>   Unsupported ioctl: cmd=0x802c7415
> 
> I'm just now getting back to this, and cannot replicate the issue

... Oh nevermind.  I should be expecting no "unsupported" at all, since that's
what we get with master.


r~

