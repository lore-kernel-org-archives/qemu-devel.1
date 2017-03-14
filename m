Received: from eggs.gnu.org ([2001:4830:134:3::10]:52984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnpv3-0007JV-PW
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnpv3-0007ZG-1h
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:07:33 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnpv2-0007Y9-Rz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:07:32 -0400
Received: by mail-wr0-x22c.google.com with SMTP id g10so128433260wrg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 10:07:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d9497461-e7c5-b914-362d-16b0cdea9fba@redhat.com>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica> <20170314160113.GM2445@work-vm>
	<20170314162020.GT2652@redhat.com>
	<d9497461-e7c5-b914-362d-16b0cdea9fba@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 18:07:11 +0100
Message-ID: <CAFEAcA-Y=KNBTj32_C1HOuRcEL9vxMimxjPpwrQpG9apGqBjSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Obsolete QEMU host environments (was: Re: KVM call
 for 2017-03-14)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

On 14 March 2017 at 17:54, Thomas Huth <thuth@redhat.com> wrote:
> Our ia64 host backend in QEMU (tcg/ia64) is still marked as maintained
> ... so it's maybe not as dead as you think? Or should we rather get rid
> of that soon, too?

I don't actually mind whether we keep tcg/ia64 or drop it.
But if we keep it then we must have a machine we can test
it on -- that means one I have access to (and which we
can otherwise use for central testing), not just one the
maintainer might happen to have.

Also, that MAINTAINERS entry was added in 2011, so it's
probably about as out of date as the code :-)

thanks
-- PMM
