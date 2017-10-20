Received: from eggs.gnu.org ([2001:4830:134:3::10]:50238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gyN-0002zu-Ac
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gyM-0003fs-Na
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:45:03 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:47002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gyM-0003fZ-IC
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:45:02 -0400
Received: by mail-pf0-x231.google.com with SMTP id p87so13131624pfj.3
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:45:02 -0700 (PDT)
References: <20171020175548.2566-1-programmingkidx@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
Date: Fri, 20 Oct 2017 16:44:58 -0700
MIME-Version: 1.0
In-Reply-To: <20171020175548.2566-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: John Arbuckle <programmingkidx@gmail.com>, david@gibson.dropbear.id.au, devicetree-compiler@vger.kernel.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 10/20/2017 10:55 AM, John Arbuckle wrote:
> +static inline size_t strnlen(const char *string, size_t max_count)
> +{
> +    size_t count;
> +    for (count = 0; count < max_count; count++) {
> +        if (string[count] == '\0') {
> +            break;
> +        }
> +    }
> +    return count;

Not to nitpick, but

  const char *p = memchr(string, 0, max_count);
  return p ? max_count : p - string;


r~
