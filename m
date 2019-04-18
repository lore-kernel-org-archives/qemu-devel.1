Received: from eggs.gnu.org ([209.51.188.92]:35331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hH8VH-00031g-L4
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hH8It-0007f6-KW
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:46:21 -0400
Received: from foss.arm.com ([217.140.101.70]:59538)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hH8Ir-0007e0-M4
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:46:18 -0400
Date: Thu, 18 Apr 2019 15:46:11 +0100
From: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190418144611.GJ3567@e103592.cambridge.arm.com>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
	<20190418094634.sr4s4qkzceqftque@kamzik.brq.redhat.com>
	<20190418105204.GF3567@e103592.cambridge.arm.com>
	<20190418112847.4hnafafcxlp4vuou@kamzik.brq.redhat.com>
	<20190418140302.GI3567@e103592.cambridge.arm.com>
	<20190418144306.5sxrbcjbkw2tzslj@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418144306.5sxrbcjbkw2tzslj@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] How do we do user input bitmap properties?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "armbru@redhat.com" <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>

On Thu, Apr 18, 2019 at 03:43:06PM +0100, Andrew Jones wrote:
> On Thu, Apr 18, 2019 at 03:03:02PM +0100, Dave Martin wrote:

[...]

> > It's worth nothing that there are two problems to be solved here: one is
> > to specify an exact set unambiguously, which is important for migration
> > scenarios.
> > 
> > The other is to be able to clamp the vector length for user convenience,
> > but without particularly considering migration.  There's no direct way
> > for the user to know the set of vector lengths supported by KVM today,
> > so cooking up the right magic to go on the command line is non-trivial:
> > you have to create a dummy vcpu and read KVM_REG_ARM64_SVE_VLS to find
> > the host's supported set.  Or you just have to know.
> 
> Right, we'll have to query first to know what's available. libvirt will
> do that and tools built on libvirt should help provide the user with
> sane defaults or a relatively painless selection process. The QEMU command
> line is primarily for developers, so they'll likely just know what they
> want.
> 
> > 
> > A separate max-vl option (or whatever) might be a useful alternative.
> 
> Yeah, we could offer this to be nicer to QEMU command line users that
> don't intend to migrate, or don't care if a migration can fail. This
> would be analogous to '-cpu max' which enables all available cpu
> features. Bad for migration, but a nice shorthand if you want your
> guest to have everything.

Sounds reasonable.

Cheers
---Dave
