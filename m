Received: from eggs.gnu.org ([209.51.188.92]:52522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLKo-0002Tm-Rc
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLKn-0007V1-Rs
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:05:26 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:38160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJLKn-0007U1-BH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:05:25 -0400
Received: by mail-pg1-x530.google.com with SMTP id j26so9681730pgl.5
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:05:24 -0700 (PDT)
References: <20190424142714.28460-1-arilou@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5cab37c9-8bdf-2e7d-c6a8-93f6f176720b@linaro.org>
Date: Wed, 24 Apr 2019 10:05:19 -0700
MIME-Version: 1.0
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/20] gdbstub: Add infrastructure to
 parse cmd packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: arilou@gmail.com, qemu-devel@nongnu.org

On 4/24/19 7:26 AM, arilou@gmail.com wrote:
> +static const char *cmd_next_param(const char *param, const char delimiter)
> +{
> +    const char *delim;
> +    static char all_delimiters[] = ",;:=";

static const char

> +    static char no_delimiter[] = "\0";
> +    char curr_delimiters[2] = {0};
> +    const char *delimiters;
> +
> +    if (delimiter == '?') {
> +        delimiters = all_delimiters;
> +    } else if (delimiter == '0') {
> +        delimiters = no_delimiter;

    return strchr(param, '\0')

> +    while (*param) {
> +        delim = delimiters;
> +        while (*delim) {
> +            if (*param == *delim) {
> +                return param + 1;
> +            }
> +            delim++;
> +        }
> +        param++;
> +    }

Maybe

    param += strcspn(param, delim);
    if (*param) {
        param++;
    }
    return param;


r~
