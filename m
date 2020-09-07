Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5669C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0413620C09
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d67tV0bL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0413620C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFMcp-0003h9-Da
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kFMZc-0002zN-RT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:13:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:48827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kFMZa-00026y-IQ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599505973;
 bh=ACYZj33YkzrrF1OAupC5iGYWKQNI5OAVE75kLLR7XXU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=d67tV0bLY+UrgyR0+i/XPk4e2GZLbBYxf1w//RfQ9W56WQQ6yOLDYA8ClJDfhbhrg
 KOL8KuTgCrWj8s/8WxMo4bPaLKXpZumkPLzLSx+muhebx2LzZVVW1bmjZFT3k8oY90
 pF5SAPGkkivNCbc1KiN+BWcGovzs9ioaUtqRch1I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.118]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1kthec2xep-00qgRn; Mon, 07
 Sep 2020 21:12:53 +0200
Subject: Re: [PULL 00/10] hppa power button support, graphics updates and
 firmware fixes
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200903160746.27491-1-deller@gmx.de>
 <CAFEAcA_9Dkj8dJAxLdhtN_6Xw+ThX0J-s0LkG1J2mnJdd+NLWA@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <c27d1e75-49cf-37a1-b46b-60a35909dc4b@gmx.de>
Date: Mon, 7 Sep 2020 21:12:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9Dkj8dJAxLdhtN_6Xw+ThX0J-s0LkG1J2mnJdd+NLWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q91PeVt+NnsyoUTZEhJMDh9QMcHjN40KKF6XgmAzz6bh7lgplvO
 obtfi7yJhxnGDnhN2D/rGH8b1vly0BKkgSuu/j3nJOHPtu6pJJAYpDQ3jwmOYXW1w+Mnwr9
 zIz0i2H50QXN7Zsbu4xusybQtQiWo6JyePu+uofBPaczgHZN0CwyKpoHNTFrnonGDRf+Zy1
 pzqNFiUxqzhZpp81oQNfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0raPPYIp3dY=:GHaSiAbj38TufoDZw8Ieas
 k4PwWVrOG+3w5cS0XCodlbm+CzRlALmIdl+FoqJE8RoM+djCC+76g3lJiwxct6rdZJnSuAdR4
 beTQ3G5sdjtvxgtPT2hPjeIN0ADigYmtse93KG+zoaJuk/tdXZAw9Onq1dSGec+57Ir8pwQSz
 94MTxguwctmgWnXL4tXcD9w/+AepADTxXCsrabf9plQsVooSSiArgNV0E9GKrxLUlevH5zoOj
 XQ/qiVjvLfSwoIo/BtS4x83sTz5Fk0DJlRbMiKK9mHVMj765pchu8c6NIlMo9+5wcI8mAxJzB
 JOc9AzHu+7Pbyt0nn6BhYYEgQN7KZrDz4I31qZgm1YRqcxU3hZZEmwgIqllywnuuCBiDkVFeS
 n97uOK7zUjIOrv0MlqgfaLRI3bP3LttVu1BkjsQBBJK+LevjeHZdw3KInlC7B3Blb2Nq4gb1V
 athDCeAkSKQOVqYd/RPf/4k/F3o8G1JqojWVUzUnpQ4jcRrBNmIIaxvl/NvF5iNKmnZC9iy+a
 FewMo82ikvfgMOmg8cOHLfLqCl6xra8EGxxonDFGBMw6/CMW6Z3AjbRWiZpuuGZ0olM3e9LHS
 APn8zWDCwZeMSI5ZuUP7VSDbrwnSoWyhxL6U/48nOCzx52Nj1otzGVAL/fGDRNEi+dYfN+IcU
 TOLFo1jQ6Pn9bK0S1N66ATUBaQCY60BP3BY2NRlpRy0rdhd3jRdpdrc7vdaJ7nPu2eBJRuD42
 h0sLyA2luPExjgqjkxDm9Ty0pGmkJo0wnxOzUQ9C8bX+rMPSD93C5HI9JU5gN3SHjsZRzLpn1
 ZEi2NEf21jXmCx/fE7B8wUyxlk88ler3IYYmICmVuLfUq4FRxCWXRf8Hh9Wp/8Smy8xWRVJ2c
 uHh0MO0d0Ax/96MZtnDxbzV8ysviOB2uLpDPZPIA7ooRZo2jat1XzgWyFuAp5z7QSgmlDFpjT
 5X9FLsMnIJr4com0sir2HRyBV8N8RokCUaMb2locUB0u3Lh/raz7F+zDvtApdXEAK+qQfPqia
 Ui9mQeAOdVcHV3RHgEFJpwauxsINWDNSEUykD5f0DkOXfH+ttasDE2/25Q/DJCaOWLxcxqJNt
 l9MvyehZZoPSqrEl3GuEa29W01XNq25qlJqUGsRmPmv3oUFvsTgehsdJcmNfDcEaC/OSgvlmd
 JpDxIa/bBs/nX4zAJeCmAsY8fLPZpQMPXOoU72j8R/wRtli29mjxuSbK7hZjv+BnfDuZKKhyl
 zEdoeN0353rVoeOwK
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 15:12:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, NICE_REPLY_A=-1.825,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 07.09.20 20:29, Peter Maydell wrote:
> On Thu, 3 Sep 2020 at 17:07, Helge Deller <deller@gmx.de> wrote:
>>
>> hppa power button support, graphics updates and firmware fixes
>>
>> The following changes since commit ac8b279f13865d1a4f1958d3bf34240c1c3a=
f90d:
>>
>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200827' int=
o staging (2020-08-27 13:48:12 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/hdeller/qemu-hppa.git tags/target-hppa-pull-reque=
st
>
> Hi; this is a git tag, but it is not a signed tag; we only
> take merges with signed tags.

Sorry, I missed that.
Fixed it up and signed it now.
Can you retry?

Thanks!
Helge

