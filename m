Received: from eggs.gnu.org ([2001:4830:134:3::10]:41844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1dX7aN-0004GF-Bk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1dX7aJ-0000az-Ba
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:05:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:56465 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1dX7aJ-0000Zo-4w
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:05:19 -0400
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-15-git-send-email-imammedo@redhat.com>
	<5bec6275-8e15-16c7-8d23-2975a563c78f@twiddle.net>
	<20170717124146.5ae39d2b@nial.brq.redhat.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <f32dbe33-4a99-cf79-e41c-4a1accacda64@suse.de>
Date: Mon, 17 Jul 2017 17:05:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170717124146.5ae39d2b@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/28] m68k: replace cpu_m68k_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>

Am 17.07.2017 um 12:41 schrieb Igor Mammedov:
> On Sat, 15 Jul 2017 08:08:58 -1000
> Richard Henderson <rth@twiddle.net> wrote:
>=20
>> On 07/14/2017 03:52 AM, Igor Mammedov wrote:
>>> @@ -230,6 +230,8 @@ static void m68k_cpu_realizefn(DeviceState *dev, =
Error **errp)
>>>       M68kCPUClass *mcc =3D M68K_CPU_GET_CLASS(dev);
>>>       Error *local_err =3D NULL;
>>>  =20
>>> +    register_m68k_insns(&cpu->env);
>>> + =20
>>
>> I think it would make more sense to do this during m68k_tcg_init.
>>
> it seems that m68k_cpu_initfn accesses 'env' via some global,
> while cpu_mk68k_init() used to access concrete pointer of just created =
cpu,
>=20
> how about moving register_m68k_insns() to m68k_cpu_initfn(), instead?
> it should be equivalent to what cpu_mk68k_init() used to do.

As a general note, realize should be re-entrant. Can't tell from the
above diff whether that is the case here.

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
