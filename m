Received: from eggs.gnu.org ([2001:4830:134:3::10]:42549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhkIr-0005k1-Bu
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 18:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhkIn-00043H-V2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 18:27:13 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhkIn-00041P-Mz
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 18:27:09 -0400
Received: by mail-wm0-f50.google.com with SMTP id i66so20035622wmg.0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 15:27:06 -0700 (PDT)
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
	<ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
	<5D42D1E3-A946-4E2C-BDC4-BB785D0B880D@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db1ad643-9dc6-6464-1487-44007b3609ee@redhat.com>
Date: Wed, 16 Aug 2017 00:27:02 +0200
MIME-Version: 1.0
In-Reply-To: <5D42D1E3-A946-4E2C-BDC4-BB785D0B880D@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 15/08/2017 20:46, Programmingkid wrote:
> 
>> On Aug 14, 2017, at 2:51 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 13/08/2017 21:13, Programmingkid wrote:
>>> Lately I found out that Windows NT 4.0 seems to work well with the
>>> 486 and pentium processors. Using "-cpu 486" made installing it
>>> actually work. Now I am seeing another issue. When I boot Windows NT
>>> 4.0 I see this error message:
>>>
>>> *** STOP: 0x0000007B (0x807A8610,0x00000000,0x00000000,0x00000000) 
>>> INACESSIBLE_BOOT_DEVICE
>>>
>>> Would anyone know a way to solve this issue?
>>
>> Hervé is probably the best person to answer this question.  Maybe try
>> installing it with SCSI disks ("-drive if=scsi,id=hd,file=... -drive
>> if=scsi,id=cd,file=... -device lsi -device scsi-hd,drive=hd -device
>> scsi-cd,drive=cd").
>>
>> Thanks,
>>
>> Paolo
> 
> Thanks for the help. Unfortunately trying to boot from the install CD leads to the INACCESSIBLE_BOOT_DEVICE error when using SCSI. 

Try with 0.12.

Paolo
