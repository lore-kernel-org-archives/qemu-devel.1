Received: from eggs.gnu.org ([2001:4830:134:3::10]:46873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZm2o-0001wa-Vk
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 19:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZm2i-0001Xi-Ib
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 19:18:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:28348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gZm2h-00016Z-HP
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 19:18:24 -0500
Message-ID: <1545265096.44118.3.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu, 20 Dec 2018 08:18:16 +0800
In-Reply-To: <20181219140136.GJ20465@redhat.com>
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
	<1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
	<20181219140136.GJ20465@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: remove the new CPUID 'PCONFIG'
 from Icelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com, qemu-devel@nongnu.org

On Wed, 2018-12-19 at 14:01 +0000, Daniel P. Berrangé wrote:
> On Wed, Dec 19, 2018 at 09:44:40PM +0800, Robert Hoo wrote:
> > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > ---
> >  target/i386/cpu.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 677a3bd..b6113d0 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2613,8 +2613,7 @@ static X86CPUDefinition builtin_x86_defs[] =
> > {
> >              CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG
> > |
> >              CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
> >          .features[FEAT_7_0_EDX] =
> > -            CPUID_7_0_EDX_PCONFIG | CPUID_7_0_EDX_SPEC_CTRL |
> > -            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> > +            CPUID_7_0_EDX_SPEC_CTRL |
> > CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> >          /* Missing: XSAVES (not supported by some Linux versions,
> >                  * including v4.1 to v4.12).
> >                  * KVM doesn't yet expose any XSAVES state save
> > component,
> 
> This was shipped in QEMU 3.1.0, so I don't think we can
> unconditionally
> remove it like this without breaking CPU model migration compat. 
> 
I think the sooner, the better. Take the time window that Icelake CPU
model has just shipped with QEMU 3.1.0 and is not publicly/widely used
yet.
> 
> Regards,
> Daniel
