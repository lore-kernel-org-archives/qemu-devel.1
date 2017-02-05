Received: from eggs.gnu.org ([2001:4830:134:3::10]:48526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1caR9E-0003k2-Bs
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 13:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1caR9B-00011W-9N
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 13:02:48 -0500
References: <1486144722-6021-1-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5f8d7bb8-613c-e2f2-75dc-964524e8653e@vivier.eu>
Date: Sun, 5 Feb 2017 19:02:36 +0100
MIME-Version: 1.0
In-Reply-To: <1486144722-6021-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] CODING_STYLE: Mention
 preferred comment form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, patches@linaro.org

Le 03/02/2017 à 18:58, Peter Maydell a écrit :
> Our defacto coding style strongly prefers /* */ style comments
> over the single-line // style, and checkpatch enforces this,
> but we don't actually document this. Mention it in CODING_STYLE.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  CODING_STYLE | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/CODING_STYLE b/CODING_STYLE
> index f53180b..2fa0c0b 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -116,3 +116,10 @@ if (a == 1) {
>  Rationale: Yoda conditions (as in 'if (1 == a)') are awkward to read.
>  Besides, good compilers already warn users when '==' is mis-typed as '=',
>  even when the constant is on the right.
> +
> +7. Comment style
> +
> +We use traditional C-style /* */ comments and avoid // comments.
> +
> +Rationale: The // form is valid in C99, so this is purely a matter of
> +consistency of style. The checkpatch script will warn you about this.
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
