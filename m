Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F521C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A05E22317
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YLM5uOVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A05E22317
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9pO-0001FZ-7p
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 15:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iX9lg-0008Kw-A8
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iX9ld-00004s-PZ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:06:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:39229)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iX9lc-0008Ud-BI
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574193973;
 bh=8XGZOBqltpFe0P9ioJI1us8UpkFpuwy+FNLeh4tqiI0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=YLM5uOVWYwkCBLkxHPP6azYqWT+QFBBQmAqLop4nY3hZqnqV80apisyImhIs9y3yq
 MsYJKI+TzdEnN14mgBKK01vgBIk24zf/jXw5MWX/hw1smzbQVC/cTFKowiEfNPE8V4
 nZY2uyIZCqt7o+XL4UW+E+AVMsgFmjKoOYGC3N30=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.148.64]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1hdPsO22er-00yxLI; Tue, 19
 Nov 2019 21:06:13 +0100
Subject: Re: [PATCH] linux-user/strace: Add missing signal strings
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191119185153.GA23003@ls3530.fritz.box>
 <48097cb5-bc47-e532-fcde-67ca65a2039e@linaro.org>
From: Helge Deller <deller@gmx.de>
Message-ID: <06aaa584-fc97-8097-ca52-00d97982e5be@gmx.de>
Date: Tue, 19 Nov 2019 21:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <48097cb5-bc47-e532-fcde-67ca65a2039e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P3yVlDMbsqy8rQ9a+eqfb2VDSwmu4VEl4a6HjBk+D42P2mOFk0V
 ROefWNlEAJkAaga+J1TTE208RIcrSqzBHJXQigV77H7XoEjICp8+WRLpD8pAFmkx1o8TT6Y
 ke4sbalP2MJ01ne4EIQz6cKWWm4rhsrqIFbvAUxy7yhHf1/qBDkBMOdroJPhNlZubWkvJbu
 O3l1x4jtEYCfkTayqF7PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tCT8VpZw9FM=:BKJCzy3aEse9AbdHVAR9Or
 DutrdsMR3HkC1m5OwZqj+1MZBQ0y1TvbXsVobPts4j/oUEWTlKF7Aq/1jMaGc3hS4D4twjPht
 MyRiaqCn9I2DSWvgdwsRxaKd2IZTyv5F6SB7gZoyTGlL+n6Xnt8i4LBiQEYfLP2sfVyS9s4tz
 MKvXSWQH8sLMvB0zqAPAwS1jK506A8/6ujfULiEGf3QdQ4UW81qJNxYI9OixTloM8ZgHKswyg
 H2eBRPwN+nH7JcgxtBHbt2fQjekhRAVZx4zogAKyef8Tk8b39BA539icU3dCm7kg+AmRHC/Li
 8AI3q5Z2Hs0HTmf8tMnQq6cAJHoiG/7VmPj51lhybF3t446xp0yIPKNcv5qGUK81gB7QRdyBS
 K8aQyfIdPbKcNwYrwy6lydZyzXQql0kidasOc3epCKfTCJ3ok3h+4H+cQTDjtn9g0XH2L40Y4
 VBYAyLIgauaaOjGNw8b9Nlr672SctemddlROhDZJTCDCmN9fsQkXmXtcrr7VHOhRvw3jdk9C1
 +96yp6oT9Xu33CTPa+FZX3tY45PCOLiHsq3VeZOz+EbFZ0IcpvRWqOF6b/W3p0s6wFkLcMmNy
 MdYLqv+ZmGT523ma/8wuWtOqRtG7dWgzO6kSVxZ6vSj6vAebsuZPDLQmsCjaKYLhfuWYzZMXt
 0v/CEfM2/bm8CnOk7qOj/gW82RwosECT+pk39XLqVZjo7ZbauhXQCntsKMNXC1iuOnPFWzc3f
 fNCk7moWwuRZ9wofxGOOvN5tCCAKGFSyacon8foOs9cKsm9ySpf7hrpLMCyleKG8CFGV/0AlB
 WGY0RTpHFHk/wcmdiH02hk6BrdvmUzNCTJou0ezO71sGWuW+VVdHB7W23FPLvl7FuJm5mNlxR
 OIN9f9MQfqnPUdMxIlXHpjz6knGlsNlD4bWtw+rphmjbzMdejyaeziLDuc55AS/xR/q5hMIKd
 MFNuk/Xf+W8nwD0Q7a65N4ijUzif+11jxzCKzslelkM6brz2X69IGs9FmpXisFkBnOWs7aY/2
 t2kavJvVWxdNmVyaF8W712oX/Rg36WH2hRhO0XPh6K13Ytl0sZGmQsNiM15LZi3EUMq/2ehRl
 pCFpG4D41t4godpcgJZBlar/7mvXJmQjC/Rj2BgPelPqsvDbzJNchvuO89Y2Pcln1stuy3WZp
 AYXupdFU+twXLjJfCVFCwocKjtV2KNxrfhCNQ8lcTZ+g02EOc0HCiZKnTHrmL3ypCfOWgOiy5
 2nQLfR4IDCj/RKn8wRCpHqNKC0O01SEOue6ZBtYH1WGTAmyKC268Qaic6uPQPEEN0tmdGooPm
 FGkHCXaLRd2bhZBpok0UKPB37+znrY3jSMouHHm8xpSZEqCl1zs91VUS+gHXSdd7mgIeFRkWr
 1nYtgmeiItA49dHCCcDV2KKpINSLbKaIj7XUi+jLx4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.21
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.11.19 20:56, Richard Henderson wrote:
> On 11/19/19 7:51 PM, Helge Deller wrote:
>> Add the textual representations of some missing target signals.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index 3d4d684450..18b57a9ef9 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -146,6 +146,22 @@ print_signal(abi_ulong arg, int last)
>>       case TARGET_SIGSTOP: signal_name =3D "SIGSTOP"; break;
>>       case TARGET_SIGTTIN: signal_name =3D "SIGTTIN"; break;
>>       case TARGET_SIGTTOU: signal_name =3D "SIGTTOU"; break;
>> +    case TARGET_SIGIO: signal_name =3D "SIGIO"; break;
>> +    case TARGET_SIGTRAP: signal_name =3D "SIGTRAP"; break;
>> +    /* case TARGET_SIGIOT: signal_name =3D "SIGIOT"; break; */
>
> Unused commented code.

True, but I kept it intentionally the same as it's currently in
linux-user/signal.c (line 40) so it's not forgotten if that changes:
/*    [SIGIOT] =3D TARGET_SIGIOT,*/

>> +#ifdef SIGSTKFLT
>> +    case TARGET_SIGSTKFLT: signal_name =3D "SIGSTKFLT"; break;
>> +#endif
>
> Wrong ifdef.

Same here, see in linux-user/signal.c (line 50):
#ifdef SIGSTKFLT
     [SIGSTKFLT] =3D TARGET_SIGSTKFLT,
#endif

Suggestions?

Helge

