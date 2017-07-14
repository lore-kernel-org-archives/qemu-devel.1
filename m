Received: from eggs.gnu.org ([2001:4830:134:3::10]:35013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVytu-0007qo-60
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVytp-0006We-RB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVytp-0006W9-LC
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 867D8C05FFCC
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 11:36:44 +0000 (UTC)
Date: Fri, 14 Jul 2017 19:36:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170714113641.GA10205@lemon>
References: <20170714093016.10897-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714093016.10897-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] travis: add no-TCG build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 07/14 11:30, Paolo Bonzini wrote:
> It's fairly easy for --disable-tcg to bitrot.  Test it in our CI.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .travis.yml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 6809e25eca..f583839755 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -87,6 +87,9 @@ matrix:
>      - env: CONFIG="--enable-trace-backends=ust"
>             TEST_CMD=""
>        compiler: gcc
> +    - env: CONFIG="--disable-tcg"
> +           TEST_CMD=""
> +      compiler: gcc
>      - env: CONFIG=""
>        os: osx
>        compiler: clang
> -- 
> 2.13.0
> 

Makes sense. Thanks, queued:

    https://github.com/famz/qemu/tree/staging
