Received: from eggs.gnu.org ([2001:4830:134:3::10]:41027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJQzI-0002wF-K1
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJQzF-0003RM-8Z
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:35:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gJQzF-0003Ob-25
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:35:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id l66-v6so327763wml.2
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 14:35:16 -0800 (PST)
References: <20181104112424.18663-1-stefanha@redhat.com>
	<20181104112424.18663-9-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <504d23df-10ed-4126-01bc-c1cfaf73d95f@redhat.com>
Date: Sun, 4 Nov 2018 23:35:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181104112424.18663-9-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 8/8] docker: use HTTPS git URL for
 virglrenderer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, cohuck@redhat.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 4/11/18 12:24, Stefan Hajnoczi wrote:
> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
> 
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   tests/docker/dockerfiles/debian-amd64.docker | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
> index eb13f06ed1..24b113b76f 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -24,7 +24,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>           libegl1-mesa-dev \
>           libepoxy-dev \
>           libgbm-dev
> -RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virglrenderer
> +RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr/src/virglrenderer
>   RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
>   
>   # netmap
> 
