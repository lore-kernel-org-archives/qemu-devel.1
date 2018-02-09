Received: from eggs.gnu.org ([2001:4830:134:3::10]:35042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFFA-000822-69
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFF7-0000iv-0Z
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:26:00 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:45387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFF6-0000h2-OV
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:25:56 -0500
Received: by mail-pg0-x242.google.com with SMTP id m136so4339939pga.12
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:25:56 -0800 (PST)
References: <20180209195239.16048-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e5a015f2-f53d-8383-ba8b-5d7cea87dae7@linaro.org>
Date: Fri, 9 Feb 2018 12:25:52 -0800
MIME-Version: 1.0
In-Reply-To: <20180209195239.16048-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/3] cpus: single-threaded TCG CPU
 creation improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 02/09/2018 11:52 AM, David Hildenbrand wrote:
> While looking into CPU hotplug for s390x TCG, I noticed that
> single-threaded TCG does not properly inititalize CPUs > 1. Fix this
> and cleanup the code a bit.
> 
> David Hildenbrand (3):
>   cpus: properly inititalize CPU > 1 under single-threaded TCG
>   cpus: wait for CPU creation at central place
>   cpus: CPU threads are always created initially for one CPU only
> 
>  cpus.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
