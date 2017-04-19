Received: from eggs.gnu.org ([2001:4830:134:3::10]:38572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0oUv-0005jV-4a
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0oUu-0005mk-AU
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:14:13 -0400
Date: Wed, 19 Apr 2017 20:14:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170419121401.GA9638@lemon.lan>
References: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
	<1491057878-27868-2-git-send-email-ashijeetacharya@gmail.com>
	<CAC2QTZaeOqHOwD5M=FU6Mg5HY1PvCgxbm1QyoAv0y2XE6xR5mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC2QTZaeOqHOwD5M=FU6Mg5HY1PvCgxbm1QyoAv0y2XE6xR5mA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/6] vmdk: Move
 vmdk_find_offset_in_cluster() to the top
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

On Mon, 04/10 18:34, Ashijeet Acharya wrote:
> On Sat, Apr 1, 2017 at 8:14 PM, Ashijeet Acharya
> <ashijeetacharya@gmail.com> wrote:
> > Move the existing vmdk_find_offset_in_cluster() function to the top of
> > the driver. Also, introduce a new helper function size_to_clusters()
> > which returns the number of clusters for a given size in bytes. Here,
> > we leave the last cluster as we need to perform COW for that one.
> >
> I will remove the trailing part of the commit message in v4 as there
> is no size_to_clusters() in this patch anymore, I forgot to update it!

With that updated, you can add my:

Reviewed-by: Fam Zheng <famz@redhat.com>
