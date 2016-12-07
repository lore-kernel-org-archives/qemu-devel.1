Received: from eggs.gnu.org ([2001:4830:134:3::10]:57216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cEaSV-0006de-7z
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 06:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cEaSS-0005vb-I4
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 06:32:23 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:36635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cEaSS-0005vG-9j
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 06:32:20 -0500
Date: Wed, 7 Dec 2016 06:32:10 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1246561763.1891130.1481110330525.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA8tnP5_annrApB2O_ZUXvc7HXM7+K1XOsPUVqrU6hHLeA@mail.gmail.com>
References: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
	<20161206145104.16048-1-alex.bennee@linaro.org>
	<CAFEAcA8tnP5_annrApB2O_ZUXvc7HXM7+K1XOsPUVqrU6hHLeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] exec.c: simplify the breakpoint
 invalidation logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Bug 1647683 <1647683@bugs.launchpad.net>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:Overall" <qemu-devel@nongnu.org>


> I think this is the wrong direction. We only need to invalidate
> the TBs for the specific location the breakpoint is at.
> Even if we for the moment want to apply a big hammer of doing
> a full tb flush on breakpoint to fix this issue for this release,
> we shouldn't drop the indirection through breakpoint_invalidate(),
> because then we can't go back to invalidating just the parts we need
> easily later.

I agree with Peter, but still this patch should be fine for
2.8 and we can revert it when MTTCG locking is merged.

Paolo
