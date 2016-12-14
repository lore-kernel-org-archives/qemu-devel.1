Received: from eggs.gnu.org ([2001:4830:134:3::10]:36499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHBcZ-0005JW-Ho
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHBcV-0004Ac-Kl
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:37:31 -0500
Received: from mail-wj0-f176.google.com ([209.85.210.176]:33471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHBcV-000470-EC
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:37:27 -0500
Received: by mail-wj0-f176.google.com with SMTP id xy5so39627710wjc.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 07:37:04 -0800 (PST)
References: <20161208175030.12269-1-drjones@redhat.com>
	<20161214134644.4jm4sfv42jai732o@kamzik.brq.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161214134644.4jm4sfv42jai732o@kamzik.brq.redhat.com>
Date: Wed, 14 Dec 2016 15:36:01 +0000
Message-ID: <871sxattem.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, marc.zyngier@arm.com, andre.przywara@arm.com, eric.auger@redhat.com, pbonzini@redhat.com, christoffer.dall@linaro.org


Andrew Jones <drjones@redhat.com> writes:

> On Thu, Dec 08, 2016 at 06:50:20PM +0100, Andrew Jones wrote:
>>
>> v8:
>>  - Main change is rebasing to Wei's sysreg framework, which is part
>>    of his PMU series, which I've applied to arm/next. That rebase
>>    leads to dropping the first two patches of the v7 series, expecting
>>    get_mpidr() to return u64 (with future patches), a rework of the
>>    delay routines (now based on sysreg framework), and changes to all
>>    sysreg asms
>>  - The delay routines also got their own files: delay.[ch]
>>  - Another bigger change was to now keep gic_common_ops local to
>>    lib/arm/gic.c, export the functions from the gic-v[23] instead
>>  - Yet another bigger change was dropping the sender and irq cmdline
>>    inputs, hard coding to '1' is sufficient and much less code
>>  - Other minor changes listed in individual patches
>>
>
> OK, I'm going to go ahead and apply this to arm/next. Before making
> the pull request I'll post another series that includes the 64-bit
> MPIDR fix that Andre pointed out we need, and a couple other fixes,
> though. Assuming nobody complains about that series, then I'll fold
> those patches into arm/next too and make the pull request.

All looks good for me. I'll be re-basing my TCG tests once upstream has
these changes merged.

--
Alex Bennée
