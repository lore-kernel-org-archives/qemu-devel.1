Received: from eggs.gnu.org ([209.51.188.92]:51093)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gwdyB-0004ph-Uo
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 21:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gwdmm-0001mP-6Q
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 21:08:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:48937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gwdml-0001jk-Oz
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 21:08:28 -0500
References: <20190202144531.5772-1-n54@gmx.com>
	<a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
	<d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
	<fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
	<e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
	<4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
	<39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
Date: Thu, 21 Feb 2019 03:08:55 +0100
MIME-Version: 1.0
In-Reply-To: <39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j5xMkNNASXSfe0JsSFOme4X7VVLKoiH7l"
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5xMkNNASXSfe0JsSFOme4X7VVLKoiH7l
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
References: <20190202144531.5772-1-n54@gmx.com>
 <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
 <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
 <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
 <e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
 <4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
 <39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
In-Reply-To: <39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.02.2019 18:29, Paolo Bonzini wrote:
> On 20/02/19 12:59, Kamil Rytarowski wrote:
>> Ping, still valid.
>=20
> Sorry, I missed your email.
>=20
>> On 15.02.2019 00:38, Kamil Rytarowski wrote:
>>> I consider it as fragile hack and certainly not something to depend o=
n.
>>> Also in some circumstances of such code, especially "if (zero0)" we w=
ant
>>> to enable disabled code under a debugger.
>=20
> That's a good objection, but certainly does not apply to KVM on NetBSD.=

>

There is KVM for Darwin (experimental and rather toy project) and it
might be ported to NetBSD (I have actually forked it on GitHub
recently), but I doubt that someone would enable KVM on any platform
under a debugger this way and expect something to work.

>>> There were also kernel backdoors due to this optimization.
>=20
> Citation please?
>=20

I saw an exploit for such case with a .txt writeup on ftp of grsecurity
but that service seems to be gone (probably long time ago), so please
defer discussion on it. If someone is interested to find it out, there
are enough pointers to dig it (assuming that this is still possible).

>>> Requested cpu.i (hopefully correctly generated)
>>>
>>> http://netbsd.org/~kamil/qemu/cpu.i.bz2
>=20
> So, first thing first I can reproduce clang's behavior with this .i fil=
e
> and also with this reduced test case.
>=20
>     extern void f(void);
>     int i, j;
>     int main()
>     {
>         if (0  && i) f();
>         if (j  && 0) f();
>    }
>=20
> The first is eliminated but the second is not, just like in QEMU where
> this works:
>=20
>         if (kvm_enabled() && cpu->enable_pmu) {
>             KVMState *s =3D cs->kvm_state;
>=20
>             *eax =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_EAX)=
;
>             *ebx =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_EBX)=
;
>             *ecx =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_ECX)=
;
>             *edx =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_EDX)=
;
>         } else if (hvf_enabled() && cpu->enable_pmu) {
>             *eax =3D hvf_get_supported_cpuid(0xA, count, R_EAX);
>             *ebx =3D hvf_get_supported_cpuid(0xA, count, R_EBX);
>             *ecx =3D hvf_get_supported_cpuid(0xA, count, R_ECX);
>             *edx =3D hvf_get_supported_cpuid(0xA, count, R_EDX);
>=20
> while this doesn't:
>=20
>     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
>         kvm_enabled()) {
>         KVMState *s =3D CPU(cpu)->kvm_state;
>         uint32_t eax_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_E=
AX);
>         uint32_t ebx_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_E=
BX);
>         uint32_t ecx_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_E=
CX);
>         uint32_t eax_1 =3D kvm_arch_get_supported_cpuid(s, 0x14, 1, R_E=
AX);
>         uint32_t ebx_1 =3D kvm_arch_get_supported_cpuid(s, 0x14, 1, R_E=
BX);
>=20
> But, that's okay, it's -O0 so we give clang a pass for that  Note that
> clang does do the optimization even in more complex cases like
>=20
>     extern _Bool f(void);
>     int main()
>     {
>         if (!0) return 0;
>         if (!f()) return 0;
>     }
>=20
> The problem is that there is a kvm-stub.c entry for that, and in fact
> my compilation passes and the symbol is resolved correctly:
>=20
> $ nm target/i386/cpu.o |grep kvm_.*get_sup
>                  U kvm_arch_get_supported_cpuid
> $ nm target/i386/kvm-stub.o|grep kvm_.*get_sup
> 0000000000000030 T kvm_arch_get_supported_cpuid
> $ nm qemu-system-x86_64 |grep kvm_.*get_sup
> 000000000046eab0 T kvm_arch_get_supported_cpuid
>=20
> As expected, something much less obvious is going on for you, in
> particular __OPTIMIZE__seems not to be working properly.  However,
> that would also be very surprising.
>=20
> Please:
>=20
> 1) run the last two "nm" commands on your build (wthout grep).
>=20

