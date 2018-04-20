Received: from eggs.gnu.org ([2001:4830:134:3::10]:44088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9M1n-0002YY-Mv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9M1k-0006vN-K3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:43:59 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:43356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9M1k-0006ux-G9
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:43:56 -0400
Received: by mail-qt0-x244.google.com with SMTP id l11-v6so8066751qtj.10
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 19:43:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <18577987-b45c-ec27-c41b-154f775fd152@amsat.org>
Date: Thu, 19 Apr 2018 23:43:50 -0300
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/43] docker: extend "cc" command to
 accept compiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/19/2018 10:58 AM, Alex Bennée wrote:
> When calling our cross-compilation images we want to call something
> other than the default cc.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> v2
>   - use arg.cc default to simplify logic
> ---
>  tests/docker/docker.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index bcc3ee2dee..59bce9f19a 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -415,6 +415,8 @@ class CcCommand(SubCommand):
>      def args(self, parser):
>          parser.add_argument("--image", "-i", required=True,
>                              help="The docker image in which to run cc")
> +        parser.add_argument("--cc", default="cc",
> +                            help="The compiler executable to call")
>          parser.add_argument("--source-path", "-s", nargs="*", dest="paths",
>                              help="""Extra paths to (ro) mount into container for
>                              reading sources""")
> @@ -428,7 +430,7 @@ class CcCommand(SubCommand):
>          if args.paths:
>              for p in args.paths:
>                  cmd += ["-v", "%s:%s:ro,z" % (p, p)]
> -        cmd += [args.image, "cc"]
> +        cmd += [args.image, args.cc]
>          cmd += argv
>          return Docker().command("run", cmd, args.quiet)
>  
> 
