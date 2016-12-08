Received: from eggs.gnu.org ([2001:4830:134:3::10]:59282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cF2pf-00017w-5p
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cF2pc-0003qR-5S
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:50:11 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cF2pc-0003q1-0M
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:50:08 -0500
Received: by mail-qt0-f195.google.com with SMTP id n34so49711641qtb.3
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 09:50:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-24-git-send-email-rth@twiddle.net>
	<8760muz6bu.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <121c5948-5cab-f4b7-d88b-0fe4d689c474@twiddle.net>
Date: Thu, 8 Dec 2016 09:49:04 -0800
MIME-Version: 1.0
In-Reply-To: <8760muz6bu.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 23/64] tcg: Allow an operand to be
 matching or a constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 12/08/2016 09:19 AM, Alex Bennée wrote:
>
> Richard Henderson <rth@twiddle.net> writes:
>
>> This allows an output operand to match an input operand
>> only when the input operand needs a register.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>
> It's hard to offer anything more than a mechanical review for this as
> the constraints aren't intuitive to me (I guess not as a gcc hacker!).

It's even more confusing for a gcc hacker, as we don't have a concept of 
alternatives.  You get one set of constraints.

> Could we either expand the documentation of constraints in tcg/README
> with a summary of the global ones?

There's only one global constraint: 'i'.  So... sure, but I don't know how much 
that will help.

> Should there be a one to one mapping of textual constraint descriptions
> to the TCG_CT_FOO defines?

After the entire patch set, there is *not* a 1-1 mapping.  I dispense with that 
in the i386 backend.

> I'm finding it hard to figure out why the
> text->bitfield step is needed. Is it something to do with the merging of
> generic TCG op constraints with their backend counterparts?

It isn't really needed.  I've been considering different ways to get rid of 
that step.  Indeed, to take the whole backend and make it more tabular; make it 
verifiable as a compile-time step; make such data as can be read-only.

But what we have is what we have, for now.


r~

>
> Anyway:
>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
