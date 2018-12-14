Received: from eggs.gnu.org ([2001:4830:134:3::10]:55903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXlkT-0005yv-7W
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXlkS-0004Iz-FO
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:35:17 -0500
References: <20181122133507.30950-1-peter.maydell@linaro.org>
	<CAFEAcA-xzUS4Nrf9dq26-Pp-c5TM-gdMTBBMr-fjFBSd4AZmYg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4d6c13a-5b21-da85-5147-cdc575eb6c9e@redhat.com>
Date: Fri, 14 Dec 2018 12:34:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-xzUS4Nrf9dq26-Pp-c5TM-gdMTBBMr-fjFBSd4AZmYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-4.0 0/2] Rename
 cpu_physical_memory_write_rom() to address_space_write_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 14/12/18 12:32, Peter Maydell wrote:
> On Thu, 22 Nov 2018 at 13:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> The API of cpu_physical_memory_write_rom() is odd, because it
>> takes an AddressSpace, unlike all the other cpu_physical_memory_*
>> access functions. We note this oddity as a TODO in the
>> docs/devel/loads-stores.rst documentation.
>>
>> Rename cpu_physical_memory_write_rom() to address_space_write_rom(),
>> and give it an API that matches address_space_write().
>> We also adjest the cpu_physical_memory_write_rom_internal()
>> function which is local to exec.c similarly.
> 
> Unless somebody would prefer a different route, I'm going
> to add this series to a 'misc' pullreq I'm putting together.

Go ahead, please.

Paolo
