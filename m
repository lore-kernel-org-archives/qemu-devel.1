Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B753206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsHQIZ3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B753206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1Tp-0001QZ-MZ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg1T6-0000tj-U9; Tue, 02 Jun 2020 03:36:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:55821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg1T6-0008Jy-8d; Tue, 02 Jun 2020 03:36:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id c71so1853358wmd.5;
 Tue, 02 Jun 2020 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F2QsZkTt1N5ijbRF1JaCETx/9YucFppH8OAzVaNsDLg=;
 b=jsHQIZ3IRLuVs5niBu8YMvt/WXa+wyJ7DvYtDFIFqszfFXE90PuMoicqdJ8epHb1yf
 aUrFPS7dv7jEVDUaFzo5yIZ1QZjf3Y4/xG5Oh5rxnepbmfknbevUD8UcZYv7ISGTtHQg
 2XKvbPR366nDtNbEMau+iB8+jmK61Q5Q6A+oPb/TAYvGIL0E0GpfBiqwL/4Y0rv39kqq
 n/95U8bftYhqtLs3d3USyqi52cqaRf0F0/4nHQF04o/KfyR+2srcd2h7X35GlXoa641P
 jESavlECTfTRqESTvMG8gMZU9k12v3qTPFs9L9Ve9qEnjKVthc/ESY3f+ncD0JeApeS/
 C+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F2QsZkTt1N5ijbRF1JaCETx/9YucFppH8OAzVaNsDLg=;
 b=SSxCDJfomnJc10+Fj4/nu/cspjkzwH5JWiOCfO2l7Kn5To0qTfhnSG9QhMR0Y/Gv16
 WCG3GJPVvdDb4jGxB6MZw7ecIVsrHlbEXcvp6vKG0Mp7FFjZbWV1NIyqZ/xJhNeMVAGr
 F1806ctQJB3kGM0r3M6iCE0GQ2okUUaXpWcocXhPk6dABkirA3pI65xetS4pn3Ie6tus
 QmrUZU1oFNR3xJbK+73ek9DDT1m29sVOfQcBfLv/8BHmdYfcyn87IXIiH4PnxiDsNzjG
 f8OO2ikCgzRSPXno4XlJxH2txGTFEP0M8VX6E7MIE9HCF0nq3pDbWaIWBgQKkQsGQaKk
 9R4w==
X-Gm-Message-State: AOAM5315KJIzM8ku4srWsjItgH4r9TFymuTNoRCxWAkKrszWpkN8XYFI
 JjO/TfO5FfW5QAVoWVeXz3n1WDvb
X-Google-Smtp-Source: ABdhPJyPPybHO12mzSUp43OQumUOf32rQib4sSMlLiWXA+sjS9x60ntsfgW+UMxlp90/RkoziygxZg==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr3085358wmi.133.1591083373434; 
 Tue, 02 Jun 2020 00:36:13 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b187sm2299385wmd.26.2020.06.02.00.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 00:36:12 -0700 (PDT)
Subject: Re: Sam460Ex screen mode, audio and network
To: =?UTF-8?Q?Andrea_Palmat=c3=a8?= <andrea.palmate@gmail.com>,
 qemu-discuss@nongnu.org, qemu-devel <qemu-devel@nongnu.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc <qemu-ppc@nongnu.org>
References: <CAD+yzTSr2edTNmzkGOH7todx7uVPbL_BSNSJPb62mJWCUSa8NA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4d64c939-3431-b637-488e-676a5f9171e5@amsat.org>
Date: Tue, 2 Jun 2020 09:36:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAD+yzTSr2edTNmzkGOH7todx7uVPbL_BSNSJPb62mJWCUSa8NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the sam460ex maintainer.

On 6/1/20 8:01 PM, Andrea Palmatè wrote:
> Hello, i've successfully configured AmigaOS4 on Qemu 5 and i've
> installed it without any problem.
> It is working on an i5 laptop. I've tried to use the native screen mode
> 1366x768 but it has some problems. It seems a stride problem and so is
> not usable
> Also the audio over sm502 is not working. (is it implemented?)
> And also. OS4 has a support for RTL8139 but it seems not supported by
> sam460ex. Is there a way to (try to) add it via source code in any way?
> 
> -- 
> Saluti,
> Andrea Palmatè


