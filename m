Received: from eggs.gnu.org ([2001:4830:134:3::10]:43038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZgCS-0000hr-NP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZgCO-00011w-0y
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:27:16 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZgCN-00011f-Sd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:27:11 -0400
Received: by mail-qk0-x242.google.com with SMTP id d136so10360359qkg.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 09:27:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170720134716.13049-1-alex.bennee@linaro.org>
	<20170720134716.13049-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6659bebb-d486-5ff0-bb02-294f3369a4b8@amsat.org>
Date: Mon, 24 Jul 2017 13:27:07 -0300
MIME-Version: 1.0
In-Reply-To: <20170720134716.13049-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 2/3] docker: fix dirty/stash
 detection on some systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

On 07/20/2017 10:47 AM, Alex Bennée wrote:
> I reported this a while ago but evidently forgot to push the patch
> upstream. Without this I wasn't seeing the dirty tree state submitted
> to the docker build which is very confusing.
> 
> Reference:
>    Subject: [PATCH 1/6] tests/docker/Makefile.include: fix diff-index call
>    Date: Fri, 28 Oct 2016 17:33:34 +0100
>    Message-Id: <20161028163339.31096-2-alex.bennee@linaro.org>
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/docker/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index d7dafdbd27..ff580edfad 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -20,7 +20,7 @@ IMAGES ?= %
>   # Make archive from git repo $1 to tar.gz $2
>   make-archive-maybe = $(if $(wildcard $1/*), \
>   	$(call quiet-command, \
> -		(cd $1; if git diff-index --quiet HEAD -- &>/dev/null; then \
> +		(cd $1; if git diff-index --quiet HEAD -- 2>/dev/null; then \
>   			git archive -1 HEAD --format=tar.gz; \
>   		else \
>   			git archive -1 $$(git stash create) --format=tar.gz; \
> 
