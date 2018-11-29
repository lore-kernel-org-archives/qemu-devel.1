Received: from eggs.gnu.org ([2001:4830:134:3::10]:42510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSMvL-0004xU-KH
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSMvG-0005fO-0n
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:04:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gSMvF-0005eX-MH
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:04:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so2040879wrb.2
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 06:04:05 -0800 (PST)
References: <20181129090120.28828-1-pbonzini@redhat.com>
	<20181129090120.28828-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c4b4eb4f-e879-1e97-e596-f2209115ca3c@redhat.com>
Date: Thu, 29 Nov 2018 15:03:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181129090120.28828-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/4] checkpatch: fix premature exit
 when no input or --mailback
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
> In some cases, checkpatch's process subroutine is exiting the
> whole process.  This is wrong, just return from the subroutine
> instead.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index eccd656c41..d58fcb1efd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2869,19 +2869,19 @@ sub process {
>  	# If we have no input at all, then there is nothing to report on
>  	# so just keep quiet.
>  	if ($#rawlines == -1) {
> -		exit(0);
> +		return 1;
>  	}
>  
>  	# In mailback mode only produce a report in the negative, for
>  	# things that appear to be patches.
>  	if ($mailback && ($clean == 1 || !$is_patch)) {
> -		exit(0);
> +		return 1;
>  	}
>  
>  	# This is not a patch, and we are are in 'no-patch' mode so
>  	# just keep quiet.
>  	if (!$chk_patch && !$is_patch) {
> -		exit(0);
> +		return 1;
>  	}
>  
>  	if (!$is_patch) {
> 
