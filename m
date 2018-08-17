Received: from eggs.gnu.org ([2001:4830:134:3::10]:52401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqeVQ-0007DN-Dz
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqeVL-0008Mk-Lk
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:09:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqeVK-0008MO-Vt
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:09:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817105157.7486-1-pbonzini@redhat.com>
Date: Fri, 17 Aug 2018 15:09:25 +0200
In-Reply-To: <20180817105157.7486-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Fri, 17 Aug 2018 12:51:57 +0200")
Message-ID: <87efex16nu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH correct] checkpatch: allow space in more
 places before a bracket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> Allow a space between a colon and subsequent opening bracket.  This
> sequence may occur in inline assembler statements like
>
> 	asm(
> 		"ldr %[out], [%[in]]\n\t"
> 		: [out] "=r" (ret)
> 		: [in] "r" (addr)
> 	);
>
> Allow a space between a comma and subsequent opening bracket.  This
> sequence may occur in designated initializers.
>
> To ease backporting the patch, I am also changing the comma-bracket
> detection (added in QEMU by commit 409db6eb7199af7a2f09f746bd1b793e9daefe5f)
> to use the same regex as brackets and colons (as done independently
> by Linux commit daebc534ac15f991961a5bb433e515988220e9bf).
>
> Link: http://lkml.kernel.org/r/20180403191655.23700-1-xypron.glpk@gmx.de
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Acked-by: Joe Perches <joe@perches.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/checkpatch.pl | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 52ab18bfce..33b5771120 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1977,9 +1977,8 @@ sub process {
>  			my ($where, $prefix) = ($-[1], $1);
>  			if ($prefix !~ /$Type\s+$/ &&
>  			    ($where != 0 || $prefix !~ /^.\s+$/) &&
> -			    $prefix !~ /{\s+$/ &&
>  			    $prefix !~ /\#\s*define[^(]*\([^)]*\)\s+$/ &&
> -			    $prefix !~ /,\s+$/) {
> +			    $prefix !~ /[,{:]\s+$/) {
>  				ERROR("space prohibited before open square bracket '['\n" . $herecurr);
>  			}
>  		}

Reviewed-by: Markus Armbruster <armbru@redhat.com>
