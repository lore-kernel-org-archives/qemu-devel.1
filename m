Received: from eggs.gnu.org ([2001:4830:134:3::10]:33080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxpeT-0002KO-VD
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 04:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxpeQ-0003kz-Q9
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 04:28:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fxpeQ-0003hq-Jh
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 04:28:30 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1536174934-26022-1-git-send-email-wei@redhat.com> (Wei Huang's
	message of "Wed, 5 Sep 2018 15:15:30 -0400")
References: <1536174934-26022-1-git-send-email-wei@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 06 Sep 2018 10:28:20 +0200
Message-ID: <87worz3u8r.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V9 0/4] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, lvivier@redhat.com, drjones@redhat.com, dgilbert@redhat.com

Wei Huang <wei@redhat.com> wrote:
> This patchset adds a migration test for aarch64. It leverages
> Dave Gilbert's migration boot block patches to create a new test case
> for aarch64.
>
> V8->V9:
>  * Remove accel= setting for AArch64. It uses the default "kvm:tcg" now
>  * Revise the header file comment (suggested by drjones)
>  * Name x86 directory to i386 instead of x86_64; change Makefile accordingly
>  * Remove $(ARCH) from the assembly and header file names
>
> V7->V8:
>  * Support cross compilation by searching for CROSS_CC_GUEST option,
>    instead of using the find-cross-prefix defined in roms/Makefile
>  * Use the "max" options for ARM guest VM's CPU and GIC types
>  * $(TARGET)/Makefile rules are rewritten based on Laurent Vivier's comment
>  * NOTE: because Patch 1/2 is re-written, I remove the "Reviewed-by" for
>    reviewers to take a look again. Thanks.
>
> V6->V7:
>  * Define test memory start/end addresses for all architectures
>  * Check aarch64 kernel binary size, limit under 512KB
>
> V5->V6:
>  * Add Reviewed-by to patch 1-3
>  * Add more design notes in patch 4 (aarch64 assembly compilation, bin space)
>
> V4->V5:
>  * Extract cross compilation detection code into rules.mak for sharing
>  * Minor comment and code revision in migration-test.c & aarch64-a-b-kernel.S
>  
> V3->V4:
>  * Rename .s to .S, allowing assembly to include C-style header file
>  * Move test defines into a new migration-test.h file
>  * Use different cpu & gic settings for kvm and tcg modes on aarch64
>  * Clean up aarch64-a-b-kernel.S based on Andrew Jones' comments
>  
> V2->V3:
>  * Convert build script to Makefile
>  * Add cross-compilation support
>  * Fix CPU type for "tcg" machine type
>  * Revise asm code and the compilation process from asm to header file
>
> V1->V2:
>  * Similar to Dave Gilbert's recent changes to migration-test, we
>    provide the test source and a build script in V2.
>  * aarch64 kernel blob is defined as "unsigned char" because the source
>    is now provided in V2.
>  * Add "-machine none" to test_deprecated() because aarch64 doesn't have
>    a default machine type.
>
> RFC->V1:
>  * aarch64 kernel blob is defined as an uint32_t array
>  * The test code is re-written to address a data caching issue under KVM.
>    Tests passed under both x86 and aarch64.
>  * Re-use init_bootfile_x86() for both x86 and aarch64
>  * Other minor fixes

Queued for next Migration PULL request, thanks.

Later, Juan.
