Received: from eggs.gnu.org ([2001:4830:134:3::10]:37027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehcXk-0007Zy-VB
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehcXg-0001JG-1D
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:42:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ehcXf-0001Hn-P5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:42:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A48DC04AC50
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 13:25:41 +0000 (UTC)
References: <20180201112028.23552-1-peterx@redhat.com>
	<90b4bc63-94cd-ec0f-32c8-c16df8ee84cf@redhat.com>
	<20180201211652-mutt-send-email-mst@kernel.org>
	<20180201194845.GN2457@work-vm>
	<33142d67-92b6-e1b1-b906-716a06efb1fa@redhat.com>
	<20180202100459.GB4666@xz-mi>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <4ebca0b8-dbe9-01ed-053d-aad9d338cee0@redhat.com>
Date: Fri, 2 Feb 2018 15:25:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180202100459.GB4666@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pcie-root-port: let it has higher migrate
 priority
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 02/02/2018 12:04, Peter Xu wrote:
> On Thu, Feb 01, 2018 at 10:01:31PM +0200, Marcel Apfelbaum wrote:
> 
> [...]
> 
>> Root ports can't be nested, anyway, I suppose the migration should
>> follow the bus numbering order.
> 
> Could I ask whether this is a must?  And if yes, why?
> 

Not sure. The above will ensure that if a device needs some parent/bus
info at load time, the information will be valid.
But if it worked until now, maybe most of the devices do not need that.

>>
>> The question now is what happens if the migration is happening before
>> the guest firmware finishes assigning numbers to buses...
> 
> Do you mean that vIOMMU may fetch wrong context entries too?
> 

No, only that the bus number will not be available at load time.
In this case is OK since the firmware will continue to
assign bus numbers at target side.

Thanks,
Marcel

> Note that as long as vIOMMU DMAR is off globally, vIOMMU will not
> fetch context entries at all.  So IMHO this problem should not happen
> during the firmware execution time (assuming that the firmware should
> not enable vIOMMU at all).
> 
> Thanks,
> 
