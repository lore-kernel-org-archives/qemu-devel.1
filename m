Received: from eggs.gnu.org ([2001:4830:134:3::10]:55712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cXA4R-00034X-88
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cXA4P-0004hV-R0
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:12:19 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cXA4P-0004h4-LE
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:12:17 -0500
Received: by mail-wm0-x236.google.com with SMTP id c206so148940517wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 09:12:17 -0800 (PST)
References: <147342618684.13303.1583142856242164602.stgit@fimbulvetr.bsc.es>
	<87vaxifx4y.fsf@fimbulvetr.bsc.es>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87vaxifx4y.fsf@fimbulvetr.bsc.es>
Date: Fri, 27 Jan 2017 17:12:14 +0000
Message-ID: <87inp08m1d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/6] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Lluís Vilanova writes:
>
>> This series proposes a generic (target-agnostic) instruction translation
>> framework.
>
>> It basically provides a generic main loop for instruction disassembly, which
>> calls target-specific functions when necessary. This generalization makes
>> inserting new code in the main loop easier, and helps in keeping all targets in
>> synch as to the contents of it.
>
>> I've only ported i386 as an example to get some feedback, but I'm planning on
>> porting ARM next to see how well it fits into the current organization.
>
>> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
>> ---
>
>> Changes in v2
>> =============
>
>> * Port ARM and AARCH64 targets.
>> * Fold single-stepping checks into "max_insns" [Richard Henderson].
>> * Move instruction start marks to target code [Richard Henderson].
>> * Add target hook for TB start.
>> * Check for TCG temporary leaks.
>> * Move instruction disassembly into a target hook.
>> * Make breakpoint_hit() return an enum to accomodate target's needs (ARM).
> [...]
>
> I'm not sure if I CC'd the appropriate people, but I'd like to know if this
> seems like the proper approach to generalizing the main disassembly
> loop.
>
> Every time someone updates a target it becomes a little cumbersome to keep this
> type of patches in synch (for now, only in i386 and arm).

I'm sorry this has been in my review queue so long that it no longer
applies cleanly. However feel free to add me on the next iteration.

My only general comment is I think there is a bit too much churn in the
per-arch changes from re-names that aren't really needed. Aside from
that it would be useful to have an example of something that can be done
more easily in the generic run-loop as part of the series. Otherwise I
find the churn hard to justify.

>
>
> Thanks,
>   Lluis


--
Alex Bennée
