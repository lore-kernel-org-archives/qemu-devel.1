Received: from eggs.gnu.org ([209.51.188.92]:50345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwPSO-0002E8-GE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwPSM-0006UE-Ua
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:50:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwPSF-0006L3-DV
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:50:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id q187so6119381wme.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 02:50:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20190220104523.22059-2-pbonzini@redhat.com>
Message-ID: <b08681c5-d8d3-0a9c-78ba-f8ed8927b098@redhat.com>
Date: Wed, 20 Feb 2019 11:50:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190220104523.22059-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] travis: the xcode10 image seems to be hosed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

On 20/02/19 11:45, Paolo Bonzini wrote:
> It fails to install homebrew.  Since this is out of our control, mark
> it as an expected failure.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .travis.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index baa06b976a..a7ab72b43b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -254,3 +254,11 @@ matrix:
>      - env:
>          - CONFIG="--disable-system"
>          - TEST_CMD="make -j3 check-tcg V=1"
> +
> +
> +  allow_failures:
> +    - env:
> +        - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
> +      os: osx
> +      osx_image: xcode10
> +      compiler: clang
> 

Hmm, this won't work. allow_failures row are not matched against
"include" rows.  Let's just disable the failing test.

Paolo
