Received: from eggs.gnu.org ([209.51.188.92]:47053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH52j-00008N-E2
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH4nT-0002TQ-A0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:01:46 -0400
References: <20190417115343.30527-1-pbonzini@redhat.com>
	<CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
	<cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
	<20190418104737.GC5242@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87b281df-e0a0-6537-0e1a-4c6af28ffc01@redhat.com>
Date: Thu, 18 Apr 2019 13:01:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190418104737.GC5242@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 18/04/19 12:47, Kevin Wolf wrote:
>> This is acually only an issue with kernels prior to 4.5, so it should be
>> fixed downstream instead.
>
> I don't think that upstream QEMU has kernels > 4.5 as an official
> requirement, though? We try to be compatible with quite old libs, so we
> should stay compatible with old kernels, too.

It is a pretty rare case, where the host must support very large
scatter/gather lists (>=1024 elements) and there is a workaround by
setting max_sectors_kb to 4096 in the host.  It also makes performance
worse.

Having already written and posted the patch, I can of course apply it
too, but I'm not sure it's a good idea.  4.4 is already a pretty old
kernel and whoever is using it likely will not get the fix for free by
using a very new QEMU.

Paolo
