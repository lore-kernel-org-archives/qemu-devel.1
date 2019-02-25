Received: from eggs.gnu.org ([209.51.188.92]:41196)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gy9iL-0001rQ-6Q
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 01:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gy9iJ-0002Kd-Jj
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 01:26:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:47275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gy9iI-0001vF-Bn
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 01:26:07 -0500
From: Kamil Rytarowski <n54@gmx.com>
References: <20190202144531.5772-1-n54@gmx.com>
	<a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
	<d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
	<fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
	<e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
	<4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
	<39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
	<26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
Message-ID: <9ee31aff-0a22-479c-3667-33998c061483@gmx.com>
Date: Mon, 25 Feb 2019 07:26:02 +0100
MIME-Version: 1.0
In-Reply-To: <26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eqMemuxm4WOZHdcuqqU3l78WVeNpzqr3h"
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
--eqMemuxm4WOZHdcuqqU3l78WVeNpzqr3h
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <9ee31aff-0a22-479c-3667-33998c061483@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
References: <20190202144531.5772-1-n54@gmx.com>
 <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
 <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
 <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
 <e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
 <4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
 <39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
 <26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
In-Reply-To: <26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping.

On 21.02.2019 03:08, Kamil Rytarowski wrote:
> On 20.02.2019 18:29, Paolo Bonzini wrote:
>> On 20/02/19 12:59, Kamil Rytarowski wrote:
>>> Ping, still valid.
>>
>> Sorry, I missed your email.
>>
>>> On 15.02.2019 00:38, Kamil Rytarowski wrote:
>>>> I consider it as fragile hack and certainly not something to depend =
on.
>>>> Also in some circumstances of such code, especially "if (zero0)" we =
want
>>>> to enable disabled code under a debugger.
>>
>> That's a good objection, but certainly does not apply to KVM on NetBSD=
=2E
>>
>=20
> There is KVM for Darwin (experimental and rather toy project) and it
> might be ported to NetBSD (I have actually forked it on GitHub
> recently), but I doubt that someone would enable KVM on any platform
> under a debugger this way and expect something to work.
>=20
>>>> There were also kernel backdoors due to this optimization.
>>
>> Citation please?
>>
>=20
> I saw an exploit for such case with a .txt writeup on ftp of grsecurity=

> but that service seems to be gone (probably long time ago), so please
> defer discussion on it. If someone is interested to find it out, there
> are enough pointers to dig it (assuming that this is still possible).
>=20
>>>> Requested cpu.i (hopefully correctly generated)
>>>>
>>>> http://netbsd.org/~kamil/qemu/cpu.i.bz2
>>
>> So, first thing first I can reproduce clang's behavior with this .i fi=
le
>> and also with this reduced test case.
>>
>>     extern void f(void);
>>     int i, j;
>>     int main()
>>     {
>>         if (0  && i) f();
>>         if (j  && 0) f();
>>    }
>>
>> The first is eliminated but the second is not, just like in QEMU where=

>> this works:
>>
>>         if (kvm_enabled() && cpu->enable_pmu) {
>>             KVMState *s =3D cs->kvm_state;
>>
>>             *eax =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_EAX=
);
>>             *ebx =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_EBX=
);
>>             *ecx =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_ECX=
);
>>             *edx =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_EDX=
);
>>         } else if (hvf_enabled() && cpu->enable_pmu) {
>>             *eax =3D hvf_get_supported_cpuid(0xA, count, R_EAX);
>>             *ebx =3D hvf_get_supported_cpuid(0xA, count, R_EBX);
>>             *ecx =3D hvf_get_supported_cpuid(0xA, count, R_ECX);
>>             *edx =3D hvf_get_supported_cpuid(0xA, count, R_EDX);
>>
>> while this doesn't:
>>
>>     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
>>         kvm_enabled()) {
>>         KVMState *s =3D CPU(cpu)->kvm_state;
>>         uint32_t eax_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_=
EAX);
>>         uint32_t ebx_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_=
EBX);
>>         uint32_t ecx_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_=
ECX);
>>         uint32_t eax_1 =3D kvm_arch_get_supported_cpuid(s, 0x14, 1, R_=
EAX);
>>         uint32_t ebx_1 =3D kvm_arch_get_supported_cpuid(s, 0x14, 1, R_=
EBX);
>>
>> But, that's okay, it's -O0 so we give clang a pass for that  Note that=

