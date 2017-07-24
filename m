Received: from eggs.gnu.org ([2001:4830:134:3::10]:44093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZeJm-00074D-3F
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZeJi-00018f-Pe
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:26:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZeJi-00017z-In
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:26:38 -0400
References: <20170719100802.14094-1-berrange@redhat.com>
	<20170719100802.14094-2-berrange@redhat.com>
	<d659c0cb-0cb2-3af7-b97f-05ad15aa3550@redhat.com>
	<ee0b3e06-7037-f2c9-18e9-1fb1dcb0784a@redhat.com>
	<20170724141108.GA11443@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4f1f1c7-ca1f-904b-d23b-f9897b1ee29e@redhat.com>
Date: Mon, 24 Jul 2017 16:26:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170724141108.GA11443@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/2 (for 2.10)] docs: document support
 lifetime for features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 24/07/2017 16:11, Daniel P. Berrange wrote:
>>> +
>>> +The supported lifetime for versioned machine types is 12 releases,
>>> +which is equivalent to 4 years worth of previous QEMU releases.
>> I think there's still no consensus on this.
>=20
> Indeed, which is exactly why I sent this patch - we need to come up
> with a sensible policy here, so we can stop repeating the same debate
> over & over & over each time some proposes a patch to kill off some
> random old machine type.
>=20
> The 12 release / 4 year figure was a fairly arbitrary starting
> point to which I'd be hoping to see critical reviewer feedback
> on (with possible counterproposals) so we can try to get something
> documented, to put an end to the repeated debates in this area
> each time someone proposes a patch.

I agree.  At the moment, the status is "machine types never die".

We can change it, but I think that we should also make a decision on
whether removing machine types implies removing properties that only
exist for backwards-compatibility reasons.

4 year seems like a long time, but it can actually be pretty taxing for
RHEL.  I'm pretty sure that around RHEL 8.4 (some time between
2020-2022) we'll need a 1.5-ish machine type (2016).

Paolo

>>                                              The first two paragraphs
>> should be added to the documentation for -machine in qemu-options.hx,
>> since "-machine [type=3D]foo" is currently not documented at all.
> I'll happily send a patch for the docs for qemu-options.hx.
