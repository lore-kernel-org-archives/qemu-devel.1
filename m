Received: from eggs.gnu.org ([2001:4830:134:3::10]:34377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHPOP-0003UY-Ky
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHPOH-0007Uj-Sk
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHPOH-00078U-ID
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:28:45 -0400
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-5-cota@braap.org> <87zhuw90eu.fsf@linaro.org>
	<20181029213927.GA19216@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bae4de31-20da-c2c9-a3cf-e8e0b06a9a63@redhat.com>
Date: Tue, 30 Oct 2018 09:28:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181029213927.GA19216@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 05/71] cpu: move run_on_cpu to cpus-common
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On 29/10/2018 22:39, Emilio G. Cota wrote:
> I'm not convinced about adding an "assert(!user-mode)" to run_on_cpu.
> Given that now it does not depend on the BQL, it could actually
> work in user-mode if called. If we really wanted to make sure
> that no user-mode would call it, then a compile-time check
> would be better than an assert. But again, I fail to see what
> we'd gain from that.
> 
> For context, do_run_on_cpu et al. were moved to cpus-common.c by
> d148d90ee8 ("cpus-common: move CPU work item management to
> common code", 2016-09-27). The point was to consolidate the
> run-on-cpu code in a common (softmmu & user-mode) file, since
> user-mode needed async_run_on_cpu for exclusive work.
> 
> Now we can finally make run_on_cpu generic as well.

I agree, the run_on_cpu stuff should not be system-specific at all.

Paolo
