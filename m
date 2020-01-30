Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA476C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A1820707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLJ4gsdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A1820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34695 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCMY-0007oO-V4
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixCLs-0007Jm-No
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixCLr-0004Dd-PL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:07:32 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixCLp-0004A3-Io; Thu, 30 Jan 2020 11:07:29 -0500
Received: by mail-ot1-x341.google.com with SMTP id d3so3623895otp.4;
 Thu, 30 Jan 2020 08:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xBN7PIzyeHnGPL5tma5LigU0G0NWwhRpQFRrF43m3/0=;
 b=eLJ4gsdqAVPun4HA9Y7RmPX82TbUGPl+0Ftp41Fv1tOeuGI7Y7k0EJJiCYx+XvA1jX
 sGDscMfX9LnHmoxGDr02zbWgbNrfhhYHTXZPG3W4vk1i8nvRN8KH69lAkJW3Yj+y4raO
 2HbzjtqakVI44PDwxSQFRl7XeZGQJaKCWZSlBaQd3TLdQWNOFqqtCpgRqtlJKd/cV9QR
 kz4FODTok0Hxqqi9n7FTUOK/nb1LK8k65WCb95Z0Xrlm04nU0GTgodYlE1meug3jM9lo
 TPr7zYCXTxwQ4nGUZm1GPaHCtZhxThY4s3Sn3iiqQgzR3/vWlVSjO9rfgYymZRnzfMiE
 c0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xBN7PIzyeHnGPL5tma5LigU0G0NWwhRpQFRrF43m3/0=;
 b=LlHum0Ee5JxE+IBEmjmPTHz6/UOm9oKnWZvT8g0ohRD/4HFb5NEkJGssEuCZmimP/b
 e3xu2mzswfb/LHnrfOaUF7Eu2uLVDNYQC1yqZl4qff8EKFFLDJE40ZjJB5JqElAxmrA5
 HpRkeK9DbiqNZz3YZ178WIE5a81LpJVR+GzjSry+nzwLEWdFlsfpFDxd+kPDu0V8hVD8
 CfT6aVvjgnSHMfiblhhwgi9puJFQ5AgHbpsXIhenSSiURyGD3SKO15yerQnLO6QdPMl0
 hDL+nI5RRF0fn/g8n3N0QE27bisLA6HQIugeo/P1RAy8PFs6VBr9tpGeE89Q5DVmvkYm
 ThjA==
X-Gm-Message-State: APjAAAXcdIB2/G9wmXHnha/yZKiMLXHHFYQIM9tcPvSD0zZB83nZTjuh
 hYtfkmT/YVC0/zpI+arOW6anGC2pfIXD8BtHvNM=
X-Google-Smtp-Source: APXvYqxbNycrarCup0BW8PnAoYPyvt0Arzy2d5e7LV2YrgMZLCrukeiWAvYssBaxejmRChQ/kWbASPkzxa1ehlU6NI0=
X-Received: by 2002:a9d:6505:: with SMTP id i5mr3868404otl.121.1580400448691; 
 Thu, 30 Jan 2020 08:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20200129235040.24022-1-richard.henderson@linaro.org>
 <CABLmASHGOGsDYo-jmqs2XCTvGbw80x1OAghx1AVTCOz2WMFKxw@mail.gmail.com>
In-Reply-To: <CABLmASHGOGsDYo-jmqs2XCTvGbw80x1OAghx1AVTCOz2WMFKxw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 30 Jan 2020 17:07:17 +0100
Message-ID: <CAL1e-=iG_s-hcAChaoKa8BF7e4EZ6eQR=QgUwOAAPQmEJBbu7Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/ppc: Use probe_access
To: Howard Spoelstra <hsp.cat7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 4:09 PM Howard Spoelstra <hsp.cat7@gmail.com> wrote:
>
> As this patch set solved the performance issue and even led to the highest scores I ever saw on the benchmark tool I used, let me add a:
>

This makes my question to Richard more important:

Are other targets exposed to performance degradation, and why?

> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
>
> On Thu, Jan 30, 2020 at 12:50 AM Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>> The first two address the performance regression noticed
>> by Howard Spoelstra.  The last two are just something I
>> noticed at the same time.
>>
>>
>> r~
>>
>>
>> Richard Henderson (4):
>>   target/ppc: Use probe_access for LSW, STSW
>>   target/ppc: Use probe_access for LMW, STMW
>>   target/ppc: Remove redundant mask in DCBZ
>>   target/ppc: Use probe_write for DCBZ
>>
>>  target/ppc/mem_helper.c | 197 +++++++++++++++++++++++++++++++++-------
>>  1 file changed, 162 insertions(+), 35 deletions(-)
>>
>> --
>> 2.20.1
>>

