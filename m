Received: from eggs.gnu.org ([2001:4830:134:3::10]:32768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eChxy-00070O-Mm
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eChxu-0001Cj-HS
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:13:38 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:48630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eChxu-0001CH-BV
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:13:34 -0500
Received: by mail-wm0-x233.google.com with SMTP id p75so15206170wmg.3
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 00:13:34 -0800 (PST)
References: <20171107150558.22131-1-alex.bennee@linaro.org>
	<20171107150558.22131-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7bb27c4a-6c53-69b9-dff6-aa7413b6275f@linaro.org>
Date: Thu, 9 Nov 2017 09:13:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171107150558.22131-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH 04/10] risu: move optional args to
 each architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, Dave.Martin@arm.com, qemu-devel@nongnu.org

On 11/07/2017 04:05 PM, Alex Bennée wrote:
> +    if (arch_long_opts) {
> +        struct option *dptr, *sptr;
> +        size_t osize = sizeof(default_longopts);
> +        lopts = malloc(osize);
> +        /* Copy default opts */
> +        memcpy(lopts, default_longopts, osize);
> +        dptr = lopts;
> +        while (dptr->name) {
> +            dptr++;
> +        }
> +        /* Copy extra opts */
> +        sptr = arch_long_opts;
> +        while (sptr->name) {
> +            osize += sizeof(struct option);
> +            lopts = realloc(lopts, osize);

Count default and arch opts first?


r~
