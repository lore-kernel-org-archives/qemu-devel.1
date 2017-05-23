Received: from eggs.gnu.org ([2001:4830:134:3::10]:55664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDJ78-0007Yr-1I
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDJ77-0007xL-CZ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:21:18 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:35247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDJ77-0007x9-7Y
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:21:17 -0400
Received: by mail-qk0-x230.google.com with SMTP id a72so142205344qkj.2
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 16:21:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-3-rth@twiddle.net>
	<20170523104851.37tseiq5zlpwevr6@aurel32.net>
	<d059a3b3-ac6c-27d2-5270-b6d5b32cc41d@twiddle.net>
	<20170523172858.aqvgqlrwrwu6jk2o@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d9b3afcc-2def-ee43-9865-ab82c3361b3c@twiddle.net>
Date: Tue, 23 May 2017 16:21:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170523172858.aqvgqlrwrwu6jk2o@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/31] target/s390x: Implement EXECUTE via
 new TranslationBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 05/23/2017 10:28 AM, Aurelien Jarno wrote:
>> Something like this, as a delta patch.
> 
> Unfortunately it doesn't work. So far I have no real idea what could be
> the root cause of the issue. I have just determined that up to the crash,
> only a very limited set of instructions are being executed. They are the
> 4 bytes long versions of MVC, CLC, XC, TR.

Yeah, it appears XC is the culprit, though I have not yet determined exactly 
what's going wrong.

That said, perhaps I'll delay this for later and just add some extra helpers 
for now.  It does seem slightly wasteful to create a TB for at least these 
common cases.


r~
