Received: from eggs.gnu.org ([2001:4830:134:3::10]:51078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d0rQQ-0006aW-FC
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d0rQP-00041B-IK
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:21:46 -0400
MIME-Version: 1.0
References: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
	<1491057878-27868-5-git-send-email-ashijeetacharya@gmail.com>
	<20170419125704.GA12781@lemon.lan>
In-Reply-To: <20170419125704.GA12781@lemon.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 19 Apr 2017 15:21:32 +0000
Message-ID: <CAC2QTZZC7b_DfT7fbW__+42am0EF5eto1T_oW2jqnfgCpLsPfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Fam Zheng <famz@redhat.com>
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@gmail.com

On Wed, Apr 19, 2017 at 18:27 Fam Zheng <famz@redhat.com> wrote:

> On Sat, 04/01 20:14, Ashijeet Acharya wrote:
> > Rename the existing get_cluster_offset() function to
> > vmdk_get_cluster_offset() and have it make use of the new
> > get_cluster_table() to load the cluster tables. Also, it is no longer
> > used to allocate new clusters and hence perform COW. Make the necessary
> > renames at all the occurrences of get_cluster_offset().
> >
> > Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> > ---
> >  block/vmdk.c | 117
> +++++++++++------------------------------------------------
> >  1 file changed, 21 insertions(+), 96 deletions(-)
>
> This is definitely more than a function rename, like I said in reply to
> patch 3,
> it could probably be split to smaller ones (rename, and others, for
> example),
> and reordered to make reviewing easier.


Maybe, because I have also refactored it to have vmdk_get_cluster_offset()
make use of the get_cluster_table() (and friends) to avoid duplication.

I will try to split it as

1. Rename
2. Refactor it to make use of get_cluster_table() by moving that out of
patch 3 as of now.

Will that work?

I think this will also keep the compiler happy while reviewing.

Ashijeet
