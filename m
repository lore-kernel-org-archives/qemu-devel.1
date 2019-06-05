Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B31C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2D120866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2D120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decred.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYdLI-0005pY-Gm
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:21:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marco@decred.org>) id 1hYd0u-0000I2-A0
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marco@decred.org>) id 1hYd0s-0006xi-Fg
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:00:04 -0400
Received: from 96-92-233-220-static.hfc.comcastbusiness.net
	([96.92.233.220]:59670 helo=dcr0.decred.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marco@decred.org>) id 1hYd0s-0006s7-7q
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:00:02 -0400
Received: from marcos-macbook.home (a95-94-160-35.cpe.netcabo.pt
	[95.94.160.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by dcr0.decred.org (Postfix) with ESMTPSA id 0B22518B407F
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 20:59:57 +0000 (UTC)
From: Marco Peereboom <marco@decred.org>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_3FBB73B5-C2E3-4C80-8646-40BF9438B27C";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Message-Id: <B1A3E8F6-F8C2-4EDB-A31B-EBB4CA636CA3@decred.org>
References: <4350e3aabc7651c63286c78ffa3f273b5cb16884.camel@wdc.com>
To: qemu-devel@nongnu.org
Date: Wed, 5 Jun 2019 21:59:53 +0100
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 96.92.233.220
X-Mailman-Approved-At: Wed, 05 Jun 2019 17:20:04 -0400
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Fwd: [joel@sing.id.au: atomic failures on
 qemu-system-riscv64]
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_3FBB73B5-C2E3-4C80-8646-40BF9438B27C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Joel is on vacation so here it is again.

> Begin forwarded message:
>=20
> From: Alistair Francis <Alistair.Francis@wdc.com>
> Subject: Re: [joel@sing.id.au: atomic failures on qemu-system-riscv64]
> Date: June 5, 2019 at 7:19:53 PM GMT+1
> To: "joel@sing.id.au" <joel@sing.id.au>, "palmer@sifive.com" =
<palmer@sifive.com>
> Cc: "marco@decred.org" <marco@decred.org>, "me@carlosedp.com" =
<me@carlosedp.com>
>=20
> On Fri, 2019-05-31 at 03:21 +1000, Joel Sing wrote:
>> I've just sent this to qemu-riscv@nongnu.org - forwarding for
>> visibility...
>=20
> Hello Joel,
>=20
> Can you please send this to the QEMU mailing list?
> https://wiki.qemu.org/Contribute/MailingLists
>=20
>>=20
>> ----- Forwarded message from Joel Sing <joel@sing.id.au> -----
>>=20
>> Date: Fri, 31 May 2019 03:20:03 +1000
>> From: Joel Sing <joel@sing.id.au>
>> To: qemu-riscv@nongnu.org
>> Subject: atomic failures on qemu-system-riscv64
>> User-Agent: Mutt/1.10.1 (2018-07-13)
>>=20
>> While working on a Go (www.golang.org) port for riscv, I've run
>> into issues with atomics (namely LR/SC) on qemu-system-riscv64.
>> There are several reproducers for this problem including (using
>> gcc builtin atomics):
>>=20
>>  https://gist.github.com/4a6f656c/8433032a3f70893a278259f8108aad90
>>=20
>> And a version using inline assembly:
>>=20
>>  https://gist.github.com/4a6f656c/d883091f5ca811822720213be343a75a
>>=20
>> Depending on the qemu configuration the number of threads may
>> need increasing (to force context switching) and/or run in a
>> loop. Go's sync/atomic tests also fail regularly.
>>=20
>> Having dug into the qemu code, what I believe is happening is
>> along the lines of the following:
>>=20
>> 1. Thread 1 runs and executes an LR - this assigns an address
>>   to load_res and a value to load_val (say 1).
>>=20
>> 2. A context switch occurs and thread 2 is now run - it runs
>>   an LR and SC on the same address modifying the stored value.
>>   Another LR is executed loading load_val with the current
>>   value (say 3).
>>=20
>> 3. A context switch occurs and thread 1 is now run again, it
>>   continues on its LR/SC sequence and now runs the SC instruction.
>>   This is based on the assumption that it had a reservation
>>   and the SC will fail if the memory has changed. The underlying
>>   implementation of SC is a cmpxchg with the value in load_val
>>   - this no longer has the original value and hence successfully
>>   compares (as does the tcg_gen_setcond_tl() between the returned
>>   value and load_val) thus the SC succeeds when it should not.
>>=20
>> The diff below clears load_res when the mode changes - with this
>> applied the reproducers work correctly, as do Go's atomic tests.
>> I'm not sure this "fix" is 100% correct, but it certainly verifies
>> where the problem lies. It does also fall inline with the RISCV
>> spec:
>>=20
>> "The SC must fail if there is an observable memory access from
>> another hart to the address, or if there is an intervening context
>> switch on this hart, or if in the meantime the hart executed a
>> privileged exception-return instruction."
>>=20
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index b17f169681..9875b8e5d3 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -113,6 +113,8 @@ void riscv_cpu_set_mode(CPURISCVState *env,
>> target_ulong newpriv)
>>     }
>>     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>>     env->priv =3D newpriv;
>> +
>> +    env->load_res =3D 0;
>=20
> This looks ok to me, I'll read the spec to double check though. Do you
> mind adding a comment in the code as to why this is required?
>=20
> Alistair
>=20
>> }
>>=20
>> /* get_physical_address - get the physical address for this virtual
>> address
>>=20
>> ----- End forwarded message -----


--Apple-Mail=_3FBB73B5-C2E3-4C80-8646-40BF9438B27C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8htVBWYODFIPzwuljM0W459K7ykFAlz4LUkACgkQjM0W459K
7yk9/g/7BKgyerF9cM7s4saoTfOGIsMXXGtShYkGC4OvY9sUJVdLE5Ci974i79zv
CJ6Tq1JF3uU0/SWpjrGhqGaTuoLoDO3aM3xbT8n42HCJIL1bGjGcaa2NxhQclc1w
VuyEGoyYvnsDRSCGXQ9PVYZl7pvvAirpVMhzGxaDhlZX7cZilA39OzNsEJNxTO8O
lmvq88zs+QwYfg1r2CVTqX+/eGL0PTYapUTFtYoRz/EDMrstMYhQligqpV95ceEH
C3J+ktkYpNBb55nTftNjgKoOb35qdx/bRL2jJH4I7rOYimG5SCru/0+YiGYE+FzN
cZkJtD4ZQuWqSDi8dTZ71TvOxn+719L1zF7n9Z6yHQHaGrHM7BulOSqoS1/4B9fZ
QumS4ydgWbkSl6nH4frPLQu1fu0GSYIigik7h36p4kmEMQo3DccgyBhkCoWlvN14
Wu2mpBXW/qgqc5+meWPRe9tXkt9BP3B469IYkRDdgeZlBF4utwOm83TeoSFW0ANk
DwneL7xrJFqIdlYKK/W/zRUr6+Ot6gjl3McxTm3Vr+HVwGF9kFS9xVSPW2t3wHS9
VRoXolPPhE3aRqcUUQq3jaSwUHp49nudvLfXDerp94m5oEM+f0atXeh4axJks6IO
RMyCRI79xvFVTZMV4cEjWBmygzLIiNAIX6/csXew+pa74OvMi2Q=
=FlIS
-----END PGP SIGNATURE-----

--Apple-Mail=_3FBB73B5-C2E3-4C80-8646-40BF9438B27C--

