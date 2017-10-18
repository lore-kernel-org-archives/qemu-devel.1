Received: from eggs.gnu.org ([2001:4830:134:3::10]:41415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4ut6-0001m0-Bv
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 16:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4ut2-0005MF-7n
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 16:24:24 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:52631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4ut2-0005Lh-0L
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 16:24:20 -0400
Received: by mail-pg0-x22d.google.com with SMTP id a192so5176663pge.9
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 13:24:19 -0700 (PDT)
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-47-richard.henderson@linaro.org>
	<20171018043535.GE13959@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <197c054c-7fc6-0c00-4d9f-869b4d941f15@linaro.org>
Date: Wed, 18 Oct 2017 13:24:16 -0700
MIME-Version: 1.0
In-Reply-To: <20171018043535.GE13959@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 46/50] tcg: allocate optimizer temps
 with tcg_malloc
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

On 10/17/2017 09:35 PM, Emilio G. Cota wrote:
> On Mon, Oct 16, 2017 at 10:26:05 -0700, Richard Henderson wrote:
>> From: "Emilio G. Cota" <cota@braap.org>
> 
> (snip)
>> Suggested-by: Richard Henderson <rth@twiddle.net>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Note the double Sob tag.
> 
> Also, does this still break aarch32, or somehow the cleanups plus
> this got rid of the problem?

This got rid of the problem.


r~
