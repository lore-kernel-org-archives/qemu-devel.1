Received: from eggs.gnu.org ([2001:4830:134:3::10]:53695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1cHKvd-0005yv-CN
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1cHKvZ-0006Ne-FW
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:33:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:39306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1cHKvZ-0006Ms-60
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:33:45 -0500
Date: Thu, 15 Dec 2016 09:33:55 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20161215013355.GK7435@yi.y.sun>
References: <1481683803-10051-1-git-send-email-yi.y.sun@linux.intel.com>
	<50856580-9978-8a5d-e424-ca989b246a8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50856580-9978-8a5d-e424-ca989b246a8b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: Add Intel SHA_NI instruction
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com, chao.p.peng@intel.com

On 16-12-14 13:17:12, Paolo Bonzini wrote:
> 
> 
> On 14/12/2016 03:50, Yi Sun wrote:
> > Add SHA_NI feature bit. Its spec can be found at:
> > https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
> > 
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > ---
> >  target-i386/cpu.c | 2 +-
> >  target-i386/cpu.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target-i386/cpu.c b/target-i386/cpu.c
> > index de1f30e..993f825 100644
> > --- a/target-i386/cpu.c
> > +++ b/target-i386/cpu.c
> > @@ -422,7 +422,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >              "avx512f", "avx512dq", "rdseed", "adx",
> >              "smap", "avx512ifma", "pcommit", "clflushopt",
> >              "clwb", NULL, "avx512pf", "avx512er",
> > -            "avx512cd", NULL, "avx512bw", "avx512vl",
> > +            "avx512cd", "sha-ni", "avx512bw", "avx512vl",
> >          },
> >          .cpuid_eax = 7,
> >          .cpuid_needs_ecx = true, .cpuid_ecx = 0,
> > diff --git a/target-i386/cpu.h b/target-i386/cpu.h
> > index c605724..d0bf624 100644
> > --- a/target-i386/cpu.h
> > +++ b/target-i386/cpu.h
> > @@ -621,6 +621,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
> >  #define CPUID_7_0_EBX_AVX512PF (1U << 26) /* AVX-512 Prefetch */
> >  #define CPUID_7_0_EBX_AVX512ER (1U << 27) /* AVX-512 Exponential and Reciprocal */
> >  #define CPUID_7_0_EBX_AVX512CD (1U << 28) /* AVX-512 Conflict Detection */
> > +#define CPUID_7_0_EBX_SHA_NI   (1U << 29) /* SHA1/SHA256 Instruction Extensions */
> >  #define CPUID_7_0_EBX_AVX512BW (1U << 30) /* AVX-512 Byte and Word Instructions */
> >  #define CPUID_7_0_EBX_AVX512VL (1U << 31) /* AVX-512 Vector Length Extensions */
> >  
> > 
> 
> Looks good, thanks.
> 
> Paolo

Thank you! :)

BRs,
Sun Yi
