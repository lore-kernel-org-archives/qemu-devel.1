Received: from eggs.gnu.org ([2001:4830:134:3::10]:47048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRUa-000243-3y
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRUS-0003Wv-JK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:02:20 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:45061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRUS-0003WW-Eb
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:02:12 -0400
Received: by mail-vk0-x244.google.com with SMTP id b78-v6so730595vka.12
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:02:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a5a4c090-e0a3-5150-9cd3-19dd14282468@amsat.org>
Date: Tue, 17 Jul 2018 12:02:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 15/16] docker: add commentary to
 debian-bootstrap.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 07/13/2018 09:17 AM, Alex Bennée wrote:
> This is just a note that later versions of debootstrap don't
> technically need this hack.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/dockerfiles/debian-bootstrap.docker | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/docker/dockerfiles/debian-bootstrap.docker b/tests/docker/dockerfiles/debian-bootstrap.docker
> index 14212b9cf4..e13c26a7ed 100644
> --- a/tests/docker/dockerfiles/debian-bootstrap.docker
> +++ b/tests/docker/dockerfiles/debian-bootstrap.docker
> @@ -9,6 +9,7 @@ FROM scratch
>  ADD . /
>  
>  # Patch all mounts as docker already has stuff set up
> +# (this is not needed for later debootstraps but is harmless atm)
>  RUN sed -i 's/in_target mount/echo not for docker in_target mount/g' /debootstrap/functions
>  
>  # Run stage 2
> 
