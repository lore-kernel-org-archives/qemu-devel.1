Received: from eggs.gnu.org ([209.51.188.92]:37023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1groNQ-0007wO-AQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1groNP-0005uz-Fw
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1groNP-0005te-5F
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:26:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6413B80E7B
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 18:26:18 +0000 (UTC)
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-51-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3160576f-1b06-5eea-e24b-04f108c3e111@redhat.com>
Date: Thu, 7 Feb 2019 19:26:13 +0100
MIME-Version: 1.0
In-Reply-To: <1549562254-41157-51-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 50/51] .travis.yml: test that
 no-default-device builds do not regress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com

On 2019-02-07 18:57, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .travis.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 87d9fa9..a095d22 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -132,6 +132,12 @@ matrix:
>  
>      # We manually include builds which we disable "make check" for

Maybe adjust the comment here?

>      - env:
> +        - CONFIG="--without-default-devices"
> +        - TEST_CMD=""

Have you tried --without-default-devices + "make check" ? I wonder how
badly it explodes... well, I guess we need the qgraph patches for that
first.

> +
> +    # We manually include builds which we disable "make check" for
> +    - env:
>          - CONFIG="--enable-debug --enable-tcg-interpreter"
>          - TEST_CMD=""
>  
> 

 Thomas
