Received: from eggs.gnu.org ([2001:4830:134:3::10]:51846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQ0bw-0006BX-PV
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQ0bs-0005Gk-Pu
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:18:08 -0400
Date: Mon, 4 Jun 2018 19:17:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180604191756.1ae61871@w520.home>
In-Reply-To: <20180604162140.20688-1-peter.maydell@linaro.org>
References: <20180604162140.20688-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On Mon,  4 Jun 2018 17:21:40 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

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

Could we say "at maintainer discretion", or is that always implied?  The
asymmetry of the proposed standard is not my favorite and a mostly
blank line before and after further supports standing out from
surrounding code.  Note that the kernel coding style, except for
certain exceptions, is:

/*
 * This is a
 * multi-line
 * comment
 */

Thanks,

Alex

> +(Some of the existing comments in the codebase use the GNU Coding
> +Standards form which does not have stars on the left; avoid this
> +when writing new comments.)
> +
> +Rationale: Consistency, and ease of visually picking out a multiline
> +comment from the surrounding code.
> +
>  8. trace-events style
>  
>  8.1 0x prefix
