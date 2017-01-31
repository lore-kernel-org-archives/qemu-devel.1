Received: from eggs.gnu.org ([2001:4830:134:3::10]:60373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYdP1-0007CG-Cy
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYdOx-0000XN-CP
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cYdOx-0000X5-6h
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<20170131165052.GD20303@redhat.com>
Date: Tue, 31 Jan 2017 19:43:31 +0100
In-Reply-To: <20170131165052.GD20303@redhat.com> (Daniel P. Berrange's message
	of "Tue, 31 Jan 2017 16:50:52 +0000")
Message-ID: <87k29boyss.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Tue, Jan 31, 2017 at 04:43:52PM +0200, Michael S. Tsirkin wrote:
>> Some headers use QEMU_BUILD_BUG_ON. This causes a problem
>> if the C file including that header happens to have
>> QEMU_BUILD_BUG_ON at the same line number.
>
> Do we actually hit this problem in practice ?  Even if we do hit the
> problem, it surely has a trivial workaround of just inserting/removing
> a blank line somewhere in the file before the QEMU_BUILD_BUG_ON.
>
> IOW, is it really a benefit to change to use COUNTER, given that it is
> less portable that what we have today ?

__COUNTER__ is the best solution I've seen so far.

The proposed fallback for compilers lacking __COUNTER__ is not quite
correct, but it's relatively unlikely to break, and I'm vanishingly
unlikely to compile with such an old compiler ever again, so I'm okay
with it.  I'd also be okay with making __COUNTER__ support a hard
requirement.

I guess that means:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
