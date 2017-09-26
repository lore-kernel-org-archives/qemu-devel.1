Received: from eggs.gnu.org ([2001:4830:134:3::10]:49018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dwsYb-0006jC-Sn
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dwsYb-0005cH-2F
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:18:01 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dwsYa-0005ZJ-S2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:18:01 -0400
Received: by mail-pf0-x242.google.com with SMTP id i23so5191531pfi.2
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:17:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170926133622.14991-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d907bbdd-ee5c-7c6d-b89d-a07a97c8bbc6@amsat.org>
Date: Tue, 26 Sep 2017 13:17:56 -0300
MIME-Version: 1.0
In-Reply-To: <20170926133622.14991-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] tests/docker/run: don't source
 /etc/profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

On 09/26/2017 10:36 AM, Alex Bennée wrote:
> The usual behaviour of /etc/profile is to set the default PATH for
> users. This runs into problems when we have updated PATH in our
> dockerfile e.g. to access a cross-compiler in a non-standard
> location. It shouldn't be needed anyway as we inherit the env from the
> image when it was setup.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/docker/run | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tests/docker/run b/tests/docker/run
> index c8f940de15..b87f8ef03c 100755
> --- a/tests/docker/run
> +++ b/tests/docker/run
> @@ -18,7 +18,6 @@ fi
>   BASE="$(dirname $(readlink -e $0))"
>   
>   # Prepare the environment
> -. /etc/profile
>   export PATH=/usr/lib/ccache:$PATH
>   
>   if test -n "$J"; then
> 
