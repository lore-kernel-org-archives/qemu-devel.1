Received: from eggs.gnu.org ([209.51.188.92]:44480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwXEU-0003to-0U
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwXES-0004bI-OJ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:08:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwXES-0004HW-Hc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:08:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so7802287wml.2
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 11:08:12 -0800 (PST)
References: <20190220172811.10588-1-alex.bennee@linaro.org>
	<20190220172811.10588-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5eb5c4dd-bb91-b173-eb0c-2fd2cf95a6e6@redhat.com>
Date: Wed, 20 Feb 2019 20:08:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190220172811.10588-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/8] .travis.yml: the xcode10 image
 seems to be hosed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org

On 2/20/19 6:28 PM, Alex Bennée wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> It fails to install homebrew.  Unfortunately we cannot mark

$ git config protocol.version
2

This is weird, Travis now enforce git protocol v2, but the brew version
they provide doesn't support it.

Maybe they don't care because now provide the Xcode 10.2 (as beta):

https://blog.travis-ci.com/2019-02-12-xcode-10-2-beta-2-is-now-available

Successful build:
https://travis-ci.org/philmd/qemu/jobs/496139928

I'll send a patch FWIW.

> it as an expected failure because Travis does not match
> allow_failures rows against include rows (only against the
> main test matrix, which we do not use at all), so just disable
> it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20190220105131.23479-1-pbonzini@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index baa06b976a..866a1872b1 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -174,13 +174,6 @@ matrix:
>        compiler: clang
>  
>  
> -    - env:
> -        - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
> -      os: osx
> -      osx_image: xcode10
> -      compiler: clang
> -
> -
>      # Python builds
>      - env:
>          - CONFIG="--target-list=x86_64-softmmu"
> 
