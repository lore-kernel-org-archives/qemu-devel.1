Received: from eggs.gnu.org ([2001:4830:134:3::10]:38353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG1bz-00019y-EG
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG1bw-0004XK-30
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:20:55 -0400
Date: Tue, 8 May 2018 14:20:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508142048.1873edf4.cohuck@redhat.com>
In-Reply-To: <1525774672-11913-1-git-send-email-thuth@redhat.com>
References: <1525774672-11913-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: struct tpi_info must be
 declared as aligned(4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue,  8 May 2018 12:17:52 +0200
Thomas Huth <thuth@redhat.com> wrote:

> I've run into a compilation error today with the current version of GCC 8:
> 
> In file included from s390-ccw.h:49,
>                  from main.c:12:
> cio.h:128:1: error: alignment 1 of 'struct tpi_info' is less than 4 [-Werror=packed-not-aligned]
>  } __attribute__ ((packed));
>  ^
> cc1: all warnings being treated as errors
> 
> Since the struct tpi_info contains an element ("struct subchannel_id schid")
> which is marked as aligned(4), we've got to mark the struct tpi_info as
> aligned(4), too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/cio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> index 55eaeee..1a0795f 100644
> --- a/pc-bios/s390-ccw/cio.h
> +++ b/pc-bios/s390-ccw/cio.h
> @@ -125,7 +125,7 @@ struct tpi_info {
>      __u32 reserved3  : 12;
>      __u32 int_type   : 3;
>      __u32 reserved4  : 12;
> -} __attribute__ ((packed));
> +} __attribute__ ((packed, aligned(4)));
>  
>  /* channel command word (type 1) */
>  struct ccw1 {

Thanks, queued to s390-next with a cc:stable.
