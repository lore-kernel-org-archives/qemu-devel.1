Received: from eggs.gnu.org ([2001:4830:134:3::10]:38853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyi7T-0007un-8a
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyi7S-0005gD-Fu
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:05:51 -0400
References: <20180223152640.11459-1-pbonzini@redhat.com>
	<20180223152640.11459-3-pbonzini@redhat.com>
	<663bee4b-0554-9b68-6253-1ebe75bc7b3b@redhat.com>
	<1ec25159-2ce7-1eaf-19fe-3ffccbad1c00@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <16c7fc69-10d6-cc0f-cd2e-5ace25a40b2a@redhat.com>
Date: Wed, 21 Mar 2018 14:05:29 -0400
MIME-Version: 1.0
In-Reply-To: <1ec25159-2ce7-1eaf-19fe-3ffccbad1c00@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] ide: push end_transfer callback to
 ide_transfer_halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org



On 03/21/2018 01:39 AM, Paolo Bonzini wrote:
> On 20/03/2018 23:11, John Snow wrote:
>> Seems sane, with some lingering questions about what the PIO Setup FIS
>> is supposed to do to begin with still remaining.
> 
> I agree here too.  Smashing the ATA and controller in the same device
> makes things tricky, so I tried to make these patches pure code motion,
> as much as I could.
> 
> Paolo
> 

Oh, I understand. There's a reason I haven't touched the PIO Setup FIS
much when I cleaned the device up before.

I was just hoping you'd magically know more about it.

:)
