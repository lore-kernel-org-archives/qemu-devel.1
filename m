Received: from eggs.gnu.org ([2001:4830:134:3::10]:44573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ergUf-0003Gh-LG
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ergUb-00008B-Ml
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:56:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ergUb-00007H-Gs
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:56:41 -0500
References: <1519978965-16865-1-git-send-email-jusual@mail.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5bfb4a6-670c-9a0f-18b9-a44d307140b5@redhat.com>
Date: Fri, 2 Mar 2018 09:56:20 +0100
MIME-Version: 1.0
In-Reply-To: <1519978965-16865-1-git-send-email-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] checkpatch: add a warning for
 basename/dirname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 02/03/2018 09:22, Julia Suvorova wrote:
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  scripts/checkpatch.pl | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1b4b812..6c4fb42 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2584,6 +2584,11 @@ sub process {
>  			ERROR("__func__ should be used instead of gcc specific __FUNCTION__\n"  . $herecurr);
>  		}
>  
> +# recommend g_path_get_* over basename(3) and dirname(3)
> +		if ($line =~ /\b(basename|dirname)\s*\(/) {
> +			WARN("consider using g_path_get_$1 in preference to $1(3)\n" . $herecurr);
> +		}
> +
>  # recommend qemu_strto* over strto* for numeric conversions
>  		if ($line =~ /\b(strto[^kd].*?)\s*\(/) {
>  			ERROR("consider using qemu_$1 in preference to $1\n" . $herecurr);
> 

Hi Julia, the patch is fine, but given Alex's objections let's warn only
if you are doing g_strdup(basename(...)) or g_strdup(dirname(...)).

(No other action is needed on your other patch).

Thanks!

Paolo
