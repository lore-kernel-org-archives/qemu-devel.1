Received: from eggs.gnu.org ([2001:4830:134:3::10]:42849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffSf5-0002r7-Qh
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffSf0-0005zx-TY
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:17:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffSf0-0005zg-N9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:17:10 -0400
References: <20180714123000.11326-1-viktor.prutyanov@virtuozzo.com>
	<20180716211647.GQ914@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5fff0207-9a57-3db7-08f7-177d78c6a568@redhat.com>
Date: Tue, 17 Jul 2018 18:17:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180716211647.GQ914@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] dump: add kernel_gs_base to QEMU CPU
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, rkagan@virtuozzo.com, rth@twiddle.net

On 16/07/2018 23:16, Eduardo Habkost wrote:
> On Sat, Jul 14, 2018 at 03:30:00PM +0300, Viktor Prutyanov wrote:
>> This patch adds field with content of KERNEL_GS_BASE MSR to QEMU note in
>> ELF dump.
>>
>> On Windows, if all vCPUs are running usermode tasks at the time the dump is
>> created, this can be helpful in the discovery of guest system structures
>> during conversion ELF dump to MEMORY.DMP dump.
>>
>> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
> 
> Queued for 3.1, thanks.

Oh, I sent it for 3.0 already.

Paolo
