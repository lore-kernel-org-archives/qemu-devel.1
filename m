Received: from eggs.gnu.org ([2001:4830:134:3::10]:39767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlAiL-00023n-B7
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlAiJ-0000dp-RE
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:15:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dlAiJ-0000cZ-Fp
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:15:39 -0400
References: <150360081780.16351.6836234147404830593@loki>
	<1a05478e-b75d-c149-eaf3-b00b4cf4a4e2@redhat.com>
	<CAFEAcA_HBmo5U8uWW5eEbmusMfTuL-5TLm18daZOBqR0cioPag@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <610551e8-9098-614e-c0c4-1e306cda67c3@redhat.com>
Date: Fri, 25 Aug 2017 11:15:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_HBmo5U8uWW5eEbmusMfTuL-5TLm18daZOBqR0cioPag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Hannes Reinecke <hare@suse.de>

On 25/08/2017 11:13, Peter Maydell wrote:
> On 24 August 2017 at 20:06, Laszlo Ersek <lersek@redhat.com> wrote:
>> Has it not been the intent to include the following patch in 2.10:
>>
>>   [PATCH] scsi-bus: correct responses for INQUIRY and REQUEST SENSE
>>   http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03351.html
>>   Message-Id: <1503049022-14749-1-git-send-email-hare@suse.de>
>>
>> Paolo CC'd it to stable.
>>
>> Apologies if I misunderstood.
> 
> Nobody flagged it up on the wiki planning page or replied to my
> "are there any other RC things we should fix for 2.10" emails
> about it. If it has to go into an RC then it needs to get my
> attention as a release-critical bug (which is a stronger
> criterion than just should-go-into-next-stable release).

No problem, it was nice-to-have indeed, but since Laszlo has fixed it in
OVMF it is not a tragedy.

Paolo
