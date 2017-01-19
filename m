Received: from eggs.gnu.org ([2001:4830:134:3::10]:48403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUGpl-0004aW-AJ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUGpi-0003i5-2r
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:49:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cUGph-0003hN-U7
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:49:10 -0500
Date: Thu, 19 Jan 2017 17:49:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170119174903.GH2085@work-vm>
References: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
	<1484566314-3987-2-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484566314-3987-2-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/5] block/vvfat: Remove the undesirable
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> Remove the "// assert(is_consistent(s))" comment in block/vvfat.c
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

It looks like it's been commented out for about 11 years now - it can go.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  block/vvfat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index ded2109..7b706dc 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1189,7 +1189,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>          init_mbr(s, cyls, heads, secs);
>      }
>  
> -    //    assert(is_consistent(s));
>      qemu_co_mutex_init(&s->lock);
>  
>      /* Disable migration when vvfat is used rw */
> -- 
> 2.6.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
