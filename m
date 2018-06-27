Received: from eggs.gnu.org ([2001:4830:134:3::10]:52104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fY8JS-0003mH-Au
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fY8JP-0001MB-4B
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:08:38 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fY8JO-0001K1-KG
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:08:35 -0400
Received: by mail-wr0-x242.google.com with SMTP id h10-v6so1599554wrq.8
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 04:08:34 -0700 (PDT)
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<aa9afd06-19da-1f48-c20c-2f1eff2e861a@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <aa9afd06-19da-1f48-c20c-2f1eff2e861a@redhat.com>
Date: Wed, 27 Jun 2018 12:08:31 +0100
Message-ID: <87in64wkpc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> On 27.06.2018 09:57, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 27.06.2018 08:51, Gerd Hoffmann wrote:
>> [...]
>>>> Drop support for 32bit hosts in qemu?
>>>
>>> I guess the only way to answer that question reliably is to send a patch
>>> to mark 32-bit hosts as deprecated...
>>>
>>> Anyway, you still have got to fix that problem with -m32 now somehow
>>> since we certainly can not drop 32-bit immediately.
>>
>> We certainly can if we want to.
>>
>> Our formal deprecation policy codifies our compromise between the need
>> to evolve QEMU and the need of its users for stable external interfaces.
>>
>> "Compiles on host X" is also a need, but it's a different one.
>> Evidence: "Supported build platforms" has its own appendix, separate
>> from "Deprecated features".  It's mum on 32-bit hosts.
>
> Theoretically I'd agree, but actually it's more than that: If we drop
> support for 32-bit hosts, we could also drop the qemu-system-i386,
> qemu-system-ppc and qemu-system-arm targets, since qemu-system-x86_64,
> qemu-system-ppc64 and qemu-system-aarch64 are a clear superset of
> these.

Hmm not quite - not building on HOST !=3D not wanting to run GUEST

While I'm unlikely to build on a 32 bit ARM system I run 32 bit guests
all the time.

> But that would also mean a change of the user interface, since the name
> of the executable changes, and at least for ppc, there are also subtle
> differences (different default machine type, different default CPU types).
>
>  Thomas


--
Alex Benn=C3=A9e
