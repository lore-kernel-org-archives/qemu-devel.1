Received: from eggs.gnu.org ([2001:4830:134:3::10]:48021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gLCXo-0005fw-A5
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gLCXj-0005hL-JD
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:34:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gLCXj-0005gt-BY
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:34:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so3032133wrb.13
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 11:34:11 -0800 (PST)
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <14684b4b-7e09-141a-ce00-b8da8830a07e@redhat.com>
Date: Fri, 9 Nov 2018 20:34:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181109150710.31085-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] Travis CI: make specified Python
 versions usable on jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On 9/11/18 16:07, Cleber Rosa wrote:
> For the two Python jobs, which seem to have the goal of making sure
> QEMU builds successfully on the 3.0-3.6 spectrum of Python 3 versions,
> the specified version is only applicable if a Python virtual
> environment is used.  To do that, it's necessary to define the
> (primary?) language of the job to be Python.
> 
> Also, Travis doesn't have a 3.0 Python installation available for the
> chosen distro, 3.2 being the lower version available.
> 
> Reference: https://docs.travis-ci.com/user/languages/python/#specifying-python-versions

On this link the lower version available is 3.3, isnt' it?

> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .travis.yml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index aa49c7b114..5c18d3e268 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -112,9 +112,11 @@ matrix:
>         compiler: clang
>       # Python builds
>       - env: CONFIG="--target-list=x86_64-softmmu"
> +      language: python
>         python:
> -        - "3.0"
> +        - "3.2"
>       - env: CONFIG="--target-list=x86_64-softmmu"
> +      language: python
>         python:
>           - "3.6"
>       # Acceptance (Functional) tests
> 
