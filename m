Received: from eggs.gnu.org ([2001:4830:134:3::10]:35860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1chlnJ-0004B6-Kv
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 18:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1chlnG-0002T7-Fa
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 18:30:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:58707)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mmarek@suse.com>) id 1chlnG-0002T1-9H
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 18:30:26 -0500
References: <20170224134411.28882-1-mmarek@suse.com>
	<a634716c-c998-c422-6802-946a283f8837@twiddle.net>
	<a76250b9-ec10-1444-03aa-00ffb8c17fda@suse.com>
From: Michal Marek <mmarek@suse.com>
Message-ID: <e8066022-79d8-a2cd-3334-109cf8ac7d2d@suse.com>
Date: Sun, 26 Feb 2017 00:30:24 +0100
MIME-Version: 1.0
In-Reply-To: <a76250b9-ec10-1444-03aa-00ffb8c17fda@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Miroslav Benes <mbenes@suse.cz>, Eric Bischoff <ebischoff@suse.com>

Dne 25.2.2017 v 21:39 Michal Marek napsal(a):
> Dne 25.2.2017 v 01:05 Richard Henderson napsal(a):
>> On 02/25/2017 12:44 AM, Michal Marek wrote:
>>> +static int do_stfle(CPUS390XState *env, uint64_t addr, int len)
>>> +{
>>> +    S390CPU *cpu = s390_env_get_cpu(env);
>>> +    uint8_t data[64];
>>
>> S390FeatBitmap or S390FeatInit?  Or even a sizeof?
>> Hard coding 64 certainly doesn't seem right.
> 
> I will change it to something more sensible.

I changed it to 2k, which is the maximum that the STFLE instruction can
store. I did not use S390FeatBitmap or S390FeatInit, as the
qemu-internal feature bit assignments differ from the PoO facility bit
assignments.

Michal
