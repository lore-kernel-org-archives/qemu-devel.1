Received: from eggs.gnu.org ([2001:4830:134:3::10]:39694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pvf-0005Ta-Cp
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pvc-0004yI-9E
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:30:59 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:56230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pvc-0004y3-4i
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:30:56 -0400
Received: by mail-qk0-x242.google.com with SMTP id x82so24633626qkb.12
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 20:30:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-22-richard.henderson@linaro.org>
	<83bf0768-25b0-b990-70d1-82c7a69e3f57@amsat.org>
Message-ID: <802a7af5-562f-5c78-612f-370f2882b20b@amsat.org>
Date: Tue, 24 Oct 2017 00:30:52 -0300
MIME-Version: 1.0
In-Reply-To: <83bf0768-25b0-b990-70d1-82c7a69e3f57@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 21/52] tcg: Use offsets not indices for
 TCGv_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com

On 10/24/2017 12:22 AM, Philippe Mathieu-Daudé wrote:
> On 10/20/2017 08:19 PM, Richard Henderson wrote:
>> Using the offset of a temporary, relative to TCGContext, rather than
>> its index means that we don't use 0.  That leaves offset 0 free for
>> a NULL representation without having to leave index 0 unused.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  tcg/tcg.h | 37 ++++++++++++++++++++-----------------
>>  1 file changed, 20 insertions(+), 17 deletions(-)
>>
[...]
>> +    return (void *)&tcg_ctx + a;
> 
> Hmmm why not cast it as TCGTemp*?

just read next patch, so:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
