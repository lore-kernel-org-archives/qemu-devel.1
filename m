Received: from eggs.gnu.org ([2001:4830:134:3::10]:36225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZxn1-0006YL-Mq
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZxmy-0002l5-FS
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:50:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:27668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gZxmy-0002jt-1W
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:50:56 -0500
Message-ID: <1545310252.44118.5.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu, 20 Dec 2018 20:50:52 +0800
In-Reply-To: <e1b012da-7aac-1063-35ae-0ab3c4c5eb4b@redhat.com>
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
	<1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
	<20181219140136.GJ20465@redhat.com>
	<1545265096.44118.3.camel@linux.intel.com>
	<e1b012da-7aac-1063-35ae-0ab3c4c5eb4b@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com, qemu-devel@nongnu.org

On Thu, 2018-12-20 at 13:38 +0100, Paolo Bonzini wrote:
> On 20/12/18 01:18, Robert Hoo wrote:
> > On Wed, 2018-12-19 at 14:01 +0000, Daniel P. Berrangé wrote:
> > > On Wed, Dec 19, 2018 at 09:44:40PM +0800, Robert Hoo wrote:
> > > > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > > > ---
> > > >  target/i386/cpu.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index 677a3bd..b6113d0 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -2613,8 +2613,7 @@ static X86CPUDefinition
> > > > builtin_x86_defs[] =
> > > > {
> > > >              CPUID_7_0_ECX_AVX512VNNI |
> > > > CPUID_7_0_ECX_AVX512BITALG
> > > > > 
> > > > 
> > > >              CPUID_7_0_ECX_AVX512_VPOPCNTDQ |
> > > > CPUID_7_0_ECX_LA57,
> > > >          .features[FEAT_7_0_EDX] =
> > > > -            CPUID_7_0_EDX_PCONFIG | CPUID_7_0_EDX_SPEC_CTRL |
> > > > -            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> > > > +            CPUID_7_0_EDX_SPEC_CTRL |
> > > > CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> > > >          /* Missing: XSAVES (not supported by some Linux
> > > > versions,
> > > >                  * including v4.1 to v4.12).
> > > >                  * KVM doesn't yet expose any XSAVES state save
> > > > component,
> > > 
> > > This was shipped in QEMU 3.1.0, so I don't think we can
> > > unconditionally
> > > remove it like this without breaking CPU model migration compat. 
> > > 
> > 
> > I think the sooner, the better. Take the time window that Icelake
> > CPU
> > model has just shipped with QEMU 3.1.0 and is not publicly/widely
> > used
> > yet.
> 
> We should still leave it in the 3.1 machine types.  I've just sent a
> patch to do the same with MPX.
> 
I took a look your patch of "Disable MPX support on named CPU models".
Seems you do the same as I do to PCONFIG. So you agree with my above
patch?:-)

I won't object that keep it in 3.1 machine type as you do to MPX.

> Paolo
> 
