Received: from eggs.gnu.org ([2001:4830:134:3::10]:34839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ekPqQ-0007H9-O7
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ekPqM-0005UC-LK
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:45:10 -0500
References: <1954640316.20171226142913@mobile-stream.com>
	<751c9675-7e93-a907-4b9e-998c50155e84@msgid.tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5796eeab-0a9a-b150-88f0-7296e050f8f3@redhat.com>
Date: Sat, 10 Feb 2018 08:44:49 +0100
MIME-Version: 1.0
In-Reply-To: <751c9675-7e93-a907-4b9e-998c50155e84@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] fix evsrwu and others for powerpcspe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, info@mobile-stream.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>

On 10.02.2018 08:25, Michael Tokarev wrote:
> 26.12.2017 14:29, info@mobile-stream.com wrote:
>> GEN_SPEOP_ARITH2 declares non-local temporaries then calls gen_op_evsr=
wu/evsrws/evslw which generates branch insn.
>=20
> I'm Cc'ing qemu-devel@ for review, since I don't know much about how pp=
c works.

For PPC related stuff, please also always send a CC: to
qemu-ppc@nongnu.org (or even better, use the scripts/get_maintainer.pl
script to get the CC: list right).

Also, your patch is missing a proper "Signed-off-by" line. Please have a
look at https://wiki.qemu.org/Contribute/SubmitAPatch for details.

 Thanks,
  Thomas

>=20
>> --- target/ppc/translate/spe-impl.inc.c.orig
>> +++ target/ppc/translate/spe-impl.inc.c
>> @@ -158,8 +158,8 @@
>>          gen_exception(ctx, POWERPC_EXCP_SPEU);                       =
         \
>>          return;                                                      =
         \
>>      }                                                                =
         \
>> -    t0 =3D tcg_temp_new_i32();                                       =
           \
>> -    t1 =3D tcg_temp_new_i32();                                       =
           \
>> +    t0 =3D tcg_temp_local_new_i32();                                 =
                 \
>> +    t1 =3D tcg_temp_local_new_i32();                                 =
                 \
>>                                                                       =
         \
>>      tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);              =
         \
>>      tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);              =
         \
>>
>>
>=20
>=20
