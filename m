Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F12C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7175D206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="F29GGMvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7175D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxMm-0008Sp-Ia
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jIxKO-0005PB-Av
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jIxKM-0001CV-AR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:31:55 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jIxKL-0000th-8X
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585585854; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:To:CC:From:Message-ID;
 bh=TlasSoKUoqSWYZFLw6ma8/n8Bg3fgJBCcdj3cEqlk68=;
 b=F29GGMvyILlwTv6ReCy6J+bHoDJqDldTyD6iRcGjaL/+dqOKayrTVHDUex/ZGjNV
 /8SsaYD3yA/7Q3p9eWt6gxlvGIe0vdxvEV5elI+kU1DXrKBCXSvQmlPaSoS+TBDv4ez
 3jqYB+CmDrTuiya1ubGoSLTQknqWTI7Pz7/od+9Q=
Received: from [10.233.233.252] (183.156.33.130 [183.156.33.130]) by
 mx.zoho.com.cn with SMTPS id 1585585851933120.86645972402823;
 Tue, 31 Mar 2020 00:30:51 +0800 (CST)
Date: Tue, 31 Mar 2020 00:30:48 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <bbf10da2-76ee-a4c6-275d-fa1c8fc59e1e@redhat.com>
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
 <39c28108-5d85-d611-c2ea-abbbf913b981@redhat.com>
 <1B369970-E78B-4A05-A80E-D7AB527E3A4E@flygoat.com>
 <bbf10da2-76ee-a4c6-275d-fa1c8fc59e1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH for-5.0,
 v1] target/mips: Fix loongson multimedia condition instructions
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <80698310-CBFC-4D65-826D-3F7AA038B126@flygoat.com>
X-ZohoCNMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 124.251.121.243
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
Cc: Huacai Chen <chenhc@lemote.com>, aleksandar.qemu.devel@gmail.com,
 richard.henderson@linaro.org, aleksandar.rikalo@rt-rk.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



=E4=BA=8E 2020=E5=B9=B43=E6=9C=8831=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=881=
2:22:43, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat=2Ecom> =E5=86=99=E5=
=88=B0:
>On 3/30/20 6:18 PM, Jiaxun Yang wrote:
>>=20
>>=20
>> =E4=BA=8E 2020=E5=B9=B43=E6=9C=8830=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=8811:39:44, "Philippe Mathieu-Daud=C3=A9"
><philmd@redhat=2Ecom> =E5=86=99=E5=88=B0:
>>> Hi Jiaxun Yang,
>>>
>>> On 3/24/20 1:22 PM, Jiaxun Yang wrote:
>>>> Loongson multimedia condition instructions were previously
>>> implemented as
>>>> write 0 to rd due to lack of documentation=2E So I just confirmed
>with
>>> Loongson
>>>> about their encoding and implemented them correctly=2E
>>>
>>> If you have a binary using loongson multimedia instructions, can you
>>> add
>>> a test? So this code won't bitrot=2E
>>=20
>> I know ffmpeg uses it=2E
>> But I think that's too fat=2E
>
>Looks perfect to me!
>
>It'll be simpler if you use a pre-build binary from a known
>distribution=2E

Unfortunately none of the distribution built ffmpeg with loongson insns en=
abled,
as it can't be enabled at runtime=2E

I'll try that after fulfill Loongson Extensions in  QEMU=2E

FFmpeg do use some other Loongson insns despite mmi=2E=20

There are still 15+ instructions for me to work=2E

Thanks
--=20
Jiaxun Yang

