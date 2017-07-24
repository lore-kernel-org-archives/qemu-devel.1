Received: from eggs.gnu.org ([2001:4830:134:3::10]:50959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZeoo-00008L-0r
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZeoj-000075-S4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:58:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZeoj-00006q-LR
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:58:41 -0400
References: <20170719100802.14094-1-berrange@redhat.com>
	<20170719100802.14094-2-berrange@redhat.com>
	<d659c0cb-0cb2-3af7-b97f-05ad15aa3550@redhat.com>
	<ee0b3e06-7037-f2c9-18e9-1fb1dcb0784a@redhat.com>
	<20170724141108.GA11443@redhat.com>
	<d4f1f1c7-ca1f-904b-d23b-f9897b1ee29e@redhat.com>
	<20170724144759.GD11443@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20569a41-8017-f977-aec6-6a7ad8ff7229@redhat.com>
Date: Mon, 24 Jul 2017 16:58:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170724144759.GD11443@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 24/07/2017 16:47, Daniel P. Berrange wrote:
> If it takes more work downstream to undelete & maintain machine
> types in the downstream fork, that means downstream maintainers
> less free time to improve QEMU upstream. From that POV, deleting
> machine types & props upstream is actually counterproductive to
> upstream on balance. The rational thing would thus be to stick
> with status quo, and explicitly cdeclare that upstream will *never*
> delete machine types, or make their lifetime long enough for the
> longest lived downstream (10 years min & by the time we get to
> 10 years, it might even be 15 years). 

Yeah, that makes sense.  At the moment at least Red Hat and Canonical
create custom machine types.  As soon as neither Red Hat nor Canonical
contribute to upstream QEMU, the policy can change.  But honestly, even
though I have an obvious conflict of interest, I see no reason to make
things more complicated for downstreams that are active contributors to
QEMU...

Paolo
