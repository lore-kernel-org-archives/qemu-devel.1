Received: from eggs.gnu.org ([208.118.235.92]:50628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gbHzm-0000VR-OB
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 23:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gbHzm-0007es-0h
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 23:37:38 -0500
Message-ID: <1545626239.44118.14.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Mon, 24 Dec 2018 12:37:19 +0800
In-Reply-To: <588440e5-7fb2-7404-935e-f61c22c83b16@redhat.com>
References: <20181221063002.7570-1-pbonzini@redhat.com>
	<cb7a9fc9-cded-7ca5-dbb9-8ffde9670fa7@redhat.com>
	<faa89439-18ae-931b-54c7-212b7dea0e48@redhat.com>
	<1545440514.44118.11.camel@linux.intel.com>
	<588440e5-7fb2-7404-935e-f61c22c83b16@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] i386: remove the 'INTEL_PT' CPUID bit from
 named CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, luwei.kang@intel.com
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, qemu-stable@nongnu.org

On Sat, 2018-12-22 at 10:13 +0100, Paolo Bonzini wrote:
> On 22/12/18 02:01, Robert Hoo wrote:
> > On Fri, 2018-12-21 at 16:27 +0100, Paolo Bonzini wrote:
> > > On 21/12/18 16:22, Philippe Mathieu-Daudé wrote:
> > > > Hi Paolo,
> > > > 
> > > > On 12/21/18 7:30 AM, Paolo Bonzini wrote:
> > > > > From: Robert Hoo <robert.hu@linux.intel.com>
> > > > > 
> > > > > Processor tracing is not yet implemented for KVM and it will
> > > > > be
> > > > > an
> > > > > opt in feature requiring a special module parameter.
> > > > > Disable it, because it is wrong to enable it by default and
> > > > > it is impossible that no one has ever used it.
> > > > > 
> > > > > Cc: qemu-stable@nongnu.org
> > > > 
> > > > Does this patch misses Robert S-o-b?
> > > > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > 
> > Paolo's right. It didn't come from me.
> > > 
> > > No, the author is wrong, it should be me.  "git commit -c"
> > > apparently
> > > copies the author from the original commit.
> > > 
> > > Paolo
> > 
> > Hi Paolo, would you hold on INTEL_PT removal for a moment? I think
> > I
> > need Luwei's double confirm.
> 
> I'm aware of Luwei's patches, they will be in 4.21.  As mentioned in
> the
> commit message, they will be an opt-in feature, not enabled by
> default;
> the default is system-wide tracing and no INTEL_PT CPUID bit
> available
> in the guest.
> 
OK, synced with Luwei, agree with you.

> Paolo
