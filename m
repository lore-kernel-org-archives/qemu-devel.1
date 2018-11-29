Received: from eggs.gnu.org ([2001:4830:134:3::10]:42658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSMvv-0005J5-BT
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSMvq-0005t0-9p
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:04:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gSMvq-0005sc-2Z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:04:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so2355732wmd.2
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 06:04:41 -0800 (PST)
References: <20181129090120.28828-1-pbonzini@redhat.com>
	<20181129090120.28828-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bbe05153-684b-a42d-51f4-d012ccf79b98@redhat.com>
Date: Thu, 29 Nov 2018 15:04:38 +0100
MIME-Version: 1.0
In-Reply-To: <20181129090120.28828-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/4] checkpatch: check
 Signed-off-by in --mailback mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 29/11/18 10:01, Paolo Bonzini wrote:
> Pull the test before the anticipated exits from the process sub.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/checkpatch.pl | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d58fcb1efd..c216c55e01 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2866,6 +2866,10 @@ sub process {
>  		}
>  	}
>  
> +	if ($is_patch && $chk_signoff && $signoff == 0) {
> +		ERROR("Missing Signed-off-by: line(s)\n");
> +	}
> +
>  	# If we have no input at all, then there is nothing to report on
>  	# so just keep quiet.
>  	if ($#rawlines == -1) {
> @@ -2887,9 +2891,6 @@ sub process {
>  	if (!$is_patch) {
>  		ERROR("Does not appear to be a unified-diff format patch\n");
>  	}
> -	if ($is_patch && $chk_signoff && $signoff == 0) {
> -		ERROR("Missing Signed-off-by: line(s)\n");
> -	}
>  
>  	print report_dump();
>  	if ($summary && !($clean == 1 && $quiet == 1)) {
> 
