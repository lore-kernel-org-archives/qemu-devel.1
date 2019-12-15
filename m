Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62167C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 11:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1C120700
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 11:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1C120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igRdK-0005w6-5w
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 06:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1igRcf-0005Qb-Dt
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 05:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1igRcd-0003sh-Cu
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 05:59:36 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:14342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1igRcd-000371-3H; Sun, 15 Dec 2019 05:59:35 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 76AA8745980;
 Sun, 15 Dec 2019 11:59:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 32E51745958; Sun, 15 Dec 2019 11:59:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 30E18745957;
 Sun, 15 Dec 2019 11:59:22 +0100 (CET)
Date: Sun, 15 Dec 2019 11:59:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] ppc: remove excessive logging
In-Reply-To: <4a608af2-62a2-3ffb-0c02-8e0ca699d586@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.1912151147300.3618@zero.eik.bme.hu>
References: <20191214121347.17071-1-joakim.tjernlund@infinera.com>
 <4a608af2-62a2-3ffb-0c02-8e0ca699d586@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2028625278-1576407562=:3618"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Joakim Tjernlund <joakim.tjernlund@infinera.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2028625278-1576407562=:3618
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Dec 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Joakim,
>
> I'm cc'ing the PPC maintainers for you, so they won't miss your patch (=
see=20
> https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintaine=
r and=20
> the output of ./scripts/get_maintainer.pl -f target/ppc/excp_helper.c).
>
> On 12/14/19 1:13 PM, Joakim Tjernlund wrote:
>> From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
>>=20
>> ppc logs every type of Invalid instruction. This generates a lot
>> of garbage on console when sshd/ssh_keygen executes as
>> they try various insn to optimize its performance.
>> The invalid operation log is still there so an unknown insn
>> will still be logged.
>>=20
>> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
>> ---
>>
>> 	As far as I can see, ppc is the only one emiting thsi
>> 	debug msg for Invalid insns.
>>=20
>> target/ppc/excp_helper.c | 1 -
>>   1 file changed, 1 deletion(-)
>>=20
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 50b004d00d..45c2fa3ff9 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -326,7 +326,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, i=
nt=20
>> excp_model, int excp)
>>               env->spr[SPR_BOOKE_ESR] =3D ESR_FP;
>>               break;
>>           case POWERPC_EXCP_INVAL:
>> -            LOG_EXCP("Invalid instruction at " TARGET_FMT_lx "\n",=20
>> env->nip);
>
> I don't think we want to remove a such important log. Since it make sen=
se to=20
> not disturb the console, maybe we can replace some of the LOG_EXCP() ca=
lls by=20
> qemu_log_mask(LOG_GUEST_ERROR,...) instead?

I don't think that's a good idea. That would flood the -d guest_errors lo=
g=20
with unwanted messages that are normal not really due to guest errors. Th=
e=20
LOG_EXCP() is not enabled by default, you have to edit source to enable i=
t=20
so you can also then edit the unwanted messages as well (like commenting=20
this one out if you don't like it). If this is removed, invalid opcodes=20
are still logged from translate.c but the exception generated for them is=
=20
not logged. I don't know if that's useful or not but these are debug logs=
=20
so depends on what do you want to debug. I don't mind this being removed=20
but would be also happy leaving it as it is as it's only shown for=20
developers who enable it and might help debugging. Or maybe these could b=
e=20
converted to traces (although I generally find traces to be less=20
convenient to work with than debug logs and not sure about potential=20
performance impact). So my preferences would be in order: 1. leave it=20
alone, 2. remove it, 3. convert to traces.

Regards,
BALATON Zoltan

>
>>               msr |=3D 0x00080000;
>>               env->spr[SPR_BOOKE_ESR] =3D ESR_PIL;
>>               break;
--3866299591-2028625278-1576407562=:3618--

