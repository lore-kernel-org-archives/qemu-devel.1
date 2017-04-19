Received: from eggs.gnu.org ([2001:4830:134:3::10]:55062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0pAb-0005Z4-37
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0pAa-0002rp-9q
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:57:17 -0400
Date: Wed, 19 Apr 2017 20:57:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170419125704.GA12781@lemon.lan>
References: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
	<1491057878-27868-5-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491057878-27868-5-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/6] vmdk: Rename get_cluster_offset()
 to vmdk_get_cluster_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Sat, 04/01 20:14, Ashijeet Acharya wrote:
> Rename the existing get_cluster_offset() function to
> vmdk_get_cluster_offset() and have it make use of the new
> get_cluster_table() to load the cluster tables. Also, it is no longer
> used to allocate new clusters and hence perform COW. Make the necessary
> renames at all the occurrences of get_cluster_offset().
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  block/vmdk.c | 117 +++++++++++------------------------------------------------
>  1 file changed, 21 insertions(+), 96 deletions(-)

This is definitely more than a function rename, like I said in reply to patch 3,
it could probably be split to smaller ones (rename, and others, for example),
and reordered to make reviewing easier.

Fam