>> clang does do the optimization even in more complex cases like
>>
>>     extern _Bool f(void);
>>     int main()
>>     {
>>         if (!0) return 0;
>>         if (!f()) return 0;
>>     }
>>
>> The problem is that there is a kvm-stub.c entry for that, and in fact
>> my compilation passes and the symbol is resolved correctly:
>>
>> $ nm target/i386/cpu.o |grep kvm_.*get_sup
>>                  U kvm_arch_get_supported_cpuid
>> $ nm target/i386/kvm-stub.o|grep kvm_.*get_sup
>> 0000000000000030 T kvm_arch_get_supported_cpuid
>> $ nm qemu-system-x86_64 |grep kvm_.*get_sup
>> 000000000046eab0 T kvm_arch_get_supported_cpuid
>>
>> As expected, something much less obvious is going on for you, in
>> particular __OPTIMIZE__seems not to be working properly.  However,
>> that would also be very surprising.
>>
>> Please:
>>
>> 1) run the last two "nm" commands on your build (wthout grep).
>>
>=20
> I cannot run nm(1) on qemu-system-x86_64 as it's not linkable.
>=20
> I'm getting the same result for target/i386/cpu.o and
> target/i386/kvm-stub.o.
>=20
> $ nm ./i386-softmmu/target/i386/kvm-stub.o
>                  U abort
> 0000000000000000 T kvm_allows_irq0_override
> 0000000000000030 T kvm_arch_get_supported_cpuid
> 0000000000000020 T kvm_enable_x2apic
> 0000000000000010 T kvm_has_smm
> 0000000000000050 T kvm_hv_vpindex_settable
>=20
> grep(1) used, but otherwise I would need to upload results somewhere el=
se.
>=20
> $ nm ./i386-bsd-user/target/i386/cpu.o |grep kvm
>                  U kvm_arch_get_supported_cpuid
> 0000000000001290 d kvm_default_props
>                  U kvm_state
> 0000000000000240 T x86_cpu_change_kvm_default
>=20
> Please note that there are 4 types of x86 build: i386, x86_64 and two
> bsd-user (32-bit and 64-bit).
>=20
> According to my observations of repeated attempts both builds of
> bsd-user are affected.
>=20
> There is also a difference that kvm-stub is twice in !bsd-user
> directories and once in bsd-user ones.
>=20
> $ find . -name kvm-stub.o|grep x86_64
> ./x86_64-softmmu/accel/stubs/kvm-stub.o
> ./x86_64-softmmu/target/i386/kvm-stub.o
> ./x86_64-bsd-user/accel/stubs/kvm-stub.o
>=20
>> 2) do the same exercise to get a .i for target/i386/kvm-stub.c
>>
>> 3) try removing the "#ifndef __OPTIMIZE__" and leave everything else a=
s is,
>> see if it works.
>=20
> Same result as above, it seems that bsd-user ones are affected in the
> same way.
>=20
>>  No need to play with macros, which also goes to show that
>> you didn't really understand what's going on---that's fine, but then p=
lease
>> refrain from making summary judgments which only lengthen the discussi=
on.
>>
>=20
> I stand with my expression that I find playing with optimizer as too
> fragile to depend on it. Relying on a preprocessor to disable unused
> code is predictable. But if that is the style in qemu, I can just
> acknowledge it.
>=20
>> Thanks,
>>
>> Paolo
>>
>=20
>=20



--eqMemuxm4WOZHdcuqqU3l78WVeNpzqr3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxzinoMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsaJsP+wWsfchAauxPIS5dlXZgv0nvprNXqmYy5h4uhnH2
WUXHKcTwOxMQAEDaoNqALHN6iCoVK+X8mWyEuxkjhJ72MG4rZVdSxBAq7/A5yrn+
TjBkC3dUZViOjPShaT54GPLJXQ6bFnhwcIDa10vEEqWOiuMjjokQRPQYgqwjIB70
Hg/i1x/ZlDyZNK9XvZ1M5xs4VwJfeZzxlF2IMiJZdhuY9P73gE8wI3A3+pzdRSDM
5FCapoxh52/whIolB3PtqpKrL50a5HcmKvuqoWxj9scsT8ZefYq81B/qh9KubzPS
pcCjcQB5F5seb09M/MoCoPNbByC091ZQ8IudmvIGAU6lHy50fHtLs5DQAqyvKNtc
RIoTPwgTlwnpSk/n+VAFhHA9FVRsxm/4Fi04tHSiO0kymmuwts5JtxUnQcqfEIPu
tEBaHZtohH18nqiiFIhGedm05DS3WicfuOq46kP+AgPzVwAmYs4zc7wUGqkwks4t
G5y3jK7oIEGzw7Wa4lwSQoMEaiymWQ6EzRkbh5OMqIsboEH34WTWGVTOLBCbF+D9
2Sp3Gn6SX9jLuxqFoGp0QCYnlXJoebNAYqQNRE1BWWWIKYm0tQ7uv1BOrj9kPxk6
Phs6z2K9yGMkLMv37RIcKvPSIKOj2IONTb/bqki9Rq3eS9pBL2pmUY4IYgzFHbH2
au7w
=Emyq
-----END PGP SIGNATURE-----

--eqMemuxm4WOZHdcuqqU3l78WVeNpzqr3h--
