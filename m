Received: from eggs.gnu.org ([2001:4830:134:3::10]:50166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk71q-0001Xt-6z
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk71n-00053C-2u
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:07:26 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk71m-000530-V1
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:07:23 -0400
Received: by mail-qk0-x241.google.com with SMTP id s79so5609516qki.0
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 04:07:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-2-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76478f68-ad57-329a-8944-973c507525d9@amsat.org>
Date: Tue, 22 Aug 2017 08:07:12 -0300
MIME-Version: 1.0
In-Reply-To: <20170822044155.2451-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] gitignore: Ignore vm test images
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

Hi Fam,

On 08/22/2017 01:41 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   .gitignore | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index cf65316863..693e2f3009 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -52,6 +52,8 @@
>   /vscclient
>   /vhost-user-scsi
>   /fsdev/virtfs-proxy-helper
> +/tests/vm/*.img
> +/tests/vm/*.tmp

This one is probably safe as a global "*.tmp"

>   *.[1-9]
>   *.a
>   *.aux
> 
