Received: from eggs.gnu.org ([2001:4830:134:3::10]:33539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f96cd-0001PE-R2
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f96cZ-0008EH-SN
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:16:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f96cZ-0008E0-No
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:16:55 -0400
References: <20180419091105.3943-1-stefanha@redhat.com>
	<20180419091105.3943-6-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0dd7d48c-f46b-53e5-be5d-06e35d4814a4@redhat.com>
Date: Thu, 19 Apr 2018 12:16:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180419091105.3943-6-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] checkpatch: reduce MAINTAINERS update
 message frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>

On 19.04.2018 11:11, Stefan Hajnoczi wrote:
> From: Joe Perches <joe@perches.com>
> 
> When files are being added/moved/deleted and a patch contains an update to
> the MAINTAINERS file, assume it's to update the MAINTAINERS file correctly
> and do not emit the "does MAINTAINERS need updating?" message.
> 
> Reported by many people.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> (cherry picked from e0d975b1b439c4fef58fbc306c542c94f48bb849)
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 95ba64f3a5..1c20c683e8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1389,6 +1389,12 @@ sub process {
>  			}
>  		}
>  
> +# Check if MAINTAINERS is being updated.  If so, there's probably no need to
> +# emit the "does MAINTAINERS need updating?" message on file add/move/delete
> +		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
> +			$reported_maintainer_file = 1;
> +		}
> +
>  # Check for added, moved or deleted files
>  		if (!$reported_maintainer_file && !$in_commit_log &&
>  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
