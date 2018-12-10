Received: from eggs.gnu.org ([2001:4830:134:3::10]:51408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWO2V-0000LW-KN
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWNvq-0000QB-1Z
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:57:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWNvp-0000PR-6X
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:57:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so11774540wmh.0
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:57:17 -0800 (PST)
References: <20181207165103.3992-1-philmd@redhat.com>
	<20181207165103.3992-5-philmd@redhat.com>
	<59daee09-d797-3340-3fd3-c6d521d2cf68@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bfa8379c-03e1-9e40-f588-edf402d93716@redhat.com>
Date: Mon, 10 Dec 2018 16:57:13 +0100
MIME-Version: 1.0
In-Reply-To: <59daee09-d797-3340-3fd3-c6d521d2cf68@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/smbios: Move to the hw/firmware/
 namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 12/10/18 4:10 PM, Laszlo Ersek wrote:
> On 12/07/18 17:51, Philippe Mathieu-Daudé wrote:
>> SMBIOS is just another firmware used by some QEMU models.
>> We will later introduce more firmwares in this namespace.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  MAINTAINERS                              | 2 +-
>>  hw/arm/virt.c                            | 2 +-
>>  hw/i386/pc.c                             | 2 +-
>>  hw/i386/pc_piix.c                        | 2 +-
>>  hw/i386/pc_q35.c                         | 2 +-
>>  hw/smbios/smbios-stub.c                  | 2 +-
>>  hw/smbios/smbios.c                       | 2 +-
>>  hw/smbios/smbios_type_38.c               | 2 +-
>>  include/hw/{smbios => firmware}/smbios.h | 0
>>  tests/bios-tables-test.c                 | 2 +-
>>  vl.c                                     | 2 +-
>>  11 files changed, 10 insertions(+), 10 deletions(-)
>>  rename include/hw/{smbios => firmware}/smbios.h (100%)
> 
> (1) Please replace the word "namespace" in the subject, and in the
> commit message too, with "subdirectory".
> 
> (2) Please replace "firmware" -- both instances -- in the commit message
> with "firmware interface", or perhaps "firmware specification".

I'll go with "firmware interface", because I'd like to eventually put
here helpers for firmwares with no public specification.

> With the updates:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thanks,
> Laszlo
