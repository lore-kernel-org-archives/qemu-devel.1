Received: from eggs.gnu.org ([2001:4830:134:3::10]:39462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cH9tX-0001km-Pk
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cH9tW-0001Ov-Sn
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:46:55 -0500
Date: Wed, 14 Dec 2016 14:46:44 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161214134644.4jm4sfv42jai732o@kamzik.brq.redhat.com>
References: <20161208175030.12269-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161208175030.12269-1-drjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH kvm-unit-tests v8 00/10] arm/arm64: add gic
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, marc.zyngier@arm.com, andre.przywara@arm.com, eric.auger@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, christoffer.dall@linaro.org

On Thu, Dec 08, 2016 at 06:50:20PM +0100, Andrew Jones wrote:
> 
> v8:
>  - Main change is rebasing to Wei's sysreg framework, which is part
>    of his PMU series, which I've applied to arm/next. That rebase
>    leads to dropping the first two patches of the v7 series, expecting
>    get_mpidr() to return u64 (with future patches), a rework of the
>    delay routines (now based on sysreg framework), and changes to all
>    sysreg asms
>  - The delay routines also got their own files: delay.[ch]
>  - Another bigger change was to now keep gic_common_ops local to
>    lib/arm/gic.c, export the functions from the gic-v[23] instead
>  - Yet another bigger change was dropping the sender and irq cmdline
>    inputs, hard coding to '1' is sufficient and much less code
>  - Other minor changes listed in individual patches   
>

OK, I'm going to go ahead and apply this to arm/next. Before making
the pull request I'll post another series that includes the 64-bit
MPIDR fix that Andre pointed out we need, and a couple other fixes,
though. Assuming nobody complains about that series, then I'll fold
those patches into arm/next too and make the pull request.

Thanks,
drew
