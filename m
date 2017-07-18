Received: from eggs.gnu.org ([2001:4830:134:3::10]:41962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXV1P-00087w-KX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXV1L-000675-2i
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXV1K-00063U-NH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:06:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170717081152.17153-10-lprosek@redhat.com>
Date: Tue, 18 Jul 2017 18:06:41 +0200
In-Reply-To: <20170717081152.17153-10-lprosek@redhat.com> (Ladi Prosek's
	message of "Mon, 17 Jul 2017 10:11:52 +0200")
Message-ID: <87eftdrapa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 9/9] checkpatch: add virtio_error and
 virtqueue_error to error funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

Ladi Prosek <lprosek@redhat.com> writes:

> Two more error functions that should not contain newlines.
>
> Suggested-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  scripts/checkpatch.pl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4e91122..2cd2713 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2540,7 +2540,9 @@ sub process {
>  				info_vreport|
>  				error_report|
>  				warn_report|
> -				info_report}x;
> +				info_report|
> +				virtio_error|
> +				virtqueue_error}x;
>  
>  	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
>  		ERROR("Error messages should not contain newlines\n" . $herecurr);

What makes the two functions appropriate for this list is this pattern:

    va_start(ap, fmt);
    msg = g_strdup_vprintf(fmt, ap);
    va_end(ap);

    error_report("... %s", ..., msg);

There's a related pattern using error_vreport().

Do we have more instances of these patterns?

Regardless:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
