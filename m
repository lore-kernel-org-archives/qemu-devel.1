Received: from eggs.gnu.org ([2001:4830:134:3::10]:38664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1esuxe-0007VB-FI
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1esuxZ-0002cC-FH
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:35:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1esuxZ-0002bC-Ah
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:35:41 -0500
References: <20180228180215.25470-1-wei@redhat.com>
	<20180228180215.25470-2-wei@redhat.com>
	<ca21f795-dae7-d6b5-44f1-ef8ba792ac04@redhat.com>
	<20180305110122.GD3131@work-vm>
	<20180305133654.7aokepvzcmxhzk4q@kamzik.brq.redhat.com>
	<20180305135244.GJ3131@work-vm>
	<868c6039-35fb-16cb-67bb-39cee11e8118@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <28739cac-ad18-a46d-23b0-fef9458da75e@redhat.com>
Date: Mon, 5 Mar 2018 19:35:28 +0100
MIME-Version: 1.0
In-Reply-To: <868c6039-35fb-16cb-67bb-39cee11e8118@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 1/4] rules: Move cross compilation auto
 detection functions to rules.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

On 05/03/2018 18:59, Wei Huang wrote:
...
> 
> SLO build actually is OK if we don't move the cross-compile stuff to the
> generic rules.mak.
> 
> So this cross-compile approach has lots of objection (unclean, broken
> rom build etc.). A complete solution will make this patchset bloated,
> which is diverted away from original purpose of migration-test.
> 
> Dave & Drew: will the following be acceptable?
> 
> 1. Still use Makefile for .s->.h compilation
> 2. In Makefile, we don't support cross-compilation. This avoids
> duplicating the cross-compile detection code at all. Whoever really
> wants to re-generate .h file must be avid programmers. They can either
> find a native machine or fix Makefile themselves.
> 3. The cross-compile re-factoring will become a separate patchset. In
> that patchset, both ROM and migration-test Makefiles will be changed to
> support cross compilation.
> 
> Thoughts?

I agree with Peter: I think an improvement would be to detect/configure
cross-compilers at the configure level, not in the Makefile.

thanks,
Laurent
