Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B2CC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B569206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="BoFtf3tX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B569206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxAj-0001uE-Mk
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jIx9o-0000wx-3r
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jIx9l-0006Xa-H5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:20:59 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jIx9j-0006AN-Pa
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585585123; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:To:CC:From:Message-ID;
 bh=NrPlIDA19h9Nln8bk9yxmkBDOzQK3Y2SsHhr904ZkCY=;
 b=BoFtf3tXkc6DVSKn4H2blf64X6bL/scnIizqXkmBL6grFSAMyuOFCaYqHzPtlXTV
 /7J8+S35DiBtnbZ7em4MqbQPBcSM/xqtl1zKbPp4GxMoIsedvgOp/dg9DYqyumTYjzi
 vo3ZWezKc9CpjlDQnnoRD0oLb4uIbpWM53APDW5E=
Received: from [10.233.233.252] (183.156.33.130 [183.156.33.130]) by
 mx.zoho.com.cn with SMTPS id 1585585121863731.322921744283;
 Tue, 31 Mar 2020 00:18:41 +0800 (CST)
Date: Tue, 31 Mar 2020 00:18:34 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <39c28108-5d85-d611-c2ea-abbbf913b981@redhat.com>
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
 <39c28108-5d85-d611-c2ea-abbbf913b981@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH for-5.0,
 v1] target/mips: Fix loongson multimedia condition instructions
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <1B369970-E78B-4A05-A80E-D7AB527E3A4E@flygoat.com>
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



=E4=BA=8E 2020=E5=B9=B43=E6=9C=8830=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=881=
1:39:44, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat=2Ecom> =E5=86=99=E5=
=88=B0:
>Hi Jiaxun Yang,
>
>On 3/24/20 1:22 PM, Jiaxun Yang wrote:
>> Loongson multimedia condition instructions were previously
>implemented as
>> write 0 to rd due to lack of documentation=2E So I just confirmed with
>Loongson
>> about their encoding and implemented them correctly=2E
>
>If you have a binary using loongson multimedia instructions, can you
>add=20
>a test? So this code won't bitrot=2E

I know ffmpeg uses it=2E
But I think that's too fat=2E

>
>I'm in particular interested by a test covering the MAC2008=20
>instructions=2E You can look at examples in the tests/tcg/mips/
>directory,=20
>Aleksandar added a lot of tests there=2E

I'm going to try that=2E

Thanks=2E

>
>Thanks,
>
>Phil=2E
>
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>> Acked-by: Huacai Chen <chenhc@lemote=2Ecom>
>> ---
>> v1: Use deposit opreations according to Richard's suggestion=2E
>> ---
>>   target/mips/translate=2Ec | 35 +++++++++++++++++++++++++++++++----
>>   1 file changed, 31 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/target/mips/translate=2Ec b/target/mips/translate=2Ec
>> index d745bd2803=2E=2E25b595a17d 100644
>> --- a/target/mips/translate=2Ec
>> +++ b/target/mips/translate=2Ec
>> @@ -5529,6 +5529,7 @@ static void
>gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>>   {
>>       uint32_t opc, shift_max;
>>       TCGv_i64 t0, t1;
>> +    TCGCond cond;
>>  =20
>>       opc =3D MASK_LMI(ctx->opcode);
>>       switch (opc) {
>> @@ -5862,14 +5863,39 @@ static void
>gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>>  =20
>>       case OPC_SEQU_CP2:
>>       case OPC_SEQ_CP2:
>> +        cond =3D TCG_COND_EQ;
>> +        goto do_cc_cond;
>> +        break;
>>       case OPC_SLTU_CP2:
>> +        cond =3D TCG_COND_LTU;
>> +        goto do_cc_cond;
>> +        break;
>>       case OPC_SLT_CP2:
>> +        cond =3D TCG_COND_LT;
>> +        goto do_cc_cond;
>> +        break;
>>       case OPC_SLEU_CP2:
>> +        cond =3D TCG_COND_LEU;
>> +        goto do_cc_cond;
>> +        break;
>>       case OPC_SLE_CP2:
>> -        /*
>> -         * ??? Document is unclear: Set FCC[CC]=2E  Does that mean the
>> -         * FD field is the CC field?
>> -         */
>> +        cond =3D TCG_COND_LE;
>> +    do_cc_cond:
>> +        {
>> +            int cc =3D (ctx->opcode >> 8) & 0x7;
>> +            TCGv_i64 t64 =3D tcg_temp_new_i64();
>> +            TCGv_i32 t32 =3D tcg_temp_new_i32();
>> +
>> +            tcg_gen_setcond_i64(cond, t64, t0, t1);
>> +            tcg_gen_extrl_i64_i32(t32, t64);
>> +            tcg_gen_deposit_i32(fpu_fcr31, fpu_fcr31, t32,
>> +                                get_fp_bit(cc), 1);
>> +
>> +            tcg_temp_free_i32(t32);
>> +            tcg_temp_free_i64(t64);
>> +        }
>> +        goto no_rd;
>> +        break;
>>       default:
>>           MIPS_INVAL("loongson_cp2");
>>           generate_exception_end(ctx, EXCP_RI);
>> @@ -5878,6 +5904,7 @@ static void
>gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>>  =20
>>       gen_store_fpr64(ctx, t0, rd);
>>  =20
>> +no_rd:
>>       tcg_temp_free_i64(t0);
>>       tcg_temp_free_i64(t1);
>>   }
>>=20

--=20
Jiaxun Yang

