Received: from eggs.gnu.org ([2001:4830:134:3::10]:47891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dURjt-00031G-C1
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dURjo-0002DT-TK
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:00:09 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:37769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dURjo-0002DD-NK
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:00:04 -0400
Received: by mail-it0-x229.google.com with SMTP id m84so27953530ita.0
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 23:00:04 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-23-git-send-email-cota@braap.org>
	<5b3531bf-5e06-f5d3-6ba0-6a0baa810cee@twiddle.net>
	<20170710035128.GA25231@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4173f39f-a236-c64f-3ae4-497b4bff363c@twiddle.net>
Date: Sun, 9 Jul 2017 19:59:47 -1000
MIME-Version: 1.0
In-Reply-To: <20170710035128.GA25231@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/22] translate-all: do not hold tb_lock
 during code generation in softmmu
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

On 07/09/2017 05:51 PM, Emilio G. Cota wrote:
> On Sun, Jul 09, 2017 at 11:38:50 -1000, Richard Henderson wrote:
>> On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> (snip)
>> I think it would be better to have a tb_htable_lookup_or_insert function,
>> which performs the insert iff a matching object isn't already there,
>> returning the entry which *is* there in either case.
> 
> qht_insert behaves exactly like this, except that it returns a bool.
> But we could make it return a void *.

Err.. no it doesn't.  It returns false if the *exact same object* is inserted 
twice.  That's not the same as being passed a qht_lookup_func_t to see if two 
different objects compare equal.


r~
