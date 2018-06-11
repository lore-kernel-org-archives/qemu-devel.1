Received: from eggs.gnu.org ([2001:4830:134:3::10]:38991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSPcx-0004lr-Fr
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSPct-0007kE-Hb
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:25:07 -0400
References: <20180611141716.3813-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7f9e886b-4fb0-8f95-bb06-760cde90daec@redhat.com>
Date: Mon, 11 Jun 2018 18:24:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180611141716.3813-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 11.06.2018 16:17, Peter Maydell wrote:
> The codebase has a bit of a mix of different multiline
> comment styles. State a preference for the Linux kernel
> style:
>     /*
>      * Star on the left for each line.
>      * Leading slash-star and trailing star-slash
>      * each go on a line of their own.
>      */
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is not my personal favourite, but seemed to be the
> closest we had to consensus in the mail thread for v1;
> I can live with it in order to avoid getting patches which
> use the styles I like even less :-)
> ---
>  CODING_STYLE | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/CODING_STYLE b/CODING_STYLE
> index 12ba58ee293..2d84f5f26d1 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -124,6 +124,23 @@ We use traditional C-style /* */ comments and avoid // comments.
>  Rationale: The // form is valid in C99, so this is purely a matter of
>  consistency of style. The checkpatch script will warn you about this.
>  
> +Multiline comments blocks should have a row of stars on the left,
> +and the initial /* and terminating */ both on their own lines:
> +    /*
> +     * like
> +     * this
> +     */
> +This is the same format required by the Linux kernel coding style.
> +
> +(Some of the existing comments in the codebase use the GNU Coding
> +Standards form which does not have stars on the left, or other
> +variations; avoid these when writing new comments, but don't worry
> +about converting to the preferred form unless you're editing that
> +comment anyway.)
> +
> +Rationale: Consistency, and ease of visually picking out a multiline
> +comment from the surrounding code.

s/multiline/multi-line/g maybe? That seems to be the more common
spelling...? Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
