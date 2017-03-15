Received: from eggs.gnu.org ([2001:4830:134:3::10]:59369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1coAq6-0007cJ-W1
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1coAq2-0006s8-4T
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:27:51 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1coAq2-0006s2-02
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:27:46 -0400
Received: by mail-it0-x242.google.com with SMTP id u69so3418390ita.3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 08:27:45 -0700 (PDT)
In-Reply-To: <mailman.59002.1489587913.22740.qemu-devel@nongnu.org>
References: <mailman.59002.1489587913.22740.qemu-devel@nongnu.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BAC71F10-E3E4-4983-A4A9-2BB3B563B636@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 15 Mar 2017 11:27:42 -0400
Subject: Re: [Qemu-devel] [PATCH v3 0/2] hw/i386: Update FADT to Revision 3
 (ACPI 2.0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>


On Mar 15, 2017, at 10:25 AM, qemu-devel-request@nongnu.org wrote:
>
> On Wed, Mar 15, 2017 at 07:20:25PM +1300, Phil Dennis-Jordan wrote:
>> This updates the FADT generated for x86/64 machine types from  
>> Revision 1 to 3. (Based on ACPI standard 2.0 instead of 1.0) As  
>> previously, the goal is to make running macOS/OS X guests  
>> smoother. With a Rev1 FADT, rebooting such a guest doesn't work,  
>> as the OS uses the reset register information from the FADT.  
>> Switching to a Rev3 (ACPI 2.0) FADT solves this problem.
>>
>> The previous discussion of this raised a bunch of points, which  
>> I'll address/clarify here as well:
>>
>>  1. No runtime option. The preference was expressed that we try to  
>> stay backwards-compatible with legacy guests as opposed to adding  
>> a runtime option for different APCI versions. ACPI 2.0/FADT Rev3  
>> is the minimum version required for exposing the reset register,  
>> and it is also backwards-compatible with 1.0/Rev1, so that seemed  
>> a good version to target.
>>
>>  2. Legacy guest testing. I've tested this successfully (no  
>> apparent regressions) with:
>>    * Windows XP x86 (both "pc" and "q35" machine types, the latter  
>> using -device piix4-ide)
>>    * Windows 7, both 32-bit and 64-bit editions
>>    * Windows 10 x64
>>    * Fedora 7 x86 Live image
>>    * Fedora 25 x86_64 Live image
>>    * Ubuntu 10.04.4 AMD64 Live image
>> Any other specific OSes and versions I should check?

Windows 2000
