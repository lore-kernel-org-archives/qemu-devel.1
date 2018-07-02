Received: from eggs.gnu.org ([2001:4830:134:3::10]:60091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5Jx-00048Y-7n
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5Jw-0006z2-5i
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:21:13 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:43746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5Jw-0006yi-1N
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:21:12 -0400
Received: by mail-qt0-x241.google.com with SMTP id f18-v6so2690912qtp.10
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 13:21:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
	<20180702143021.18864-19-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <299015c4-32a5-13e9-b8e2-2dd936e396a7@amsat.org>
Date: Mon, 2 Jul 2018 17:21:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180702143021.18864-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 18/20] docker: add special handling for
 FROM:debian-%-user targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On 07/02/2018 11:30 AM, Alex Bennée wrote:
> These will have been build with debootstrap so we need to check
> against the debian-bootstrap dockerfile. This does mean sticking to
> debian-FOO-user as the naming conventions for boot-strapped images.
> The actual cross image is built on top.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> v3
>   - don't include stray whitespace fix
> ---
>  tests/docker/docker.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index b279836154..69e7130db7 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -113,6 +113,10 @@ def _copy_binary_with_libs(src, dest_dir):
>              _copy_with_mkdir(l , dest_dir, so_path)
>  
>  def _read_qemu_dockerfile(img_name):
> +    # special case for Debian linux-user images
> +    if img_name.startswith("debian") and img_name.endswith("user"):
> +        img_name = "debian-bootstrap"
> +
>      df = os.path.join(os.path.dirname(__file__), "dockerfiles",
>                        img_name + ".docker")
>      return open(df, "r").read()
> 
