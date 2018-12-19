Received: from eggs.gnu.org ([2001:4830:134:3::10]:54141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZcQ0-0001gg-RM
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZcPu-0006DR-Ox
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:01:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZcPu-0006Cb-GT
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:01:42 -0500
Date: Wed, 19 Dec 2018 14:01:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181219140136.GJ20465@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
	<1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
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
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com, robert.hu@intel.com, qemu-devel@nongnu.org

On Wed, Dec 19, 2018 at 09:44:40PM +0800, Robert Hoo wrote:
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>  target/i386/cpu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 677a3bd..b6113d0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2613,8 +2613,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
>              CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
>          .features[FEAT_7_0_EDX] =
> -            CPUID_7_0_EDX_PCONFIG | CPUID_7_0_EDX_SPEC_CTRL |
> -            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
>          /* Missing: XSAVES (not supported by some Linux versions,
>                  * including v4.1 to v4.12).
>                  * KVM doesn't yet expose any XSAVES state save component,

This was shipped in QEMU 3.1.0, so I don't think we can unconditionally
remove it like this without breaking CPU model migration compat. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
