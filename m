Received: from eggs.gnu.org ([2001:4830:134:3::10]:48624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRiOc-0001SL-JO
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRiOV-0006Yo-Rn
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:38:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cRiOV-0006Yf-MB
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:38:31 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5AA3C04B95A
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 16:38:31 +0000 (UTC)
References: <20170111173528.30510-1-lersek@redhat.com>
	<20170112175657-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2f3915c4-c27d-f50d-2c6e-c79fe5bf8430@redhat.com>
Date: Thu, 12 Jan 2017 17:38:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170112175657-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 wave 2 0/3] q35: add negotiable
 broadcast SMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01/12/17 16:57, Michael S. Tsirkin wrote:
> On Wed, Jan 11, 2017 at 06:35:25PM +0100, Laszlo Ersek wrote:
>> This is the second (ICH9-LPC) half of the v5 iteration of the series
>> posted here:
>> <http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00129.html>.
>>
>> In this version, the ICH9-LPC patches have been separated into a
>> standalone "wave", for helping review / maintenance. More importantly,
>> I've addressed Igor's v4 feedback (which happens to address Eduardo's
>> feedback as well). See the individual patches for the details.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Thanks
>> Laszlo
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Awesome, thanks!

I'll send out v6 soon, addressing Eduardo's feedback.

Laszlo

> 
>> Laszlo Ersek (3):
>>   hw/isa/lpc_ich9: add SMI feature negotiation via fw_cfg
>>   hw/isa/lpc_ich9: add broadcast SMI feature
>>   hw/isa/lpc_ich9: negotiate SMI broadcast on pc-q35-2.9+ machine types
>>
>>  include/hw/i386/ich9.h | 13 ++++++++
>>  include/hw/i386/pc.h   |  5 +++
>>  hw/isa/lpc_ich9.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 108 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.9.3
