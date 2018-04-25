Received: from eggs.gnu.org ([2001:4830:134:3::10]:38946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB80k-0000lX-MJ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB80h-0004V6-P1
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:10:14 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB80h-0004TC-K8
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:10:11 -0400
Received: by mail-pg0-x242.google.com with SMTP id i6so12028154pgv.3
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:10:11 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd4e664e-87ed-9c69-f554-9c6496ec9343@linaro.org>
Date: Tue, 24 Apr 2018 14:10:06 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/46] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 05:23 AM, Alex Bennée wrote:
> @@ -675,10 +687,12 @@ case "$cpu" in
>    i386|i486|i586|i686|i86pc|BePC)
>      cpu="i386"
>      supported_cpu="yes"
> +    cross_cc_i386=gcc
>    ;;
>    x86_64|amd64)
>      cpu="x86_64"
>      supported_cpu="yes"
> +    cross_cc_x86_64=gcc
>    ;;
>    armv*b|armv*l|arm)
>      cpu="arm"

Isn't this hunk taken care of in the next patch, where you set these to $cc?
And if not, surely bare "gcc" isn't correct...

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