I cannot run nm(1) on qemu-system-x86_64 as it's not linkable.

I'm getting the same result for target/i386/cpu.o and
target/i386/kvm-stub.o.

$ nm ./i386-softmmu/target/i386/kvm-stub.o
                 U abort
0000000000000000 T kvm_allows_irq0_override
0000000000000030 T kvm_arch_get_supported_cpuid
0000000000000020 T kvm_enable_x2apic
0000000000000010 T kvm_has_smm
0000000000000050 T kvm_hv_vpindex_settable

grep(1) used, but otherwise I would need to upload results somewhere else=
=2E

$ nm ./i386-bsd-user/target/i386/cpu.o |grep kvm
                 U kvm_arch_get_supported_cpuid
0000000000001290 d kvm_default_props
                 U kvm_state
0000000000000240 T x86_cpu_change_kvm_default

Please note that there are 4 types of x86 build: i386, x86_64 and two
bsd-user (32-bit and 64-bit).

According to my observations of repeated attempts both builds of
bsd-user are affected.

There is also a difference that kvm-stub is twice in !bsd-user
directories and once in bsd-user ones.

$ find . -name kvm-stub.o|grep x86_64
=2E/x86_64-softmmu/accel/stubs/kvm-stub.o
=2E/x86_64-softmmu/target/i386/kvm-stub.o
=2E/x86_64-bsd-user/accel/stubs/kvm-stub.o

> 2) do the same exercise to get a .i for target/i386/kvm-stub.c
>=20
> 3) try removing the "#ifndef __OPTIMIZE__" and leave everything else as=
 is,
> see if it works.

Same result as above, it seems that bsd-user ones are affected in the
same way.

>  No need to play with macros, which also goes to show that
> you didn't really understand what's going on---that's fine, but then pl=
ease
> refrain from making summary judgments which only lengthen the discussio=
n.
>=20

I stand with my expression that I find playing with optimizer as too
fragile to depend on it. Relying on a preprocessor to disable unused
code is predictable. But if that is the style in qemu, I can just
acknowledge it.

> Thanks,
>=20
> Paolo
>=20



--j5xMkNNASXSfe0JsSFOme4X7VVLKoiH7l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxuCDgMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs9u4QALcsq8eGrRkhoSKJmRFxaUHQ20DNGhSKW2MN9HAL
YWyYL9Kh9si4v3cqoHFRSFZIsHLCt1bY4zpvHl3Z9c5QsQaANXPY7oUCChIdOwHw
rPrOhxudc9fanc504809501vTZcrxrcI5rtgti7PsJ88D7CgdZZW2QZmKbIAF1MW
q6he0czTsYka/ihPT4jxaNRX5ghnW1pwDXNyUviIxNb15cw7K5QKS9TDDw1KY/Dl
zHNjRfL8N2sGva/KtMX215WmbXU5D5repkxrAiHKN7h+e0U+7lf7QTLK9b7kgwwM
Q87yjsXz6nETO8Bt5VoDQbs4MvXDP/s+oJr0jSsquJLUZ3Q4x5GdBZSCYXRvMmgE
t0RNR9hFdqHTqOooZ/HmCxNKFMB9R8Jqlq9DfA98sR/WInnJg0inO168aSH1KgGT
8zmHS7q7omMCoDvbztIVKbNF64sjZnFC4BsrlcOxb7OCtEwHVycljizp7uabI+Ec
AcBOeJ7XZau4NuIXQO+ULIJhY/dWcZBviz5E4lcUD84TF5+mzT64opaufw8QCIjB
TGsY7ONtd7IxedRExN4bsqZVnk+fyXAp1Zrbcu6fUjjlnRFV0vzk05xwbUGaJ2RP
W/pOCnIA9kGYjbmwG1Y7/XNyEQ47y74bccuvFDR3RHOSqxO2OuCqZUOTk3SRE/Xv
7/5M
=uhCJ
-----END PGP SIGNATURE-----

--j5xMkNNASXSfe0JsSFOme4X7VVLKoiH7l--
