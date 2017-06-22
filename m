Received: from eggs.gnu.org ([2001:4830:134:3::10]:46746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO6aY-0000Fc-KD
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO6aX-0002J3-Q2
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:12:18 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dO6aX-0002Is-JM
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:12:17 -0400
Received: by mail-wr0-x234.google.com with SMTP id 77so34104151wrb.1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 11:12:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fb2c7124-2d3f-6684-e2f2-265bfb3eb6da@redhat.com>
References: <149814756006.27338.8723356702388175951.stgit@bahia>
	<CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
	<20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com>
	<87injo6jla.fsf@secure.mitica>
	<CAFEAcA-g-=AkH3t8jOTFY_9zA6ECS57-3MS=cHPb+Q6sePzNsw@mail.gmail.com>
	<20170622172555.GE2100@work-vm>
	<20170622194649.6d251753@bahia.lab.toulouse-stg.fr.ibm.com>
	<20170622175012.GF2100@work-vm>
	<fb2c7124-2d3f-6684-e2f2-265bfb3eb6da@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 19:11:55 +0100
Message-ID: <CAFEAcA-A=UrkKjLmVOcFA_d4rMW1AJwGffE4r2Uy6fw++XFF6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Separate function types from opaque types
 in include/qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On 22 June 2017 at 19:08, Thomas Huth <thuth@redhat.com> wrote:
> On 22.06.2017 19:50, Dr. David Alan Gilbert wrote:
>> Could do; I'm just not finding tiny header files with one or
>> two entries each that useful.

Well, it means that the bulk of code that doesn't care about the
types doesn't get its compilation fractionally slowed by having
to parse the typedef anyway. In general I think we're drifting
towards "have each .c file get fewer things automatically" rather
than otherwise (eg more finely focused files rather than stuffing
everything into qemu-common.h).

> Do we really need these function typedefs at all? IMHO it's quite ugly
> to hide such things in a typedef unless it is really necessary (and in
> this case, it does not seem to be really necessary since it is only used
> in a few places). So what about simply removing the typedefs in this case?

I find function typedefs much more readable than having the
function-types inline in function arguments and the like.

This is all fairly rapidly heading into bikeshed territory
though -- in the final analysis I don't think it matters
much what we do.

thanks
-- PMM
