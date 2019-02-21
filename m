Received: from eggs.gnu.org ([209.51.188.92]:37240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gwheH-0000Pc-PB
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 01:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gwheF-0001BS-PB
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 01:15:57 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gwheB-00015s-Jq
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 01:15:54 -0500
Received: by mail-pf1-x444.google.com with SMTP id v21so10226026pfm.12
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 22:15:43 -0800 (PST)
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-2-eric.auger@redhat.com>
	<CAFEAcA-Csfn9qzLxcuCBtmjyCSLbtCELcr4+h=T79gum0JCHCw@mail.gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8bb392bd-0a35-3a26-7476-e3559cbbbcb1@ozlabs.ru>
Date: Thu, 21 Feb 2019 17:15:34 +1100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Csfn9qzLxcuCBtmjyCSLbtCELcr4+h=T79gum0JCHCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 01/18] update-linux-headers.sh: Copy new
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Auger <eric.auger.pro@gmail.com>



On 15/02/2019 03:36, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> From: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> Since Linux'es ab66dcc76d "powerpc: generate uapi header and system call
>> table files" there are 2 new files: unistd_32.h and unistd_64.h. These
>> files content is moved from unistd.h so now we have to copy new files
>> as well, just like we already do for other architectures; this does it
>> for MIPS as well.
>>
>> Also, v5.0-rc2 moved vhost bits around in 4b86713236e4bd
>> "vhost: split structs into a separate header file", add those too.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> I think this fix is handled by commit a0a6ef91a4a4edde27
> (now in master), yes ?

uff, just noticed this mail. yes, it is done by a0a6ef91a4a4edde27. Thanks,


-- 
Alexey
