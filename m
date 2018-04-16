Received: from eggs.gnu.org ([2001:4830:134:3::10]:60930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rbg-0003tD-Hz
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rbc-00037F-Ud
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:02:52 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rbc-000378-QW
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:02:48 -0400
Received: by mail-qk0-x241.google.com with SMTP id d193so3415549qke.9
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 17:02:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7781c7ab-cecb-122f-8a7a-5cd41c589279@amsat.org>
Date: Sun, 15 Apr 2018 21:02:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 07/24] docker: allow "cc" command to run
 in user context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/docker.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 9444f4bea4..f79213044d 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -399,6 +399,8 @@ class CcCommand(SubCommand):
>                              help="The docker image in which to run cc")
>          parser.add_argument("--cc",
>                              help="The compiler executable to call")
> +        parser.add_argument("--user",
> +                            help="The user-id to run under")
>          parser.add_argument("--source-path", "-s", nargs="*", dest="paths",
>                              help="""Extra paths to (ro) mount into container for
>                              reading sources""")
> @@ -414,6 +416,9 @@ class CcCommand(SubCommand):
>              for p in args.paths:
>                  cmd += ["-v", "%s:%s:ro,z" % (p, p)]
>  
> +        if args.user:
> +            cmd += ["-u", args.user]
> +
>          cmd += [args.image]
>  
>          # The compile command we are running
> 
