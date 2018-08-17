Received: from eggs.gnu.org ([2001:4830:134:3::10]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqh62-0006wk-QU
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqh5z-0002oQ-LP
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:55:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqh5z-0002nx-Ff
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:55:27 -0400
Date: Fri, 17 Aug 2018 12:55:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180817155524.GF15372@localhost.localdomain>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-2-git-send-email-robert.hu@linux.intel.com>
	<f859ae02-015a-5ef8-66b4-f54a630d1f5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f859ae02-015a-5ef8-66b4-f54a630d1f5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] x86: Data structure changes to
 support MSR based features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, robert.hu@intel.com, jingqi.liu@intel.com

On Fri, Aug 17, 2018 at 05:50:15PM +0200, Paolo Bonzini wrote:
> On 10/08/2018 16:06, Robert Hoo wrote:
> > +typedef enum FeatureWordType {
> > +   CPUID_FEATURE_WORD,
> > +   MSR_FEATURE_WORD,
> > +} FeatureWordType;
> 
> This enum probably should be defined with QAPI, so that it can be reused
> in the feature-words property:
> 
> # @X86CPUFeatureWordType:
> #
> # Kinds of X86 CPU feature words
> #
> # @cpuid: A CPUID leaf
> #
> # @msr: An MSR
> ##
> { 'enum': 'X86CPUFeatureWordType',
>   'data': 'cpuid', 'msr' }
> 
> The names will be X86_CPU_FEATURE_WORD_TYPE_CPUID and
> X86_CPU_FEATURE_WORD_TYPE_MSR.

I wouldn't like to make this an external API unless really
necessary.  I would rather deprecate the "feature-words" property
because nobody ended up using it.

-- 
Eduardo
