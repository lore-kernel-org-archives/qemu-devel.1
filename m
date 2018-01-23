Received: from eggs.gnu.org ([2001:4830:134:3::10]:35061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ee6ne-0006k9-Nj
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ee6nd-0003sF-SP
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:12:14 -0500
References: <20180118193846.24953-1-laurent@vivier.eu>
	<20180118193846.24953-2-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a6bc9bdb-57cd-4b9d-eb60-0feec05bcbf6@vivier.eu>
Date: Tue, 23 Jan 2018 23:11:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180118193846.24953-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/7] accel/tcg: add size paremeter in
 tlb_fill()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <huth@tuxfamily.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

Le 18/01/2018 à 20:38, Laurent Vivier a écrit :
> The MC68040 MMU provides the size of the access that
> triggers the page fault.
> 
> This size is set in the Special Status Word which
> is written in the stack frame of the access fault
> exception.
> 
> So we need the size in m68k_cpu_unassigned_access() and
> m68k_cpu_handle_mmu_fault().
> 
> To be able to do that, this patch modifies the prototype of
> handle_mmu_fault handler, tlb_fill() and probe_write().
> do_unassigned_access() already includes a size parameter.

I'd like to send a pull request for m68k MMU series, and 68040 MMU
relies on this patch.

If someone disagrees with this change, it's time to say it!

Thanks,
Laurent
