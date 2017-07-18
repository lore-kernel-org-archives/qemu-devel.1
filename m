Received: from eggs.gnu.org ([2001:4830:134:3::10]:40616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXKHl-00005G-DG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXKHi-0007Tk-DX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:39:01 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:33672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXKHi-0007Tb-7F
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:38:58 -0400
Received: by mail-pf0-x230.google.com with SMTP id e26so5297053pfd.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:38:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-37-git-send-email-cota@braap.org>
	<9b862388-4b4a-1db6-6161-4cab02ae5051@twiddle.net>
	<20170718043350.GA12960@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <20471017-2a10-6817-d756-f04ba7d83628@twiddle.net>
Date: Mon, 17 Jul 2017 18:38:51 -1000
MIME-Version: 1.0
In-Reply-To: <20170718043350.GA12960@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 36/45] tcg: dynamically allocate
 optimizer globals + fold into TCGContext
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

On 07/17/2017 06:33 PM, Emilio G. Cota wrote:
>> I would prefer either
>>
>>    (1) Dynamic allocation.  I know we eschew that most places during,
>>        but surely this is the exact situation for which it's handy.
...
> But I guess that's not what you mean with (1)? You mean to allocate
> every single time we call tcg_optimize, allocating only the space
> we need on each call?

Yes.

r~
