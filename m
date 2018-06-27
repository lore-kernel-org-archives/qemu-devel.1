Received: from eggs.gnu.org ([2001:4830:134:3::10]:43166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fY06k-0002m7-Kh
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fY06g-000174-MX
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:22:58 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fY06g-00016i-Ie
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:22:54 -0400
Received: by mail-qt0-x244.google.com with SMTP id c5-v6so415627qth.5
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 19:22:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627021423.18404-1-ehabkost@redhat.com>
	<20180627021423.18404-5-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <be6a6344-b220-8090-8499-9f078ff67954@amsat.org>
Date: Tue, 26 Jun 2018 23:22:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180627021423.18404-5-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/6] docker: Use os.environ.items() instead
 of .iteritems()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/26/2018 11:14 PM, Eduardo Habkost wrote:
> Mapping.iteritems() doesn't exist in Python 3.
> 
> Note that Mapping.items() exists in both Python 3 and Python 2,
> but it returns a list (and not an iterator) in Python 2.  The
> existing code will work on both cases, though.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/docker.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index db6b463b92..bc34bd872b 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -355,7 +355,7 @@ class BuildCommand(SubCommand):
>                  cksum += [(filename, _file_checksum(filename))]
>  
>              argv += ["--build-arg=" + k.lower() + "=" + v
> -                        for k, v in os.environ.iteritems()
> +                        for k, v in os.environ.items()
>                          if k.lower() in FILTERED_ENV_NAMES]
>              dkr.build_image(tag, docker_dir, dockerfile,
>                              quiet=args.quiet, user=args.user, argv=argv,
> 
