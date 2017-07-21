Received: from eggs.gnu.org ([2001:4830:134:3::10]:36840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dYcYD-0003Kg-Q0
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dYcY8-0006wC-TV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:21:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dYcY8-0006vw-NI
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:21:16 -0400
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500533554.6553.1.camel@redhat.com>
	<3e0f92ea-58ce-abfb-1aed-4d56c1fa68b2@redhat.com>
	<1500631461.12926.5.camel@redhat.com>
	<eeba9fcf-4b52-2c24-af03-d88333cd2dc6@redhat.com>
	<20170721172843.GA6606@morn.lan>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <510a9fe7-2a38-f8c4-caa6-27c2805890c1@redhat.com>
Date: Fri, 21 Jul 2017 21:21:08 +0300
MIME-Version: 1.0
In-Reply-To: <20170721172843.GA6606@morn.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH 0/2] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On 21/07/2017 20:28, Kevin O'Connor wrote:
> On Fri, Jul 21, 2017 at 03:15:46PM +0300, Marcel Apfelbaum wrote:
>> On 21/07/2017 13:04, Gerd Hoffmann wrote:
>>> I'd prefer to have a single vendor capability for all resource
>>> allocation hints provided by qemu.
>> Sure, the capability looking something like:
>>
>>     [flags: reserve-buses|reserve-IO|reserve-MEM|...]
>>     [extra-buses][IO-size][MEM-size]
>>
>>     if reserve-buses -> use 'extra-buses' value and so on
> 
> I don't have any objection to using a PCI capability, but I do wonder
> if fw_cfg would be a better fit.  This information is purely qemu ->
> firmware, right?
> 

Hi Kevin,

Right, but theoretically speaking a guest OS driver could also
get the hint on hotplug, or simply because the OS chooses to re-assign
resources on its own.

A while ago we discussed the fw_cfg option, but Gerd preferred
the vendor capability, and since the capability looked cleaner
Aleksandr opted for it.

He will send V2 soon together with the QEMU counterpart feature.

Thanks,
Marcel

> -Kevin
> 
