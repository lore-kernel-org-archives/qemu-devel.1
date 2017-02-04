Received: from eggs.gnu.org ([2001:4830:134:3::10]:37077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZx8n-0000Ts-CR
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 05:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZx8i-0002nT-Mx
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 05:00:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1486144722-6021-1-git-send-email-peter.maydell@linaro.org>
Date: Sat, 04 Feb 2017 11:00:13 +0100
In-Reply-To: <1486144722-6021-1-git-send-email-peter.maydell@linaro.org>
	(Peter Maydell's message of "Fri, 3 Feb 2017 17:58:42 +0000")
Message-ID: <87efze6zte.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] CODING_STYLE: Mention preferred comment
 form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>, patches@linaro.org

Peter Maydell <peter.maydell@linaro.org> writes:

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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
