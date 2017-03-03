Received: from eggs.gnu.org ([2001:4830:134:3::10]:34055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1cjhuR-0001pP-C4
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 02:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1cjhuO-0005nn-3t
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 02:45:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1cjhuN-0005nN-Ru
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 02:45:48 -0500
From: Bandan Das <bsd@redhat.com>
References: <20170214073551.GA9055@pxdev.xzpeter.org>
	<CAHyh4xiATAV801U7zjK1F_B+7e2bDWhH1-gpFKF3U1jNmCfScw@mail.gmail.com>
	<20170215025243.GA3988@pxdev.xzpeter.org>
	<20170215033452.GB3988@pxdev.xzpeter.org>
	<20170215111552.5405418a@t450s.home>
	<20170216022839.GC15985@pxdev.xzpeter.org>
	<20170215194758.4622d73c@t450s.home>
	<CAHyh4xg6oRVoW81QgdQRoL0Oc7jHm7prgyd--ghYQ4d4_aSUpQ@mail.gmail.com>
	<CAHyh4xi0qOaL5X5E6yLpf2O=RYR=G8X=zjr7g+h8QtntYPnsFA@mail.gmail.com>
	<jpgefyfs4m4.fsf@linux.bootlegged.copy>
	<20170303034303.GA20768@pxdev.xzpeter.org>
Date: Fri, 03 Mar 2017 02:45:44 -0500
In-Reply-To: <20170303034303.GA20768@pxdev.xzpeter.org> (Peter Xu's message of
	"Fri, 3 Mar 2017 11:43:04 +0800")
Message-ID: <jpg37eupzvb.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] iommu emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jintack Lim <jintack@cs.columbia.edu>, QEMU Devel Mailing List <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Thu, Mar 02, 2017 at 05:20:19PM -0500, Bandan Das wrote:
>> Jintack Lim <jintack@cs.columbia.edu> writes:
>> 
>> > [cc Bandan]
>> >
...
>> 
>> Jintack, any progress with this ?
>> 
>> I am testing on a X540-AT2 and I see a different behavior. It appears
>> config succeeds but the driver keeps resetting the device due to a Tx
>> hang:
>> 
>> [ 568.612391 ] ixgbe 0000:00:03.0 enp0s3: tx hang 38 detected on queue 0,
>> resetting adapter
>> [ 568.612393 ]  ixgbe 0000:00:03.0 enp0s3: initiating reset due to tx
>> timeout
>> [ 568.612397 ]  ixgbe 0000:00:03.0 enp0s3: Reset adapter
>> 
>> This may be device specific but I think the actual behavior you see is
>> also dependent on the ixgbe driver in the guest. Are you on a recent
>> kernel ? Also, can you point me to the hack (by Peter) that you have
>> mentioned above ?
>
> Hi, Bandan,
>
> Are you using the vtd vfio v7 series or another branch?

Thanks for the tip. Jintack pointed me to your repo and I am using v7
from there.

> If it's the upstream one... just a note that we need to make sure
> "-device intel-iommu" be the first device specified in QEMU command
> line parameters (need to before "-device vfio-pci,..."). Thanks,
>
> -- peterx
