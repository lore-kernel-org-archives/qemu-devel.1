Received: from eggs.gnu.org ([2001:4830:134:3::10]:54515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczUc-00069B-4P
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczUY-0006A9-4k
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:44:14 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:40663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczUX-00069y-WC
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:44:10 -0400
Received: by mail-qk0-x242.google.com with SMTP id c126-v6so3595869qkd.7
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 13:44:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1de61649-ac83-234a-0d97-3f9f4b51767e@amsat.org>
Date: Tue, 10 Jul 2018 17:44:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180709152117.21585-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.0 02/10] docker: debian-tricore add
 git tools
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

On 07/09/2018 12:21 PM, Alex Bennée wrote:
> As we check out we need git installed before we start. We would have
> had this based on the heavier qemu:debian9 image but we only use plain
> debian:9 here.

I first thought "weird, I checked this already" then noticed you rebased
on debian:9.
'stretch-slim' is an alias for '9-slim' and should be tinier (the
previous RFC image is 323MB).

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>> ---
>  tests/docker/dockerfiles/debian-tricore-cross.docker | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
> index 898b8dd511..5ba3ca88a7 100644
> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -11,6 +11,9 @@ FROM debian:9
>  
>  MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
>  
> +RUN apt-get update && \
> +    DEBIAN_FRONTEND=noninteractive apt-get install -yy git
> +
>  RUN git clone --single-branch \
>          https://github.com/bkoppelmann/tricore-binutils.git \
>          /usr/src/binutils && \
> 
