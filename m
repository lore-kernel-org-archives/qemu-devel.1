Received: from eggs.gnu.org ([209.51.188.92]:33505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAvA-00068q-95
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAv7-00072q-72
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:17:12 -0500
References: <CALvuzg43uSodseEHjNaRcPFBKKPTY2mcppUbYgiLL=QO9RxX_Q@mail.gmail.com>
	<e62bbdda-2ab9-b9a1-7843-0a3a40f56282@vivier.eu>
	<4cfad0f8-1b66-b6be-693e-ba439e81f171@sysgo.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f36c1752-98ad-7c44-4637-7186c7511f38@vivier.eu>
Date: Wed, 9 Jan 2019 11:17:00 +0100
MIME-Version: 1.0
In-Reply-To: <4cfad0f8-1b66-b6be-693e-ba439e81f171@sysgo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] ppc: e6500 registers SPR 604 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Roman Kapl <roman.kapl@sysgo.com>, Jon Diekema <jon.diekema@gmail.com>, qemu-trivial@nongnu.org, Roman Kapl <rka@sysgo.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

David,

will you take this through your ppc branch?

Thanks,
Laurent

On 04/01/2019 11:41, Roman Kapl wrote:
>> Le 25/12/2018 à 10:50, Jon Diekema a écrit :
>>>  From f399f28441e0aa79458d68996038ca3606fcb699 Mon Sep 17 00:00:00 2001
>>> From: Jon Diekema <jon.diekema@ge.com <mailto:jon.diekema@ge.com>>
>>> Date: Tue, 25 Dec 2018 04:36:06 -0500
>>> Subject: ppc: e6500 registers SPR 604 twice
>>>
>>> When using the e6500 CPU, QEMU generates a fatal error after
>>> complaining about registering SPR 604 twice.
>>>
>>>
>>> diff --git a/target/ppc/translate_init.inc.c
>>> b/target/ppc/translate_init.inc.c
>>> index 03f1d34a97..c971a5faf7 100644
>>> --- a/target/ppc/translate_init.inc.c
>>> +++ b/target/ppc/translate_init.inc.c
>>> @@ -4947,14 +4947,6 @@ static void init_proc_e500(CPUPPCState *env, int
>>> version)
>>>       }
>>>         if (version == fsl_e6500) {
>>> -        spr_register(env, SPR_BOOKE_SPRG8, "SPRG8",
>>> -                     SPR_NOACCESS, SPR_NOACCESS,
>>> -                     &spr_read_generic, &spr_write_generic,
>>> -                     0x00000000);
>>> -        spr_register(env, SPR_BOOKE_SPRG9, "SPRG9",
>>> -                     SPR_NOACCESS, SPR_NOACCESS,
>>> -                     &spr_read_generic, &spr_write_generic,
>>> -                     0x00000000);
>>>           /* Thread identification */
>>>           spr_register(env, SPR_TIR, "TIR",
>>>                        SPR_NOACCESS, SPR_NOACCESS,
>>> -- 
>>> 2.20.1.3.gf17a2b179
>>>
>>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> Tested-by: Laurent Vivier <laurent@vivier.eu>
>>
> 
> Thanks Jon, I did not test with e6500. The patch fixes the issue &
> debugging still works on e5500.
> 
> Roman Kapl
> 
