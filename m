Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4ACC43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A39206F2
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="PZ+h8pxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A39206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jILUB-0000D3-LN
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 20:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jILTF-0008BY-TU
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jILTE-0002oZ-M0
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:06:33 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jILTD-0002k4-UL
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585440341; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:To:CC:From:Message-ID;
 bh=bAszulfYwOvscdzDU+DRZvyWS+oCDnu8Ezi+iHucMG4=;
 b=PZ+h8pxx3JbDpTXod9P55r4vGkM7mDXnivUFumnwG5skeGZd35WDKkYAR1Zm8SZl
 0ii6IkUi8IATCYf2wsg+WpOH3KcKuPWvIcobJr4iwdmo+nWZGG1kvlGQfYPAvfWQrjT
 G4bEA+qxzWEqSp4KV9pob5YAV2nmWLfXEs3xPGJc=
Received: from [10.233.233.252] (115.193.86.228 [115.193.86.228]) by
 mx.zoho.com.cn with SMTPS id 1585440339738319.4768004307472;
 Sun, 29 Mar 2020 08:05:39 +0800 (CST)
Date: Sun, 29 Mar 2020 08:05:37 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <9b0dbaa9-a4de-fa91-9455-c6fcdeb29116@linaro.org>
References: <20200328090853.645433-1-jiaxun.yang@flygoat.com>
 <9b0dbaa9-a4de-fa91-9455-c6fcdeb29116@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] target/mips: Add MAC2008 support
To: Richard Henderson <richard.henderson@linaro.org>,qemu-devel@nongnu.org
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <10F08C52-C2DA-441A-97F9-2266C736D0DF@flygoat.com>
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



=E4=BA=8E 2020=E5=B9=B43=E6=9C=8829=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=883=
:09:16, Richard Henderson <richard=2Ehenderson@linaro=2Eorg> =E5=86=99=E5=
=88=B0:
>On 3/28/20 2:08 AM, Jiaxun Yang wrote:
>> -            gen_helper_float_madd_s(fp2, cpu_env, fp0, fp1, fp2);
>> +            if (ctx->mac2008) {
>> +                gen_helper_float_madd_s(fp2, cpu_env, fp0, fp1,
>fp2);
>> +            } else {
>> +                gen_helper_float_maddf_s(fp2, cpu_env, fp0, fp1,
>fp2);
>> +            }
>> =20
>
>Surely this test is backward, that mac2008 invokes maddf=2E

 Sorry for my stupid fault=2E
Will fix in v2=2E

>
>
>r~

--=20
Jiaxun Yang

