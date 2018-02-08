Received: from eggs.gnu.org ([2001:4830:134:3::10]:39212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejqgB-0005z3-52
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejqg6-0007rg-L9
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:12:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ejqg6-0007qb-FK
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:12:10 -0500
Date: Thu, 8 Feb 2018 16:12:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180208181207.GB13981@localhost.localdomain>
References: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_DEDICATED hint CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Thu, Feb 08, 2018 at 05:44:20PM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Add PV_DEDICATED hint cpuid feature bit.
> 
[...]
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d70954b..cf48931 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4076,6 +4076,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>              x86_cpu_get_supported_feature_word(w, false);
>          uint32_t requested_features = env->features[w];
>          env->features[w] &= host_feat;
> +        if (cpu->pv_dedicated && (w == FEAT_KVM)) {
> +            env->features[w] |= CPUID_PV_DEDICATED;
> +        }

Why do this trick here instead of just adding "pv-dedicated" to
feature_word_info[FEAT_KVM].feat_names?

> [...]

-- 
Eduardo
