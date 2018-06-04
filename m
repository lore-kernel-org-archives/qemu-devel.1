Received: from eggs.gnu.org ([2001:4830:134:3::10]:41660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPusl-0004VR-Lj
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPush-0005YL-LT
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:11:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180604162140.20688-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f191ff51-7bcb-dc30-e225-8ac83a4fbadd@amsat.org>
Date: Mon, 4 Jun 2018 16:10:49 -0300
MIME-Version: 1.0
In-Reply-To: <20180604162140.20688-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 06/04/2018 01:21 PM, Peter Maydell wrote:
> The codebase has a bit of a mix of
>  /* multiline comments
>   * like this
>   */
> and
>  /* multiline comments like this
>     in the GNU Coding Standards style */
> 
> State a preference for the former.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I admit that to some extent I'm imposing my aesthetic
> preferences here; pretty sure we have a lot more style
> 1 comments than style 2, though.

The later is easier to indent with unintelligent editors.

Any one is fine as long as it has a guideline in coding style.

> ---
>  CODING_STYLE | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/CODING_STYLE b/CODING_STYLE
> index 12ba58ee293..fb1d1f1cd62 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -124,6 +124,19 @@ We use traditional C-style /* */ comments and avoid // comments.
>  Rationale: The // form is valid in C99, so this is purely a matter of
>  consistency of style. The checkpatch script will warn you about this.
>  
> +Multiline comments blocks should have a row of stars on the left
> +and the terminating */ on its own line:
> +    /* like
> +     * this
> +     */
> +Putting the initial /* on its own line is accepted, but not required.
> +(Some of the existing comments in the codebase use the GNU Coding
> +Standards form which does not have stars on the left; avoid this
> +when writing new comments.)
> +
> +Rationale: Consistency, and ease of visually picking out a multiline
> +comment from the surrounding code.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>  8. trace-events style
>  
>  8.1 0x prefix
> 
