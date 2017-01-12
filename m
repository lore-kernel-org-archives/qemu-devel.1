Received: from eggs.gnu.org ([2001:4830:134:3::10]:60878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cRdm7-0003ae-Uo
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cRdm4-0004kp-Sg
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:42:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cRdm4-0004jd-NI
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:42:32 -0500
Date: Thu, 12 Jan 2017 12:42:28 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170112114228.txj3mav3nz5uqgh5@hawk.localdomain>
References: <1484192182-13760-1-git-send-email-peterx@redhat.com>
	<1484192182-13760-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484192182-13760-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v6 1/3] run_tests: fix errno
 for param parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Thu, Jan 12, 2017 at 11:36:20AM +0800, Peter Xu wrote:
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  run_tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/run_tests.sh b/run_tests.sh
> index 254129d..2cfa365 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -41,7 +41,7 @@ while getopts "g:hv" opt; do
>              verbose="yes"
>              ;;
>          *)
> -            exit 1
> +            exit 2
>              ;;
>      esac
>  done
> -- 
> 2.7.4
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
