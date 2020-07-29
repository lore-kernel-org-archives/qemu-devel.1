Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054DEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B3B207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LrLEDW1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B3B207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oP2-0007pf-NZ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0oLM-00062O-0j
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:50:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:49599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0oLI-0007Pr-RF
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596037801;
 bh=xd1A725CpeIyF5VxjfNzrOOrc+RW65SYe3vF5tvlyWc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=LrLEDW1X+dDAUji1L8qXgsHwSoE8YzgC1hBrjfU0oS4A1vADFBbs+NE8hj8d+zVJq
 CYxjBM8A9Rfq4jzdxjtZJ0tha65vOoPz4vLSWm2kIz2ceUE6l2AnBrFlvlPsDPzfpT
 YCNmT9dHVLp/xD6TtmSKamjclL9So2h3wROAYXpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.135.32]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1k2Bmo3JO3-001w5V; Wed, 29
 Jul 2020 17:50:01 +0200
Subject: Re: [PULL 0/4] target-hppa fixes
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200728193550.3578-1-deller@gmx.de>
 <CAFEAcA9ON0UpPmLBhL4gRnH9eJf0Wz8H26sK_kQaau3-8ZA1-A@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <6ec5ba98-6fb6-ee36-86d8-35ef6bcf2c00@gmx.de>
Date: Wed, 29 Jul 2020 17:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ON0UpPmLBhL4gRnH9eJf0Wz8H26sK_kQaau3-8ZA1-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tIhZCmmKlupQddohu/L+woq1V6wIQs156o64BcaJrZhqME/4JQo
 ktJRzken/N9+0+i8yr2Ax+56XWAvPLeQo2Uyu3OJNstrUzgdrNiqGdP81QkpNsRrKrsNpSR
 9plhmfPoikVgNX+BX35UJG9O5P5iP2BwwnJ1XGH59MB5tDB+t4FJ1w0K0EDkDjh/vC0Q+hI
 4RSNiN6m8OLgH9IozqjoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QLtLeN1Y++s=:Hv5i7Wxajmnu424w9LYJXg
 XgMykiraP59yG324rMe02qdZwfcvw9fLhFNsG/+RoBfhEvxRv6lLj/zfyF6XgW0yC2eeaJMlw
 gidMbgfmeFgLdmv2VJ3vGyNrS03hCJPYapNlnNY9KlaVqjwDYeasF7c5VLkEzebu8rWXyDYpt
 1zaK580DDWwseZFI/tOMOrLoIQmjSDvkwFF+MtptaH0jZ/ZhULNgdATJpEYPNFMRfKATM3yUK
 HYVLWGN7JDykzVCJiF1DWwwfMY4mx5IOHYT2M8E7rrcmWOxUKtNbbAiKu1cyTasPFxO32gRiF
 DZFa90Zfbtf12OMyG3iRcWG75Zi6PH6CpyKE7mHmtOzFfVl0MNLHlnGCER8D12WbZLMs+6xZf
 v2uOuW14EcxQAz5f1j/8cGAKzZ/XlQE0qhs4EvLfxxcGJNgfdVTpBIVeCpX+e4yxyCdsSympN
 wH5lUIb4Kv3gQ+95/656aTlFP0CHEINyyx9IHFlWmQPYPdOlJ8b+PfwDgkjNMRpfBwthU972O
 6ytU5goJ5BO7diw66rmDISH1NFdSgvWIgqVHu57mWIYtVMCDI+iDpl952m7LudPGZPCGrnbcC
 2yu5tf/h/dzAxqSAy0BFxbVlZrusVZFDiIxZRlA8qVThJlsUUMGC9J90eMa0Jm3VYVHN+MK4+
 o1bm2sOljTNJVDmplvTzJEZvmj/qleY4I6+zMBARbBExoXygIjAXD9tA8jYwlLLMMSJ/NTKKJ
 Xr1EdK0+hMDdrhloHaLdJLQ+IP6jwactivhawo1WBMJF8Voo5BBUuUEpMsKZeGHmnI8ewWoOC
 WnTqHeF4pXggZu3ccMbdBaM8PSvKvc2Mk8t17hWVtrBOK5o24WLcBx5bHmoe6KTjbNGDQIgWy
 QicHoKWSWWOW+WzXaqrEMHV8LgRpz7FLWR3h7g4eXFn4ncQDm4s66T06WI1AiNYhC4/2bbYVK
 fNNPSyNF/ynhTBcVgWBpNjlyx5jXhmKYSn+sTsXt8Qq7PPfDkKue7wjfDpw/83BkwRxF5xgNb
 b3UBZs85c5YDA6R6FD4CdITApNYky+2bPS6i66ti6CSFFKZg/wG/SB11ywNz7R/vmoUrcgVLj
 3zDs8619nETZvls8+qXkwKyeCstaj+dIroB6igF88++J439k+dTEE9+arpHakr6s+CFSZHeOF
 0kFf7M8wynH4W1IRwo5p/YXV1YLONwzmLyRVW2AcX1ekEBEytwlJDwUf1X/G7VXRspnBO7Xni
 o2KotLJSVl5r8UxrU
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 11:50:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29.07.20 17:06, Peter Maydell wrote:
> On Tue, 28 Jul 2020 at 20:35, Helge Deller <deller@gmx.de> wrote:
>>
>> Please pull to fix those two bugs in target-hppa:
>>
>> * Fix the SeaBIOS-hppa firmware build with gcc-10 on Debian
>>
>> * Fix the following runtime warning with artist framebuffer:
>>   "write outside bounds: wants 1256x1023, max size 1280x1024"
>>
>> in addition the SeaBIOS-hppa firmware now includes a version check to p=
revent
>> starting when it's incompatible to the emulated qemu hardware.
>
> Hi. I'd rather not take a pull request from somebody who's
> never submitted one before at rc2 with four patches none
> of which have been reviewed, I'm afraid.

Sure, your reluctance is understood.

> Richard, you're listed in MAINTAINERS for most of these
> files, would you mind giving them a look over?

If Richard gives his Ok, it would be really nice if you could
apply those.

Thanks!
Helge

