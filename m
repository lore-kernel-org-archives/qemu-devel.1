Received: from eggs.gnu.org ([2001:4830:134:3::10]:45760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVCWF-0001FR-Vl
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVCWC-0001ZF-UA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:57:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVCWC-0001YX-Ny
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:57:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499774331.git.alistair.francis@xilinx.com>
	<b0192a116ac0fdd125f49f257c6c6dbbc2666969.1499774331.git.alistair.francis@xilinx.com>
Date: Wed, 12 Jul 2017 09:57:04 +0200
In-Reply-To: <b0192a116ac0fdd125f49f257c6c6dbbc2666969.1499774331.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Tue, 11 Jul 2017 05:07:19 -0700")
Message-ID: <87k23eay0f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/8] error: Functions to report warnings
 and informational messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net

Alistair Francis <alistair.francis@xilinx.com> writes:

> Add warn_report(), warn_vreport() for reporting warnings, and
> info_report(), info_vreport() for informational messages.
>
> These are implemented them with a helper function factored out of
> error_vreport(), suitably generalized. This patch makes no changes
> to the output of the original error_report() function.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> v2:
>  - Don't add *vreport() functions to checkpatch
>  - Maintain original comments for the reporting functions
>  - Don't change the error report output in this patch
> v1:
>  - Don't expose the generic report and vreport() functions
>  - Prefix error messages
>  - Use vreport instead of qmsg_vreport()
> RFC V3:
>  - Change the function and enum names to be more descriptive
>  - Add wrapper functions for *_report() and *_vreport()
>
>  include/qemu/error-report.h |   7 +++
>  scripts/checkpatch.pl       |   6 ++-
>  util/qemu-error.c           | 102 +++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 109 insertions(+), 6 deletions(-)
[...]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 73efc927a9..60b1f320a1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2535,7 +2535,11 @@ sub process {
>  				error_prepend|
>  				error_reportf_err|
>  				error_vreport|
> -				error_report}x;
> +				report_vreport|

Should be warn_vreport, oops.  I can fix this on commit.

> +				info_vreport|
> +				error_report|
> +				warn_report|
> +				info_report}x;
>  
>  	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
>  		ERROR("Error messages should not contain newlines\n" . $herecurr);
[...]
