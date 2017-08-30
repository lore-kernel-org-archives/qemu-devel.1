Received: from eggs.gnu.org ([2001:4830:134:3::10]:48763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dn4Du-0005Iz-Vs
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dn4Dp-0006NG-8t
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:44:07 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:37741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dn4Dp-0006M6-5W
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:44:01 -0400
Received: by mail-it0-x243.google.com with SMTP id p2so1169707ite.4
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 07:43:59 -0700 (PDT)
MIME-Version: 1.0
Sender: bobby.prani@gmail.com
In-Reply-To: <20170829211649.GA9108@flamenco>
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-2-git-send-email-cota@braap.org>
	<CAJhHMCBpo1-6x9wJWE2oSv1RB=vH-WbA0RjMWYox_dtFfLAURA@mail.gmail.com>
	<20170829211649.GA9108@flamenco>
From: Pranith Kumar <bobby.prani+qemu@gmail.com>
Date: Wed, 30 Aug 2017 10:43:28 -0400
Message-ID: <CAJhHMCAwpMHAiOeBZ+F2c0yKFPQxU3nU7+FGf75wOqFnYEc43w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Tue, Aug 29, 2017 at 5:16 PM, Emilio G. Cota <cota@braap.org> wrote:
> On Sun, Aug 27, 2017 at 18:15:50 -0400, Pranith Kumar wrote:
>> Hi Emilio,
>>
>> On Fri, Jul 21, 2017 at 1:59 AM, Emilio G. Cota <cota@braap.org> wrote:
>> > This will enable us to decouple code translation from the value
>> > of parallel_cpus at any given time. It will also help us minimize
>> > TB flushes when generating code via EXCP_ATOMIC.
>> >
>> > Note that the declaration of parallel_cpus is brought to exec-all.h
>> > to be able to define there the "curr_cflags" inline.
>> >
>> > Signed-off-by: Emilio G. Cota <cota@braap.org>
>>
>> I was testing a winxp image today and I bisected a infinite loop to
>> this commit. The loop happens both with and without mttcg, so I think
>> it has got to do with something else.
>
> Can you test the below? It lets me boot ubuntu, otherwise it reliably
> chokes on a 'rep movsb' *very* early (doesn't even get to grub).
>
> This discusson on v2 might be relevant (I added CF_COUNT_MASK as a
> result of it, but it seems I have to revisit that):
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06456.html
>
> Anyway let me know if this fixes it for you. Thanks for testing!
>

Yes, this fixes the issue for me.

Thanks,
--
Pranith
