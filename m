Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B6C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B4B20774
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYqBxiSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B4B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF28C-0000UX-I1
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 16:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1jF27C-0007jV-CT
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1jF27A-0001Qo-44
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:50:06 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:38173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1jF277-0001Jw-Ex; Thu, 19 Mar 2020 16:50:01 -0400
Received: by mail-qt1-x843.google.com with SMTP id z12so3157737qtq.5;
 Thu, 19 Mar 2020 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=nsO5rWUGZkbWpo6KrMjGUAKZq2rEBR+sVHvlYsr+gUc=;
 b=AYqBxiSa5+tPC04eNGin9tSPAqJBMpJDm0m4Ff+p00JWYRXvvyb7KyOKfpyCuuVvYE
 VdGoCq08jOROVz+XMyBRtEoDdMBxcPaB1WybpfBDvuxoC0XW/Ik+hPrzNI1z7TVaowqT
 2vz4D1Z0MJGsUKuWgBCcbcNfGkzlpnGr2orO3rEUMUNYh72saI2gsM6HvjMIBQ1K9ln9
 zo7DwkX27/PmiWNHLx5FaLC+XZCJmV8Z1u5mUpv/gdE6VTijktiBN0HxIyyIcPEYtu3F
 8Hbvd86P3CLQrkOxU8WSUvhlf6eoPyK9MFTQ8ArTnVWA7f58KzjMlqcVfx67KTajQWHa
 lrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=nsO5rWUGZkbWpo6KrMjGUAKZq2rEBR+sVHvlYsr+gUc=;
 b=JaX17whfbRp1X4n0oWrj1k1Mx1GvHwcDd9m8jJ//VXdnT+p/6HV31Ltrcph9ARXmMC
 hb4DRmucN8W93m4x7eBIQYJ0OJ6UEan7ub143qi5W8K1bWPWiqnJjv7jtE+E/vB+AdGv
 YbUZc21Ty22waeGCuq2Qqx+DcEJyCH2XV+X1YUqStYyqtBPUi3ZM4Gz+OZE0gMnYSncE
 f+Mg8XG2KZPMmStivKmvLjJNDa6FruIwVf4Cdo2/Kq1EQeWYGo3Qu9ug6C8iDeCkoOUJ
 hDIAlo7IuvsV9fXTaMKyhs8EqL12N7UPq7bv7WPnBN7ITKaKUsW5KUqiusnzvgKyemJD
 L7mQ==
X-Gm-Message-State: ANhLgQ3JzNm+/S7wKXORrBX7WNjdovvohFMUaCSccU9SdY3sRJGkapBX
 WViXCEKhdTnMZPs58WxBWds=
X-Google-Smtp-Source: ADFU+vtOnCnkX+Sixe2DeQfs+WYq9w1EQqlowzIHjlPc3v00TAR/mRcxV4huWarEaLSJO3PEJG4I/w==
X-Received: by 2002:ac8:4784:: with SMTP id k4mr393017qtq.78.1584651000203;
 Thu, 19 Mar 2020 13:50:00 -0700 (PDT)
Received: from [192.168.0.4] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id l60sm2596024qtd.35.2020.03.19.13.49.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Mar 2020 13:49:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset to take
 an alternate vector
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20200317224615.GO20264@umbus.fritz.box>
Date: Thu, 19 Mar 2020 16:49:55 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9C2381A-C059-43EF-8E9D-BB94F5F9C510@gmail.com>
References: <mailman.138.1584442890.3017.qemu-ppc@nongnu.org>
 <34ABB38A-B887-41B5-9108-25DA6ADB4B24@gmail.com>
 <20200317224615.GO20264@umbus.fritz.box>
To: David Gibson <david@gibson.dropbear.id.au>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, Greg Kurz <groug@kaod.org>,
 npiggin@gmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Mar 17, 2020, at 6:46 PM, David Gibson =
<david@gibson.dropbear.id.au> wrote:
>=20
> On Tue, Mar 17, 2020 at 11:06:15AM -0400, Programmingkid wrote:
>>=20
>>> On Mar 17, 2020, at 7:01 AM, qemu-ppc-request@nongnu.org wrote:
>>>=20
>>> Message: 3
>>> Date: Tue, 17 Mar 2020 11:47:32 +0100
>>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>> To: David Gibson <david@gibson.dropbear.id.au>, Nicholas Piggin
>>> 	<npiggin@gmail.com>
>>> Cc: qemu-ppc@nongnu.org, Aravinda Prasad <arawinda.p@gmail.com>,
>>> 	Ganesh Goudar <ganeshgr@linux.ibm.com>, Greg Kurz =
<groug@kaod.org>,
>>> 	qemu-devel@nongnu.org
>>> Subject: Re: [PATCH v2 6/8] target/ppc: allow =
ppc_cpu_do_system_reset
>>> 	to take an alternate vector
>>> Message-ID: <097148e5-78be-a294-236d-160fb5c29d4a@kaod.org>
>>> Content-Type: text/plain; charset=3Dwindows-1252
>>>=20
>>> On 3/17/20 12:34 AM, David Gibson wrote:
>>>> On Tue, Mar 17, 2020 at 09:28:24AM +1000, Nicholas Piggin wrote:
>>>>> C=C3=A9dric Le Goater's on March 17, 2020 4:15 am:
>>>>>> On 3/16/20 3:26 PM, Nicholas Piggin wrote:
>>>>>>> Provide for an alternate delivery location, -1 defaults to the
>>>>>>> architected address.
>>>>>>=20
>>>>>> I don't know what is the best approach, to override the vector =
addr
>>>>>> computed by powerpc_excp() or use a machine class handler with=20
>>>>>> cpu->vhyp.
>>>>>=20
>>>>> Yeah it's getting a bit ad hoc and inconsistent with machine check
>>>>> etc, I just figured get something minimal in there now. The whole
>>>>> exception delivery needs a spring clean though.
>>>>=20
>>=20
>> Currently Mac OS 9 will not restart. When someone goes to restart it
>> the screen will turn black and stay that way. Could this patch solve
>> this problem?
>=20
> No.  It's unlikely to be related, and at this stage is used
> exclusively to implement the FWNMI stuff for the pseries machine.
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my =
code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT =
_the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Ok. Thank you.


