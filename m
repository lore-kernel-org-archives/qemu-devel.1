Received: from eggs.gnu.org ([2001:4830:134:3::10]:58647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fs2Gp-0005lD-RB
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fs2Gm-000385-3G
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:44:11 -0400
Date: Tue, 21 Aug 2018 10:44:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180821104400.473d2951.cohuck@redhat.com>
In-Reply-To: <3e2a3c5f-bab4-0a15-a34a-3e4423c37024@redhat.com>
References: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
	<3e2a3c5f-bab4-0a15-a34a-3e4423c37024@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] Some improvements in z/Arch
 instructions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, richard.henderson@linaro.org

On Tue, 21 Aug 2018 09:56:33 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 21.08.2018 04:50, Pavel Zbitskiy wrote:
> > Found while attempting to run an old tool in qemu.
> > 
> > * BAL and BALR:    Added.
> > * CSST:            Qemu crashed after an accidental jump to garbage.
> > * IPM:             A tool produced an incorrect output.
> > * EX TRT/TRTR:     A tool ran quite slow.
> > * PACK:            A tool produced an incorrect output.
> > * CVB, CVBY, CVBG: Added.
> >   
> 
> Thanks again for the fixes. When you resend patches
> 
> 1. Use "git format-patch ... --subject-prefix="PATCH v2" --cover-letter"
>    in order to include a version number

'-v 2' instead of --subject-prefix is even easier :)

> 
> 2. Try to keep R-bs as part of your patches, so they don't get lost.
> 
> 
> @Conny, can you pick up Patch 1-6? Ran kvm-unit-tests and booted the
> ususal fedora system
> 
> I remember there were some R-by from Thomas.

Yup, will try to track down the R-bs.
