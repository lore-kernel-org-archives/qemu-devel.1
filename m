Received: from eggs.gnu.org ([2001:4830:134:3::10]:46552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dT0tm-00066H-6T
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dT0ti-0007Wv-Un
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:08:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:58277 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dT0ti-0007W0-NK
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:08:22 -0400
References: <1499234355-138591-1-git-send-email-agraf@suse.de>
	<87bmozb7hj.fsf@dusky.pond.sub.org>
From: Alexander Graf <agraf@suse.de>
Message-ID: <a58a7cf7-a079-2799-ac99-696b85ecc654@suse.de>
Date: Thu, 6 Jul 2017 09:08:18 +0200
MIME-Version: 1.0
In-Reply-To: <87bmozb7hj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vnc: Set default kbd delay to 10ms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>



On 05.07.17 10:42, Markus Armbruster wrote:
> Alexander Graf <agraf@suse.de> writes:
> 
>> The default keyboard delay time in the input layer is 10ms. I don't know
> 
> Do you mean "is 1ms"?

Yes, of course :). Sorry.


Alex

> 
>> how that number came to be, but empirical tests on some OpenQA driven ARM
>> systems show that 10ms really is a reasonable default number for the delay.
>>
>> With the current 1ms we're constantly typing faster than the guest receives
>> keyboard events from our XHCI attached USB HID device.
>>
>> This patch moves the delay to 10ms. That way our default is much safer (good!)
>> and also consistent with the input layer default (also good!).
>>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
