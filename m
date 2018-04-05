Received: from eggs.gnu.org ([2001:4830:134:3::10]:36798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f48mC-00006z-D4
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f48m7-0007vl-9b
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:34:20 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f48m7-0007vd-0l
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:34:15 -0400
Received: by mail-qt0-x241.google.com with SMTP id v11so27764575qtj.6
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 10:34:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180326150546.11324-1-otubo@redhat.com>
	<9bc635e6-d825-4276-28c2-a16ac0aa96c8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2217556c-776c-e1be-97ae-fdd1df474479@amsat.org>
Date: Thu, 5 Apr 2018 14:34:11 -0300
MIME-Version: 1.0
In-Reply-To: <9bc635e6-d825-4276-28c2-a16ac0aa96c8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, mjt@tls.msk.ru, armbru@redhat.com, ehabkost@redhat.com, agraf@suse.deThomas Huth <thuth@redhat.com>

Hi Paolo,

On 04/05/2018 02:02 PM, Paolo Bonzini wrote:
> On 26/03/2018 17:05, Eduardo Otubo wrote:
>> QEMU fails when used with the following command line:
>>
>>     ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
>>     qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.
>>     Aborted (core dumped)
>>
>> The 40p machine type already creates the device i82374. If specified in
>> the command line, it will try to create it again, hence generating the
>> error. The function isa_bus_dma() isn't supposed to be called twice for
>> the same bus. This patch fixes this issue by propagating back the error
>> so QEMU can fail nicely without Abort or core dump.
>>
>> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> 
> Queued, thanks.

The fix is not this patch but:
http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg06678.html

with
http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg06844.html
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>

and
http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg06827.html
Reviewed-by: Eduardo Otubo <otubo@redhat.com>

Regards,

Phil.
