Received: from eggs.gnu.org ([2001:4830:134:3::10]:39610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUK13-0006k9-Ht
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUK0y-0007Cw-ML
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:45:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUK0y-0007Ch-G0
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:45:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id c24so11900766pfe.1
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 14:45:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-18-git-send-email-cota@braap.org>
	<7e81eceb-2a5e-b5cf-6385-4aff70ecc1b2@twiddle.net>
	<20170709211423.GD32582@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fe6e3d5b-3856-5c6b-301b-1334cf673434@twiddle.net>
Date: Sun, 9 Jul 2017 11:44:10 -1000
MIME-Version: 1.0
In-Reply-To: <20170709211423.GD32582@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/22] tcg: distribute profiling counters
 across TCGContext's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/09/2017 11:14 AM, Emilio G. Cota wrote:
> On Sun, Jul 09, 2017 at 10:45:55 -1000, Richard Henderson wrote:
>> On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
>>> +    /* includes aborted translations because of exceptions */
>>> +    atomic_set(&prof->tb_count1, prof->tb_count1 + 1);
>>
>> Again, atomic_set without atomic_read is pointless.
>> Either you're trying to give the compiler extra information, or you aren't.
> 
> See my comment to patch 3.

I still disagree.  It's Just Plain Confusing.

You'll continue to get questions like this from me and other reviewers in 
future.  And it's not like avoiding atomic_read here makes anything faster. 
Both forms will compile to the same assembler.


r~
