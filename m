Received: from eggs.gnu.org ([2001:4830:134:3::10]:41081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdEh-0004Jw-Bo
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdEc-0002IG-E5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:13:55 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebdEc-0002Gl-8X
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:13:50 -0500
Received: by mail-pl0-f65.google.com with SMTP id q2so7615803pll.3
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 18:13:50 -0800 (PST)
From: Fam Zheng <fzheng@redhat.com>
References: <20180112125000.27256-1-f4bug@amsat.org>
	<20180112125000.27256-5-f4bug@amsat.org>
Message-ID: <c6440614-c563-c648-c4e0-fc84aee27ee6@redhat.com>
Date: Wed, 17 Jan 2018 10:13:44 +0800
MIME-Version: 1.0
In-Reply-To: <20180112125000.27256-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/7] docker: do not use Trusty APT source
 in Xenial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org



On 01/12/2018 08:49 PM, Philippe Mathieu-Daudé wrote:
> probably missed in 7fc581c29518
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   tests/docker/dockerfiles/ubuntu.docker | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
> index dabbf2a8a4..686d90ae8c 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -1,6 +1,4 @@
>   FROM ubuntu:16.04
> -RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiverse" >> \
> -    /etc/apt/sources.list
>   RUN apt-get update
>   ENV PACKAGES flex bison \
>       libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \

Reviewed-by: Fam Zheng <famz@redhat.com>
