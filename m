Received: from eggs.gnu.org ([2001:4830:134:3::10]:40870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d10EP-00023i-Ss
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 20:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d10EP-00010y-4u
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 20:45:57 -0400
Date: Thu, 20 Apr 2017 08:45:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420004544.GA25568@lemon.lan>
References: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
	<1491057878-27868-5-git-send-email-ashijeetacharya@gmail.com>
	<20170419125704.GA12781@lemon.lan>
	<CAC2QTZZC7b_DfT7fbW__+42am0EF5eto1T_oW2jqnfgCpLsPfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC2QTZZC7b_DfT7fbW__+42am0EF5eto1T_oW2jqnfgCpLsPfA@mail.gmail.com>
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@gmail.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

On Wed, 04/19 15:21, Ashijeet Acharya wrote:
> On Wed, Apr 19, 2017 at 18:27 Fam Zheng <famz@redhat.com> wrote:
> 
> > On Sat, 04/01 20:14, Ashijeet Acharya wrote:
> > > Rename the existing get_cluster_offset() function to
> > > vmdk_get_cluster_offset() and have it make use of the new
> > > get_cluster_table() to load the cluster tables. Also, it is no longer
> > > used to allocate new clusters and hence perform COW. Make the necessary
> > > renames at all the occurrences of get_cluster_offset().
> > >
> > > Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> > > ---
> > >  block/vmdk.c | 117
> > +++++++++++------------------------------------------------
> > >  1 file changed, 21 insertions(+), 96 deletions(-)
> >
> > This is definitely more than a function rename, like I said in reply to
> > patch 3,
> > it could probably be split to smaller ones (rename, and others, for
> > example),
> > and reordered to make reviewing easier.
> 
> 
> Maybe, because I have also refactored it to have vmdk_get_cluster_offset()
> make use of the get_cluster_table() (and friends) to avoid duplication.
> 
> I will try to split it as
> 
> 1. Rename
> 2. Refactor it to make use of get_cluster_table() by moving that out of
> patch 3 as of now.
> 
> Will that work?

Sounds good. Thanks.

Fam
