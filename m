Received: from eggs.gnu.org ([2001:4830:134:3::10]:55672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJP9-0003Zh-4B
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJP6-0001ky-21
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:42:35 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:34525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXJP5-0001k8-Sc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:42:31 -0400
Received: by mail-pf0-x233.google.com with SMTP id q85so4674494pfq.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 20:42:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-22-git-send-email-cota@braap.org>
	<05b969cf-a6a0-eb3c-f9ec-0c536dbe9491@twiddle.net>
	<20170718003429.GC7414@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2aaa766f-2554-d1d2-e573-af8eeee54529@twiddle.net>
Date: Mon, 17 Jul 2017 17:42:25 -1000
MIME-Version: 1.0
In-Reply-To: <20170718003429.GC7414@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/45] tcg: check CF_PARALLEL instead of
 parallel_cpus
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

On 07/17/2017 02:34 PM, Emilio G. Cota wrote:
> On Mon, Jul 17, 2017 at 13:55:42 -1000, Richard Henderson wrote:
>> On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
>>> Thereby decoupling the resulting translated code from the current state
>>> of the system.
>>>
>>> The tb->cflags field is not passed to tcg generation functions. So
>>> we add a bit to TCGContext, storing there whether CF_PARALLEL is set
>>> before translating every TB.
>>>
>>> Most architectures have <= 32 registers, which results in a 4-byte hole
>>> in TCGContext. Use this hole for the bit we need; use a uint8_t instead
>>> of a bool, since a bool might take more than one byte in some systems.
>>
>> I would much rather use bool.
>>
>> (1) I don't care about OSX and its broken ABI,
>> (2) Even then OSX still *works*.
> 
> Will do.
> 
>> Otherwise,
> 
> Missing R-b tag?

Oops, yes.  Must have fat-fingered the ctrl-paste.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
