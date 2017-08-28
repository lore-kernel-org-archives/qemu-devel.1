Received: from eggs.gnu.org ([2001:4830:134:3::10]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmQOO-0007mt-Qt
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 16:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmQOL-0002ps-Nq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 16:12:16 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmQOL-0002pn-J9
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 16:12:13 -0400
Received: by mail-qk0-x241.google.com with SMTP id o63so1360922qkb.5
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 13:12:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-2-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4290db65-f344-4bf8-19b3-567467e473bc@amsat.org>
Date: Mon, 28 Aug 2017 17:12:08 -0300
MIME-Version: 1.0
In-Reply-To: <20170828174707.20786-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 01/10] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 08/28/2017 02:46 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> +*.tmp
>   *.[1-9]
>   *.a
>   *.aux
> 
