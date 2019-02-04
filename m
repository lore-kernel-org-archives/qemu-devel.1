Received: from eggs.gnu.org ([209.51.188.92]:42492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbnM-0002QS-Kh
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbnL-0003AC-Pn
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:48:08 -0500
Date: Mon, 4 Feb 2019 11:48:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204114801.2699c9a0.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-7-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-7-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/15] s390-bios: Clean up cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:13 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Add proper typedefs to all structs and modify all bit fields to use consistent
> formatting.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.h      | 86 ++++++++++++++++++++++-----------------------
>  pc-bios/s390-ccw/s390-ccw.h |  8 -----
>  2 files changed, 43 insertions(+), 51 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> index 1a0795f..a48eee5 100644
> --- a/pc-bios/s390-ccw/cio.h
> +++ b/pc-bios/s390-ccw/cio.h
> @@ -53,12 +53,12 @@ struct schib_config {
>      __u64 mba;
>      __u32 intparm;
>      __u16 mbi;
> -    __u32 isc:3;
> -    __u32 ena:1;
> -    __u32 mme:2;
> -    __u32 mp:1;
> -    __u32 csense:1;
> -    __u32 mbfc:1;
> +    __u32 isc    : 3;
> +    __u32 ena    : 1;
> +    __u32 mme    : 2;
> +    __u32 mp     : 1;
> +    __u32 csense : 1;
> +    __u32 mbfc   : 1;
>  } __attribute__ ((packed));

This seems to make checkpatch unhappy... maybe consolidate to the other
formatting instead?
