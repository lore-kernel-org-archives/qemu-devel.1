Received: from eggs.gnu.org ([2001:4830:134:3::10]:50603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXL5D-0000Dt-36
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXL59-0000we-QD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:30:07 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXL59-0000vt-Iw
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:30:03 -0400
Received: by mail-pf0-x244.google.com with SMTP id e199so1409335pfh.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 22:30:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-11-git-send-email-cota@braap.org>
	<92056605-c95b-b19b-0216-5d83be64e13d@twiddle.net>
	<20170718002700.GA7414@flamenco>
	<5382470b-120c-1cdd-32f3-d246d75059d2@twiddle.net>
	<20170718045458.GB12960@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b0eb3da8-14a3-fae2-b4c9-72696fece97b@twiddle.net>
Date: Mon, 17 Jul 2017 19:29:57 -1000
MIME-Version: 1.0
In-Reply-To: <20170718045458.GB12960@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/45] translate-all: guarantee that
 tb_hash only holds valid TBs
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

On 07/17/2017 06:54 PM, Emilio G. Cota wrote:
> What threw me off was that in lookup_tb_ptr we're not checking tb->invalid,
> and that biased me into thinking that it's not needed. But I should have
> tried harder. Also, that's a bug, and yet another reason to have tb_lookup,
> so that we fix these things at once in one place.

Yes, me as well.  Quite right we need only one copy of this code.

>>          (tb->flags & (CF_HASH_MASK | CF_INVALID)) == cf_mask
>>
>> So that we continue to check CF_INVALID each time we lookup a TB, but now we
>> get it for free as a part of the other flags check.
> 
> With the annoying atomic_read thrown in there :-) but yes, will do.

Yes of course.  ;-)


r~
