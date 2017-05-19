Received: from eggs.gnu.org ([2001:4830:134:3::10]:49858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dBjMO-0008Gr-DG
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dBjMJ-0006Mp-II
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:58:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1dBjMJ-0006MX-BT
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:58:27 -0400
Date: Fri, 19 May 2017 16:58:23 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170519145823.lqttcuwxxnj7s2lk@eukaryote>
References: <20170509132736.10071-1-berrange@redhat.com>
	<20170509132736.10071-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509132736.10071-2-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] i386: rewrite way CPUID index is
 validated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, May 09, 2017 at 02:27:35PM +0100, Daniel P. Berrange wrote:
> Change the nested if statements into a flat format, to make
> it clearer what validation / capping is being performed on
> different CPUID index values.
> 
> NB this changes behaviour when "index > env->cpuid_xlevel2".
> This won't have any guest-visible effect because no there is
> no CPUID[0xC0000001]

Nit: When applying, maybe the maintainer could fix the typo:

"because no there is no" -> "because there is no"

> feature supported by TCG, and KVM code
> will never call cpu_x86_cpuid() with such an index value.
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  target/i386/cpu.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 

[...]

-- 
/kashyap
