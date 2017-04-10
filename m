Received: from eggs.gnu.org ([2001:4830:134:3::10]:55993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cxZ01-0001XY-WB
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cxYzy-0007N4-4c
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:04:53 -0400
MIME-Version: 1.0
In-Reply-To: <1491057878-27868-2-git-send-email-ashijeetacharya@gmail.com>
References: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
	<1491057878-27868-2-git-send-email-ashijeetacharya@gmail.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon, 10 Apr 2017 18:34:47 +0530
Message-ID: <CAC2QTZaeOqHOwD5M=FU6Mg5HY1PvCgxbm1QyoAv0y2XE6xR5mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Ashijeet Acharya <ashijeetacharya@gmail.com>

On Sat, Apr 1, 2017 at 8:14 PM, Ashijeet Acharya
<ashijeetacharya@gmail.com> wrote:
> Move the existing vmdk_find_offset_in_cluster() function to the top of
> the driver. Also, introduce a new helper function size_to_clusters()
> which returns the number of clusters for a given size in bytes. Here,
> we leave the last cluster as we need to perform COW for that one.
>
I will remove the trailing part of the commit message in v4 as there
is no size_to_clusters() in this patch anymore, I forgot to update it!

Ashijeet
