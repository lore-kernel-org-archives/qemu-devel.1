Received: from eggs.gnu.org ([2001:4830:134:3::10]:60354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fONrC-0005wK-7t
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fONrB-0000Pp-4C
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:43:10 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fONrA-0000PP-Vb
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:43:09 -0400
Received: by mail-oi0-x242.google.com with SMTP id c128-v6so10276239oig.11
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 06:43:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e6827289-812c-eb87-ad52-43094917bb7f@redhat.com>
References: <1527663951-14552-1-git-send-email-zhaoshenglong@huawei.com>
	<e6827289-812c-eb87-ad52-43094917bb7f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 14:42:47 +0100
Message-ID: <CAFEAcA9dCysLQ6vm9WqB6pdrpiee-kVCgfbqqRy2S1nnpf+4Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] ARM: ACPI: Fix use-after-free due to
 memory realloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 30 May 2018 at 10:03, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Shannon,
>
> On 05/30/2018 09:05 AM, Shannon Zhao wrote:
>> acpi_data_push uses g_array_set_size to resize the memory size. If there
>> is no enough contiguous memory, the address will be changed. So previous
>> pointer could not be used any more. It must update the pointer and use
>> the new one.
>>
>> Also, previous codes wrongly use le32 conversion of iort->node_offset
>> for subsequent computations that will result incorrect value if host is
>> not litlle endian. So use the non-converted one instead.
>>
>> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>



Applied to target-arm.next, thanks.

-- PMM
