Received: from eggs.gnu.org ([2001:4830:134:3::10]:52435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY8Kh-0004lv-9w
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY8Ke-0002Wp-3m
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:09:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fY8Kd-0002WS-UO
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:09:52 -0400
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<aa9afd06-19da-1f48-c20c-2f1eff2e861a@redhat.com>
	<87in64wkpc.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <082bf033-95cc-ddb3-b932-c99483900656@redhat.com>
Date: Wed, 27 Jun 2018 13:09:48 +0200
MIME-Version: 1.0
In-Reply-To: <87in64wkpc.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Drop support for 32bit hosts in qemu?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>

On 27.06.2018 13:08, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 27.06.2018 09:57, Markus Armbruster wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> On 27.06.2018 08:51, Gerd Hoffmann wrote:
>>> [...]
>>>>> Drop support for 32bit hosts in qemu?
>>>>
>>>> I guess the only way to answer that question reliably is to send a p=
atch
>>>> to mark 32-bit hosts as deprecated...
>>>>
>>>> Anyway, you still have got to fix that problem with -m32 now somehow
>>>> since we certainly can not drop 32-bit immediately.
>>>
>>> We certainly can if we want to.
>>>
>>> Our formal deprecation policy codifies our compromise between the nee=
d
>>> to evolve QEMU and the need of its users for stable external interfac=
es.
>>>
>>> "Compiles on host X" is also a need, but it's a different one.
>>> Evidence: "Supported build platforms" has its own appendix, separate
>>> from "Deprecated features".  It's mum on 32-bit hosts.
>>
>> Theoretically I'd agree, but actually it's more than that: If we drop
>> support for 32-bit hosts, we could also drop the qemu-system-i386,
>> qemu-system-ppc and qemu-system-arm targets, since qemu-system-x86_64,
>> qemu-system-ppc64 and qemu-system-aarch64 are a clear superset of
>> these.
>=20
> Hmm not quite - not building on HOST !=3D not wanting to run GUEST
>=20
> While I'm unlikely to build on a 32 bit ARM system I run 32 bit guests
> all the time.

But you can also run 32-bit ARM guests with qemu-system-aarch64, can't yo=
u?

 Thomas
