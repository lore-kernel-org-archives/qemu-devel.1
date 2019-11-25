Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30143C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFEBD20836
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kq3zHZ6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEBD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZBCg-0007li-2r
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 05:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iZBBj-0007Jd-Hv
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iZBBi-0005ff-7Q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:01:47 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iZBBh-0005dy-DP
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:01:45 -0500
Received: by mail-wm1-x341.google.com with SMTP id n5so5062244wmc.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 02:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6R5PmIBwKAfaqQmf9ILg+mDWWuetDVck06AfzjXQEWM=;
 b=kq3zHZ6WhbZG0QOda9h0joAwfmN4CkzRMDo1pzG1aOueEnB26yePhW/F8VW9gqAvo7
 XCDafK997gu9nSOGu0fvPViBvus91ISfMLX+bEEyfPvCw7N9Esrk9Wyv9iMofqzCAod0
 b+UsUMwD0G482CdBl1AqSORjBCnIVmGQnQyd+PRa+62jEGwP6hHIc5fGsNid7KoQTlKQ
 tP4i1BWLOtQX0Dpzn96KAeeg8MZEspFz18PhPq9C6fnAUpHEQLxkiVMq23fv6TBq4VjQ
 E+LYSD8H7/X7cbJxu1AuhmKeTTYYVsuYNCYUGzI1iDZz4s3Y4nodT4dke0ovP4mxBybD
 DfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6R5PmIBwKAfaqQmf9ILg+mDWWuetDVck06AfzjXQEWM=;
 b=gVf+xi2ISEtA8q1XvU6s+cBT3DoOf/NHhJAlLwC0q2Rwor55gEKUTHQF1TD7kIfRfC
 w3mst5ZxVNAwcVYPKA5DOuEfCrCZVtbSHbsXia2YIc7e5WEoPDCFZCRROY5huAj+cP9M
 5CTvnI0MXaBwt3X/A4rHfJDjcsz6ykmGtsLK7vFxWlTYdpjNTlysZ6MeSsWdIK8EB1ze
 ywfXssSI1x9wwx2HdT9yNntMu6nvckwV4yUqBZP3eIUHOqO1Q8puLFE8jzB2jNArhB92
 kd8nqcNmZPeASLqJU4AQY87mvR0IDj05YuIDa8xRoQl2dDOxav6v2tD/6WBlkQPid21I
 Ncpg==
X-Gm-Message-State: APjAAAXi0pyiwiF6Z1qJQZZ8PpBZlJeLc+fV05g3mGJkaDe4/hYjuT88
 OTzh4yI9khr4q7HKUX1F1aoMXvigLWmTtw==
X-Google-Smtp-Source: APXvYqxkZ30MjS6do9XzJT9DD3V5HAfxteHrD89GnQqpgKxJyUjdgSvZLLZhXlXItJfkt18lPINuMw==
X-Received: by 2002:a1c:5415:: with SMTP id i21mr28411606wmb.120.1574676102402; 
 Mon, 25 Nov 2019 02:01:42 -0800 (PST)
Received: from [10.0.0.120] (host-87-242-235-70.ppp.onetel.net.uk.
 [87.242.235.70])
 by smtp.gmail.com with ESMTPSA id z11sm11053293wrg.0.2019.11.25.02.01.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Nov 2019 02:01:41 -0800 (PST)
Subject: Re: [PATCH v4 0/6] HPPA: i82596, PS/2 and graphics emulation
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191103205607.6590-1-svens@stackframe.org>
 <20191123135928.GA5553@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4848d948-063c-826a-a3f3-9bdbad04f9ac@linaro.org>
Date: Mon, 25 Nov 2019 10:01:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191123135928.GA5553@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/23/19 1:59 PM, Sven Schnelle wrote:
> On Sun, Nov 03, 2019 at 09:56:01PM +0100, Sven Schnelle wrote:
>> Hi,
>>
>> these series adds quite a lot to the HPPA emulation in QEMU:
>> i82596 emulation from Helge, PS/2 and Artist graphics emulation.
>> [..]
> 
> Ping? :-)

Version 1 missed the 4.2 cutoff by few days.
We'll get this merged for 5.0 once development opens.


r~

