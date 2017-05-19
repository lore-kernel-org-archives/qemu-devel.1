Received: from eggs.gnu.org ([2001:4830:134:3::10]:60604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBnmb-0007F6-Px
	for qemu-devel@nongnu.org; Fri, 19 May 2017 15:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBnmX-0005mT-Qi
	for qemu-devel@nongnu.org; Fri, 19 May 2017 15:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dBnmX-0005mJ-Jq
	for qemu-devel@nongnu.org; Fri, 19 May 2017 15:41:49 -0400
Date: Fri, 19 May 2017 16:41:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170519194146.GC22043@thinpad.lan.raisama.net>
References: <20170509132736.10071-1-berrange@redhat.com>
	<040c1e25-224f-1a8a-9f60-7238e6ad5df6@twiddle.net>
	<20170509141336.GF27432@redhat.com>
	<7132960a-9a76-b8ee-ec15-f3cfe58a29c1@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7132960a-9a76-b8ee-ec15-f3cfe58a29c1@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Support CPUID signature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Tue, May 09, 2017 at 07:18:07AM -0700, Richard Henderson wrote:
> On 05/09/2017 07:13 AM, Richard W.M. Jones wrote:
> > On Tue, May 09, 2017 at 07:05:51AM -0700, Richard Henderson wrote:
> > > > Daniel P. Berrange (2):
> > > >    i386: rewrite way CPUID index is validated
> > > >    i386: expose "TCGTCGTCGTCG" in the 0x40000000 CPUID leaf
> > > 
> > > I probably should have commented earlier but...  what's the point?
> > > 
> > > If you want the guest os to actually do anything with this, what do
> > > you gain for advertising TCG over KVM?
> > 
> > I can see this being useful from virt-what, since it would allow
> > vendors to diagnose problems being caused by TCG ...
> 
> Thanks, that's an excellent point.

Richard, Paolo: I would like to merge this. Do you agree?

-- 
Eduardo
