Received: from eggs.gnu.org ([2001:4830:134:3::10]:49791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ronniesahlberg@gmail.com>) id 1dzgxo-0001WV-Jq
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ronniesahlberg@gmail.com>) id 1dzgxn-0001Sv-TQ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:31:40 -0400
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-6-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-6-armbru@redhat.com>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Wed, 4 Oct 2017 20:31:38 +1000
Message-ID: <CAN05THQE4gCa7=iiK9P23Smck_itS2fmrAJkLSvmy_OqwfbYqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/8] qemu-options: Add missing -iscsi
 Texinfo documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Reviewed-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>

On Tue, Oct 3, 2017 at 12:03 AM, Markus Armbruster <armbru@redhat.com> wrote:
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options.hx | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c647fdde62..8568ee388c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1180,6 +1180,12 @@ DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
>      "                iSCSI session parameters\n", QEMU_ARCH_ALL)
>
>  STEXI
> +@item -iscsi
> +@findex -iscsi
> +Configure iSCSI session parameters.
> +ETEXI
> +
> +STEXI
>  @end table
>  ETEXI
>  DEFHEADING()
> --
> 2.13.6
>
