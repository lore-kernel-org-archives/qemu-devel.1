Received: from eggs.gnu.org ([2001:4830:134:3::10]:53126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfrUh-00046A-P2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfrUg-0000F7-C2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:43:39 -0400
MIME-Version: 1.0
In-Reply-To: <CAC2QTZY0P=TCkDuOByDuGwhqSYHC_LA=dZM1Odb9t628g-M8tw@mail.gmail.com>
References: <1501165990-28033-1-git-send-email-ashijeetacharya@gmail.com>
	<CAJSP0QXXM1_dQSS=34wV+JMnSaqYpyxtptPW+2VrYy1OV109Tg@mail.gmail.com>
	<CAC2QTZY0P=TCkDuOByDuGwhqSYHC_LA=dZM1Odb9t628g-M8tw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 10 Aug 2017 18:43:34 +0100
Message-ID: <CAJSP0QUgre0znYYdVwkEaef0u7N1PT+Mh3bL+JCopshuriyh2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 0/8] Optimize VMDK I/O by allocating
 multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Thu, Aug 10, 2017 at 9:18 AM, Ashijeet Acharya
<ashijeetacharya@gmail.com> wrote:
> On Thu, Aug 10, 2017 at 1:41 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Thu, Jul 27, 2017 at 3:33 PM, Ashijeet Acharya
>> <ashijeetacharya@gmail.com> wrote:
>> > Previously posted series patches:
>> > v1 -
>> > http://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg02044.html
>> > v2 -
>> > http://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg05080.html
>> > v3 -
>> > http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg00074.html
>> > v4 -
>> > http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg03851.html
>> > v5 -
>> > http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg00929.html
>> > v6 -
>> > http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg00947.html
>> > v7 -
>> > http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg06600.html
>> >
>> > This series helps to optimize the I/O performance of VMDK driver.
>> >
>> > Patch 1 helps us to move vmdk_find_offset_in_cluster.
>> >
>> > Patch 2 & 3 perform a simple function re-naming tasks.
>> >
>> > Patch 4 is used to factor out metadata loading code and implement it in
>> > separate
>> > functions. This will help us to avoid code duplication in future patches
>> > of this
>> > series.
>> >
>> > Patch 5 helps to set the upper limit of the bytes handled in one cycle.
>> >
>> > Patch 6 adds new functions to help us allocate multiple clusters
>> > according to
>> > the size requested, perform COW if required and return the offset of the
>> > first
>> > newly allocated cluster.
>> >
>> > Patch 7 changes the metadata update code to update the L2 tables for
>> > multiple
>> > clusters at once.
>> >
>> > Patch 8 helps us to finally change vmdk_get_cluster_offset() to find
>> > cluster
>> > offset only as cluster allocation task is now handled by
>> > vmdk_alloc_clusters()
>> >
>> > Optimization test results:
>> >
>> > This patch series improves 128 KB sequential write performance to an
>> > empty VMDK file by 54%
>> >
>> > Benchmark command: ./qemu-img bench -w -c 1024 -s 128K -d 1 -t none -f
>> > vmdk test.vmdk
>> >
>> > Changes in v8:
>> > - fix minor variable naming issue in patch 6
>>
>> Fam: Ping?
>>
>> Ashijeet: Feel free to send a ping reply if no one reviews your
>> patches within a few days.
>
>
> Hi Stefan,
>
> I had a chat with Fam on #qemu-block before submitting this series and he
> said he will be merging it soon when the freeze is over (I am not sure if it
> is yet) since all the patches are already reviewed :-)

Good to hear :).

QEMU 2.10 is scheduled to be released on 22nd or 29th of August.

Stefan
