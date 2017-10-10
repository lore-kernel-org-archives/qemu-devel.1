Received: from eggs.gnu.org ([2001:4830:134:3::10]:39009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1jGU-0001EU-5q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1jGR-0003UD-2f
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:23:22 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:52494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1jGQ-0003Ts-Q8
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:23:18 -0400
Received: by mail-pf0-x22f.google.com with SMTP id a1so12299026pfj.9
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 18:23:18 -0700 (PDT)
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-2-git-send-email-cota@braap.org>
	<CAJhHMCBpo1-6x9wJWE2oSv1RB=vH-WbA0RjMWYox_dtFfLAURA@mail.gmail.com>
	<20170829211649.GA9108@flamenco>
	<CAJhHMCAwpMHAiOeBZ+F2c0yKFPQxU3nU7+FGf75wOqFnYEc43w@mail.gmail.com>
	<20170922204018.GA23631@flamenco>
	<00656f91-760f-c46f-86dc-6c0d29192b3b@linaro.org>
	<20171005232416.GA23670@flamenco> <20171009192455.GA27135@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ea4fb2af-fcea-b832-dbfd-32b3da2a63a3@linaro.org>
Date: Mon, 9 Oct 2017 18:23:14 -0700
MIME-Version: 1.0
In-Reply-To: <20171009192455.GA27135@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/43] tcg: define CF_PARALLEL and use
 it for TB hashing along with CF_COUNT_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 10/09/2017 12:24 PM, Emilio G. Cota wrote:
> On Thu, Oct 05, 2017 at 19:24:16 -0400, Emilio G. Cota wrote:
>> I'm including the fixups below.
> 
> Just pushed v5 of this series. I rebased the series on top of the current master,
> and added the already mentioned fixes plus a new one (see below).
> 
> Grab the patches from:
>   https://github.com/cota/qemu/tree/multi-tcg-v5

Thanks.  I was just about to do this rebase myself.

> Changes since v4:
> - Rebase to current master. (fixed a few conflicts, mostly due to some targets
>   having been converted to the generic translation loop.)
> - Add the removal of CF_COUNT_MASK as a separate "FIXUP" commit to signal
>   that this still requires attention.
> - Fix tb TC comparison function to support deletions (otherwise -icount breaks)
> - [new fix] TCG regions: Rely on max_cpus instead of smp_cpus. Otherwise we'd
>   break CPU hotplug on targets that support it. (max_cpus and smp_cpus are
>   set from the command line with -smp foo,maxcpus=bar; max_cpus is always
>   >= smp_cpus.)

Excellent.  I'll work on reviewing these changes this week.
In the meantime, I've cherry-picked about half of the patch set.


r~
