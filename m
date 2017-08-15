Received: from eggs.gnu.org ([2001:4830:134:3::10]:45601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dha0r-0008B9-02
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dha0n-00038S-2f
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:27:57 -0400
Received: from chuckie.co.uk ([82.165.15.123]:49610
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dha0m-00035y-S5
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:27:53 -0400
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-5-git-send-email-imammedo@redhat.com>
	<20170814095657.549d0bc8@nial.brq.redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b983e544-77fc-f3c3-056f-aa445cfe5053@ilande.co.uk>
Date: Tue, 15 Aug 2017 12:27:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170814095657.549d0bc8@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/28] sparc: convert cpu models to SPARC
 cpu subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

On 14/08/17 08:56, Igor Mammedov wrote:

> On Fri, 14 Jul 2017 15:51:55 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
>> QOMfy cpu models handling introducing propper cpu types
>> for each cpu model.
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> with this and conversion of features to properties,
>> it would be possible to replace cpu_sparc_init() with
>> cpu_generic_init() and reuse common -cpu handling
>> infrastructure.
>>
>> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> 
> ping,
> 
> Mark, Artoym,
> 
> As SPARC maintainers, cloud you please review/test patches 4-10/28.

Yes, sorry - it has been a fairly busy few weeks. I should have some
time to look at these towards the end of the week.


ATB,

Mark.
