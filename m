Received: from eggs.gnu.org ([2001:4830:134:3::10]:55743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCqkF-0000hD-8U
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCqk8-0007rH-0n
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:40:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCqk6-0007iR-JO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:40:27 -0400
References: <20180928104319.3296-1-bigeasy@linutronix.de>
	<20180928145411.GN5738@habkost.net>
	<20181017181251.fpnh6y5ldrmgb7j5@linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0081f788-0937-8aca-0308-edd7eaf6f678@redhat.com>
Date: Wed, 17 Oct 2018 20:40:17 +0200
MIME-Version: 1.0
In-Reply-To: <20181017181251.fpnh6y5ldrmgb7j5@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386: correct cpu_x86_cpuid(0xd)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, tglx@linutronix.de, Richard Henderson <rth@twiddle.net>

On 17/10/2018 20:12, Sebastian Andrzej Siewior wrote:
> On 2018-09-28 11:54:11 [-0300], Eduardo Habkost wrote:
>> On Fri, Sep 28, 2018 at 12:43:19PM +0200, Sebastian Andrzej Siewior wr=
ote:
>>> Intel SDM says for CPUID function 0DH, sub-function 0:
>>>
>>> | =E2=80=A2 ECX enumerates the size (in bytes) required by the XSAVE =
instruction for an
>>> |   XSAVE area containing all the user state components supported by =
this
>>> |   processor.
>>> | =E2=80=A2 EBX enumerates the size (in bytes) required by the XSAVE =
instruction for an
>>> |   XSAVE area containing all the user state components corresponding=
 to bits
>>> |   currently set in XCR0.
>>>
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>> ---
>>>  target/i386/cpu.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index f24295e6e4bb7..00c18444c0bac 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -4178,7 +4178,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t i=
ndex, uint32_t count,
>>>              *ecx =3D xsave_area_size(x86_cpu_xsave_components(cpu));
>>>              *eax =3D env->features[FEAT_XSAVE_COMP_LO];
>>>              *edx =3D env->features[FEAT_XSAVE_COMP_HI];
>>> -            *ebx =3D *ecx;
>>> +            *ebx =3D xsave_area_size(env->xcr0);
>>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> ping

It's queued for my next pull request.

Paolo
