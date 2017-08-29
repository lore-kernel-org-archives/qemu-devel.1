Received: from eggs.gnu.org ([2001:4830:134:3::10]:59816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dmhhP-0001FS-22
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dmhhJ-00046Z-8i
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:41:03 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:22390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dmhhI-0003yV-VT
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:40:57 -0400
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fucafnk2.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <a81bc8f8-8ceb-8f92-1554-bc0d26180b1d@huawei.com>
Date: Tue, 29 Aug 2017 16:39:39 +0200
MIME-Version: 1.0
In-Reply-To: <w51fucafnk2.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 8/29/2017 4:36 PM, Alberto Garcia wrote:
> On Tue 29 Aug 2017 04:23:01 PM CEST, Pradeep Jagadeesh wrote:
>> These patches provide the qmp interface, to query the io throttle
>> status of the all fsdev devices that are present in a vm.
>> also, it provides an interface to set the io throttle parameters of a
>> fsdev to a required value. some of the patches also remove the duplicate
>> code that was present in block and fsdev files.
>
> Oops, I was just reviewing the previous version of this series, but it
> looks like you just moved code around, so my comments still apply.
>
> Anyway, this should be v9, shouldn't it? v8 was published weeks ago:
>
>    https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01043.html

Hmm, sorry it should be v9, I missed. I will resend the patches with 
newer version.

Regards,
Pradeep
>
> Berto
>
