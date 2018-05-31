Received: from eggs.gnu.org ([2001:4830:134:3::10]:45148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQBe-0008WN-MD
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQBb-0001Dg-E2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:12:26 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQBb-0001DP-9G
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:12:23 -0400
Received: by mail-qk0-x243.google.com with SMTP id w23-v6so2319749qkb.8
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 09:12:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
	<20180530110655.22022-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ab8c1af7-69ae-023a-26e9-bb231362a0de@amsat.org>
Date: Thu, 31 May 2018 13:12:16 -0300
MIME-Version: 1.0
In-Reply-To: <20180530110655.22022-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 6/8] .travis.yml: make current setup
 explicit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

On 05/30/2018 08:06 AM, Alex Bennée wrote:
> Add some commentary and make the selection of Container based Trusty
> build explicit. We will need to add VM builds later when using docker.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .travis.yml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 85ee2a1edb..e99af6f357 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,4 +1,8 @@
> +# The current Travis default is a container based 14.04 Trust on EC2
> +# Additional builds with specific requirements for a full VM need to
> +# be added as additional matrix: entries later on
>  sudo: false
> +dist: trusty
>  language: c
>  python:
>    - "2.6"
> 
