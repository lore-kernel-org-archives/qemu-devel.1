Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2AAC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963D021D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdp7Lyxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963D021D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0GH-0005xi-Pa
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iT0FW-0005Qt-0b
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iT0FU-00015R-90
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:08:09 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iT0FU-00014r-0E
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:08:08 -0500
Received: by mail-wr1-x42e.google.com with SMTP id b3so6070356wrs.13
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 01:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mg87IWB3WV8NUWV7kbGyhOM3Alh9ahvDKWJFxeXK0Yk=;
 b=pdp7LyxvDp2aqjSCg5OVHioJQ//m6izX4u29Er1NssZ9EWxFvorYuqTs7GzNJJAgfV
 sBlOEqKp/xI7g48YJ6fgrqm034y/EBrNchdH/ZEae3We+xDpDw6RTucmFl7MMBvs2LLc
 N2IgW8ZRNtntpUMefuwc6d6IgCY8JrFavolDdujiywXlrENXD1Vciec5qTn77opQaVZ/
 puV/zKf8B6BYrusNoiN0XL6YaqYfh8IscYYJEUGlLT6+jLG6qDvEHtfcXSBND44J4n8q
 iJDvemLBp3Ww0lOiAckkqCE379qkVnLgidkeLV9F7FN9A5yt+QOQpEDN3AKL43xMl5zz
 4e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mg87IWB3WV8NUWV7kbGyhOM3Alh9ahvDKWJFxeXK0Yk=;
 b=II9LhL9731k/b+bb5iEw1Q24xBnsbzOgiEjg4GMe01FtVVpeyNrM4BHc60vpp5K3R9
 9ExcnGP8I1bs+r1y9AMeoMwuqs0+eagHtS6kB6P0YNQ9GyU79TaqH6iB99dMP0Tem04X
 1dB6eDKEomJdhWX1vRkML2KmOW+9ypN48KW5Bnc67KnLD1FLaaw+Y1OjsWh++J+S07XI
 qcvtkj5YEkDKvV4J7eGrr0gDIAqlckUzun5EqMme5knOyFvILIgbEGe58zJp4KtBoBsl
 qdzF5v0GzUPrIHXPnJw/ZMHrYhcQdyrwjx6BcwHDuL+6CAgILqvPFJ8u4CaMD2MWN7X9
 IQFw==
X-Gm-Message-State: APjAAAWjscTnNn8ccczHKRQpmeyy1SadfREg3mqC7nFwuxS5h7GlgXkv
 rjtu4637RYxEGv4soTHKSPRehw==
X-Google-Smtp-Source: APXvYqysO26gKDPWobbnoXu9kIFIxi90jXNua6DfWhLFrqqdZLaRW788oT9ZagIgaPKmOirvYpzjAQ==
X-Received: by 2002:adf:e74c:: with SMTP id c12mr7164418wrn.133.1573204086631; 
 Fri, 08 Nov 2019 01:08:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a206sm5214914wmf.15.2019.11.08.01.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 01:08:05 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C90251FF87;
 Fri,  8 Nov 2019 09:08:04 +0000 (GMT)
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: Looking for issues/features for my first contribution
In-reply-to: <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
Date: Fri, 08 Nov 2019 09:08:04 +0000
Message-ID: <87a796hh1n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Rajath Shashidhara <rajaths@cs.utexas.edu> writes:

> On 07-11-2019 07:33, Aleksandar Markovic wrote:
>> I did a quick Google search on datasheets of existing RTC
>> implemtations, and the result is:
>> DS1338:
>> https://datasheets.maximintegrated.com/en/ds/DS1338-DS1338Z.pdf
>> M41T80: https://www.st.com/resource/en/datasheet/m41t80.pdf
>> M48T59: http://www.elektronikjk.pl/elementy_czynne/IC/M48T59V.pdf
>> MC146818: https://www.nxp.com/docs/en/data-sheet/MC146818.pdf
>> PL031: http://infocenter.arm.com/help/topic/com.arm.doc.ddi0224c/real_ti=
me_clock_pl031_r1p3_technical_reference_manual_DDI0224C.pdf
>> TWL92230: https://datasheet.octopart.com/TWL92230C-Texas-Instruments-dat=
asheet-150321.pdf
>> Zynq RTC: https://www.xilinx.com/support/documentation/user_guides/ug108=
5-zynq-ultrascale-trm.pdf
>> (chapter 7)
>
> I have a few questions about this:
> [a] Is there any particular reason that you picked DS3231 ? Linux
> kernel has drivers for DS3232/34 only [1]. I did read the datasheets
> of both 3232 & 3231 and found that they are quite similar except for
> the 236 bytes of SRAM support found only in 3232.
>
> [b] As per the datasheet, DS3231 has a built-in temperature sensor.
> Temperature can be read from a dedicated register. There can be two
> approaches to emulating this: (1) Return a constant temperature value
> on every read (2) Throw a not-supported exception/warning. What is the
> qemu convention for handling such features ?

Don't throw an exception. You can at the minimum do a
qemu_log_mask(LOG_UNIMP) to indicate the system is using currently
unimplemented functionality. Alternatively wire-up a device property via
QOM so the user can vary the reported temperature.

QEMU currently doesn't have a decent API for exposing values for dynamic
emulated sensors to the outside world aside from QMP for chaning device
values. It's something we have discussed in the past but the trick is
coming up with something that can cover the wide range of device types.
Maybe QMP is good enough?

>
> [c] DS3231 also has programmable square-wave output + 32 KHz output
> pin. M41T80 chip also supports this feature. However, qemu does not
> support emulation of these features [2]. Do I take the same approach ?
>
> Thanks!
> Rajath Shashidhara
>
> References:
> [1]
> https://elixir.bootlin.com/linux/v5.4-rc6/source/drivers/rtc/rtc-ds3232.c
> [2]
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/rtc/m41t80.c;h=3D914ec=
ac8f4db418633d6daf92608cb50f6b89052;hb=3DHEAD


--
Alex Benn=C3=A9e

