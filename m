Received: from eggs.gnu.org ([2001:4830:134:3::10]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cb38L-0000Kx-JN
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cb38G-00077T-OH
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:36:25 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:6007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cb38G-00075y-Et
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:36:20 -0500
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <6eb9d362-9d8f-6d63-e500-7039de074694@huawei.com>
Date: Tue, 7 Feb 2017 11:34:28 +0100
MIME-Version: 1.0
In-Reply-To: <71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

On 2/6/2017 8:36 PM, Eric Blake wrote:
> On 02/03/2017 05:57 AM, Pradeep Jagadeesh wrote:
>> This patchset adds the throttle support for the 9p-local driver.
>> For now this functionality can be enabled only through qemu cli options.
>> QMP interface and support to other drivers need further extensions.
>
> This part is a bit scary - if 2.9 is released with just the cli option
> and not the QMP interface, then how does someone like libvirt introspect
> whether the feature is available for use?
I do have plans to extend the qmp interface for this feature.
Already started looking into it.Do not know, I can push it for 2.9. 
Because I am busy with some other work.
>
> Please make sure we don't reach 2.9 with only a half-baked feature;
> whether that means finishing the QMP work or temporarily disabling the
> cli additions until a later release can finish the work.
>
