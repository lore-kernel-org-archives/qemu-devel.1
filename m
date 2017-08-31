Received: from eggs.gnu.org ([2001:4830:134:3::10]:40799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKb1-00023k-LL
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKax-00027R-M2
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:13:03 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dnKax-000279-Eh
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:12:59 -0400
Received: by mail-wr0-x244.google.com with SMTP id 40so5212873wrv.3
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 01:12:59 -0700 (PDT)
Date: Thu, 31 Aug 2017 09:12:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170831081256.GE13619@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-10-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-10-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/13] hvf: refactor cpuid code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 03:26:58AM -0500, Sergio Andres Gomez Del Real wrote:
> @@ -613,6 +614,15 @@ static uint32_t xsave_area_size(uint64_t mask)
>      return ret;
>  }
>  
> +static inline bool accel_uses_host_cpuid(void)
> +{
> +    if (kvm_enabled() || hvf_enabled()) {
> +        return true;
> +    } else {
> +        return false;
> +    }

Shorter equivalent:

  return kvm_enabled() || hvf_enabled();

> @@ -2396,6 +2427,7 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
>      }
>  
>      /* Special cases not set in the X86CPUDefinition structs: */
> +    /* TODO: implement for hvf */

This patch has several todos.  What is missing?  What is the impact of
silently skipping this for hvf?
