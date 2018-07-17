Received: from eggs.gnu.org ([2001:4830:134:3::10]:47842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffUVI-0003nh-NJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 14:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffUVE-0007Pu-Hs
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 14:15:16 -0400
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-7-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30fedbb2-24fc-7356-63b6-2544cfa7af54@redhat.com>
Date: Tue, 17 Jul 2018 20:15:05 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-7-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 06/15] s390-bios: Clean up cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 05.07.2018 19:25, Jason J. Herne wrote:
> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Add proper typedefs to all structs and modify all bit fields to use consistent
> formatting.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
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

checkpatch.pl does not like these spaces, so I think it would be better
to not make these changes (otherwise we'll have to deal with the output
of checkpatch each time again we want to change something here).

 Thomas
