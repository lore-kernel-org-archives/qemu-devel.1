Received: from eggs.gnu.org ([2001:4830:134:3::10]:39668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQSZH-0004Pw-Gk
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 03:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQSZD-0006qo-97
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 03:09:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQSZC-0006q8-VS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 03:09:11 -0400
Date: Wed, 6 Jun 2018 15:09:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180606070903.GD7815@xz-mi>
References: <20180605131944.14649-1-peterx@redhat.com>
	<20180605131944.14649-4-peterx@redhat.com>
	<CAFEAcA_hVW6d04frBW=Szz4JTsdhnjC_v-v7Kt_zZ-y8uoCyrw@mail.gmail.com>
	<20180605142655.GI9216@xz-mi>
	<CAFEAcA_AT7a2KiXGKpvaJFwpkkn8x2uNuOgjPXAm=rgjFLCMWg@mail.gmail.com>
	<20180606065629.GC7815@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606065629.GC7815@xz-mi>
Subject: Re: [Qemu-devel] [RFC 3/3] memory: introduce
 IOMMU_NOTIFIER_USER_[UN]SET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Alex Williamson <alex.williamson@redhat.com>

On Wed, Jun 06, 2018 at 02:56:29PM +0800, Peter Xu wrote:

[...]

> > The patches you've
> > sent here seem to me to be adding extra complexity to the
> > notifier API and the core code which isn't required in
> > the patch set that I sent.
> 
> Again I didn't really understand the problem behind before.  Now I
> don't think it's important on whether we'll need to introduce new
> notifier flags, I wanted to know whether we can avoid introducing
> IOMMU index into memory API. Let's just ignore this patch.  Sorry for
> that confusion.

For this part, I'd say of course this is based on the assumption that
the IOMMU index might not help much with non-tcg use cases.  If
someone could help me understand better on how that could help in
general to memory API then I would be much appreciated, since it
really confused me even until today (and I can't see a good way at
least for VT-d to leverage that idea).  Thanks,

-- 
Peter Xu
