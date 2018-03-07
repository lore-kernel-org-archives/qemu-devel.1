Received: from eggs.gnu.org ([2001:4830:134:3::10]:55040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etaMY-0007wZ-2x
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etaMT-0007kf-4z
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:48:14 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etaMS-0007kA-Tw
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:48:09 -0500
Received: by mail-wr0-f195.google.com with SMTP id o76so2432997wrb.7
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 06:48:08 -0800 (PST)
References: <20180222215838.18223-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <441a9060-6216-088b-82b6-71f0ad88ceb9@redhat.com>
Date: Wed, 7 Mar 2018 15:48:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180222215838.18223-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Exempt long URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org

On 22/02/2018 22:58, Eric Blake wrote:
> Sometimes, we want to refer to really long URLs, but checkpatch
> balks, and we have to manually bypass the check.  URL shorterners
> may be nice at reducing long links, but it's hard to guarantee the
> shortened link will live as long as the real target, and it is
> also nice to see the original target without having to load the
> shortened URL through a browser.  So exempt a line containing
> only a URL from the long-line syntax check.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1b4b812e28f..0d3f753c665 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1447,9 +1447,10 @@ sub process {
>  # check we are in a valid source file if not then ignore this hunk
>  		next if ($realfile !~ /$SrcFile/);
> 
> -#90 column limit
> +#90 column limit; exempt URLs, if no other words on line
>  		if ($line =~ /^\+/ &&
>  		    !($line =~ /^\+\s*"[^"]*"\s*(?:\s*|,|\)\s*;)\s*$/) &&
> +		    !($rawline =~ /^[^[:alnum:]]*https?:\S*$/) &&
>  		    $length > 80)
>  		{
>  			if ($length > 90) {
> 

Queued, thanks.

Paolo
