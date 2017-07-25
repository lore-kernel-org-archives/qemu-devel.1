Received: from eggs.gnu.org ([2001:4830:134:3::10]:46408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZruj-0007oD-Ho
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 00:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZruf-00047m-Ld
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 00:57:45 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZruf-00047c-H6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 00:57:41 -0400
Received: by mail-qk0-x243.google.com with SMTP id d145so9233866qkc.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 21:57:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170720134716.13049-1-alex.bennee@linaro.org>
	<20170720134716.13049-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e9ce578f-65aa-a369-fc11-2d4a03a3f483@amsat.org>
Date: Tue, 25 Jul 2017 01:57:36 -0300
MIME-Version: 1.0
In-Reply-To: <20170720134716.13049-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 1/3] docker: ensure NOUSER for
 travis images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

On 07/20/2017 10:47 AM, Alex Bennée wrote:
> While adding the current user is a useful default behaviour for
> creating new images it is not appropriate for Travis which already has
> a default user.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/Makefile.include | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index aaab1a4208..d7dafdbd27 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -71,6 +71,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
>   docker-image-debian-s390x-cross: docker-image-debian9
>   docker-image-debian-win32-cross: docker-image-debian8-mxe
>   docker-image-debian-win64-cross: docker-image-debian8-mxe
> +docker-image-travis: NOUSER=1

Cool you kept it ordered :)

I'm surprised we need to install the full LaTeX stack to be able to 
compile the device-tree-compiler...

Reading 
https://docs.travis-ci.com/user/environment-variables#default-environment-variables 
I think it'd be a better match if we also use those default environment 
variables, at least:

DEBIAN_FRONTEND=noninteractive
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

what do you think?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   
>   # Expand all the pre-requistes for each docker image and test combination
>   $(foreach i,$(DOCKER_IMAGES), \
> 
