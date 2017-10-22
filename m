Received: from eggs.gnu.org ([2001:4830:134:3::10]:42971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6Gww-0000MN-C8
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6Gwv-0005p6-HO
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:09:58 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e6Gwv-0005ol-B7
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:09:57 -0400
Received: by mail-wr0-x243.google.com with SMTP id l1so14945702wrc.3
	for <qemu-devel@nongnu.org>; Sun, 22 Oct 2017 07:09:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
References: <20171020175548.2566-1-programmingkidx@gmail.com>
	<f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Oct 2017 14:37:01 +0100
Message-ID: <CAFEAcA8WnzZpdTWjJafLDjTCOpT_=azr6T+8UAnMNyDiD2ZxAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [libfdt][PATCH v2] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: John Arbuckle <programmingkidx@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, devicetree-compiler@vger.kernel.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21 October 2017 at 00:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/20/2017 10:55 AM, John Arbuckle wrote:
>> +static inline size_t strnlen(const char *string, size_t max_count)
>> +{
>> +    size_t count;
>> +    for (count = 0; count < max_count; count++) {
>> +        if (string[count] == '\0') {
>> +            break;
>> +        }
>> +    }
>> +    return count;
>
> Not to nitpick, but
>
>   const char *p = memchr(string, 0, max_count);
>   return p ? max_count : p - string;

Am I misreading that, or do you have the ?: arms the wrong way
around there?

thanks
-- PMM
