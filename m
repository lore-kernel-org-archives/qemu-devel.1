Received: from eggs.gnu.org ([2001:4830:134:3::10]:39529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnscc-0000Ym-EN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnscZ-0004g3-Cw
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:32:58 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnscZ-0004fl-8k
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:32:55 -0400
Received: by mail-qt0-x242.google.com with SMTP id h15so986115qta.0
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 13:32:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170831064302.14427-1-famz@redhat.com>
	<20170831064302.14427-2-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1bcc99e-9b28-747a-29e5-337ea43a12e2@amsat.org>
Date: Fri, 1 Sep 2017 17:32:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170831064302.14427-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 01/12] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 08/31/2017 03:42 AM, Fam Zheng wrote:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   .gitignore | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index cf65316863..643e23e515 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -52,6 +52,8 @@
>   /vscclient
>   /vhost-user-scsi
>   /fsdev/virtfs-proxy-helper
> +/tests/vm/*.img

There is a tests/.gitignore, isn't it cleaner to add vm/*.img there?

> +*.tmp
>   *.[1-9]
>   *.a
>   *.aux
> 
