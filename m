Received: from eggs.gnu.org ([209.51.188.92]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1hEsFZ-0002rp-3k
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1hEsFX-0003Wi-Ha
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1hEsFX-0003WA-89
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:13:31 -0400
Date: Fri, 12 Apr 2019 11:13:26 +0200
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20190412091326.GE16137@beluga.usersys.redhat.com>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
	<7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
	<869394fb-7b3d-cc01-7329-e931a260e73c@redhat.com>
	<20190412081912.GC16137@beluga.usersys.redhat.com>
	<77338015-015c-aaef-d522-11cabbba4214@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77338015-015c-aaef-d522-11cabbba4214@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Laszlo Ersek <lersek@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Fri, Apr 12, 2019 at 10:26:45AM +0200, Paolo Bonzini wrote:
> On 12/04/19 10:19, Erik Skultety wrote:
> >> Since this field is not specific to guest configuration, I don't think
> >> it belongs in query-sev-capabilities; QEMU does not care about >1 guest.
> > Neither pdh nor cert-chain are specific to the guest config.
>
> Sort of, they are required to start a guest, aren't they?  But the

Unless you're interested in the measurement, aka attestation, I don't think
those are required in any way.

Erik

> number of guests is irrelevant.
>
> > I see why this
> > should be better suited for query-sev, the same goes for libvirt - I think we
> > shouldn't have gone with reporting the SEV platform caps in domain capabilities,
> > we should have IMHO report it both in the host capabilities (platform specific
> > stuff) and in domain capabilities to indicate that both libvirt and QEMU
> > support the SEV feature. Having said that, we have a precedent which I think
> > we might be better off with following rather than splitting the information
> > among multiple commands.
>
> For Libvirt, sure.  But I think this doesn't belong in QEMU at all.
> Libvirt should just use CPUID.
>
> Paolo
