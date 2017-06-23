Received: from eggs.gnu.org ([2001:4830:134:3::10]:51767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dOIks-00028l-H1
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 03:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dOIkp-0002lV-BQ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 03:11:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <149814756006.27338.8723356702388175951.stgit@bahia>
	<CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
	<20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com>
	<87injo6jla.fsf@secure.mitica>
	<CAFEAcA-g-=AkH3t8jOTFY_9zA6ECS57-3MS=cHPb+Q6sePzNsw@mail.gmail.com>
	<20170622172555.GE2100@work-vm>
	<20170622194649.6d251753@bahia.lab.toulouse-stg.fr.ibm.com>
	<20170622175012.GF2100@work-vm>
	<fb2c7124-2d3f-6684-e2f2-265bfb3eb6da@redhat.com>
	<CAFEAcA-A=UrkKjLmVOcFA_d4rMW1AJwGffE4r2Uy6fw++XFF6w@mail.gmail.com>
Date: Fri, 23 Jun 2017 09:11:39 +0200
In-Reply-To: <CAFEAcA-A=UrkKjLmVOcFA_d4rMW1AJwGffE4r2Uy6fw++XFF6w@mail.gmail.com>
	(Peter Maydell's message of "Thu, 22 Jun 2017 19:11:55 +0100")
Message-ID: <87o9tf5gb8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 22 June 2017 at 19:08, Thomas Huth <thuth@redhat.com> wrote:
>> On 22.06.2017 19:50, Dr. David Alan Gilbert wrote:
>>> Could do; I'm just not finding tiny header files with one or
>>> two entries each that useful.
>
> Well, it means that the bulk of code that doesn't care about the
> types doesn't get its compilation fractionally slowed by having
> to parse the typedef anyway. In general I think we're drifting
> towards "have each .c file get fewer things automatically" rather
> than otherwise (eg more finely focused files rather than stuffing
> everything into qemu-common.h).

Yes.  See also "Our use of #include is undisciplined, and what to do
about it"
Message-ID: <87wpp4m6n1.fsf@blackfin.pond.sub.org>
https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg03271.html

I have some unfinished work towards emptying out qemu-common.h.  Need
to find the time to finish it.

[...]
