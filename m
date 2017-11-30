Received: from eggs.gnu.org ([2001:4830:134:3::10]:42347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKnlt-00067J-Im
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKnlJ-0003GC-Oj
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:02:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eKnlI-0003Bd-MG
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:02:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A9643D94F
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 20:03:38 +0000 (UTC)
References: <1512069303-16986-1-git-send-email-thuth@redhat.com>
	<20171130193202.GE2248@work-vm>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <334e895e-aa24-7dee-424e-b402dde823a4@redhat.com>
Date: Thu, 30 Nov 2017 21:03:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171130193202.GE2248@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] hmp-commands: Remove the
 deprecated usb_add and usb_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On 30.11.2017 20:32, Dr. David Alan Gilbert wrote:
> * Thomas Huth (thuth@redhat.com) wrote:
>> It's easy to use device_add and device_del as replacement instead.
>> The usb_add and usb_del commands are deprecated since QEMU 2.10,
>> and nobody complained that they are still needed, so let's get rid
>> of them now to make the HMP interface a little bit less overloaded.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Looks like you can kill off usb_device_delete_addr as well.

Right, well spotted! Thanks, I'll send a v2...

 Thomas
