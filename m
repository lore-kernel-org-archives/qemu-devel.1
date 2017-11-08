Received: from eggs.gnu.org ([2001:4830:134:3::10]:39375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCH2A-0005ja-EX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCH25-0000u9-JW
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:28:10 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:48857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCH25-0000u0-En
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:28:05 -0500
Received: by mail-qt0-x244.google.com with SMTP id f8so1740418qta.5
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 19:28:05 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-6-f4bug@amsat.org>
	<b49e3557-7593-44ac-3337-41ee95451457@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <17a9e801-0f13-a438-e57d-f511c5ed92ee@amsat.org>
Date: Wed, 8 Nov 2017 00:28:00 -0300
MIME-Version: 1.0
In-Reply-To: <b49e3557-7593-44ac-3337-41ee95451457@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] hw/i386: deprecate the pc-0.10 and
 pc-0.11 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

Hi Alexey,

On 11/07/2017 11:48 PM, Alexey Kardashevskiy wrote:
> On 08/11/17 13:28, Philippe Mathieu-Daudé wrote:
>> Both are deprecated since 2.9.0
> 
> May be so but I could not find where this happened in git history:
> 
> [vpl1 qemu]$ git log -n1 --grep 'pc-0.10'
> f6d5a0bad2 2 years, 5 months ago Eduardo Habkost piix: Define PC_COMPAT_0_10
> 
> Having some pointers in the commit log would be helpful imho, like [2/6].

Ok! If there is positive feedback on this series I'll respin trying to
be more verbose.

I took "2.9.0" from the wiki history [1], which is the formal way to go
as I understand:

Before an "interface" can be removed, there needs to be a clear
transition plan for doing so. This means it should be added to this wiki
page, and that there have to be at least two public releases of QEMU
where the interface still works, but issues a warning when used. Two
public releases are required so that the users have at least one
development cycle to complain if they think that there is a good reason
that the interface should not be removed. The warning should say that
the interface is deprecated / going away soon, with a pointer to
documentation or similar information about its replacement syntax.

[1]
https://wiki.qemu.org/index.php?title=Features/LegacyRemoval&action=history

>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/i386/pc_piix.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index f79d5cb694..c462b702ff 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -941,6 +941,7 @@ static void pc_i440fx_0_11_machine_options(MachineClass *m)
>>      pc_i440fx_0_12_machine_options(m);
>>      m->hw_version = "0.11";
>>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
>> +    m->deprecated_reason = "Too old";
>>  }
>>  
>>  DEFINE_I440FX_MACHINE(v0_11, "pc-0.11", pc_compat_0_13,
>> @@ -976,6 +977,7 @@ static void pc_i440fx_0_10_machine_options(MachineClass *m)
>>      pc_i440fx_0_11_machine_options(m);
>>      m->hw_version = "0.10";
>>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_10);
>> +    m->deprecated_reason = "Too old";
>>  }
>>  
>>  DEFINE_I440FX_MACHINE(v0_10, "pc-0.10", pc_compat_0_13,
>>
