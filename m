Received: from eggs.gnu.org ([2001:4830:134:3::10]:56966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUVdT-0000Xw-EM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUVdQ-0003S3-9n
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:09:47 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUVdQ-0003R6-1l
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:09:44 -0400
Received: by mail-wr0-f171.google.com with SMTP id k67so131353581wrc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 03:09:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0a225c8e-1dc6-0709-f431-0b918e5d47d2@redhat.com>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
	<1499438577-7674-3-git-send-email-peter.maydell@linaro.org>
	<a092f4f6-a915-b4fc-a5ce-1241856c2e13@redhat.com>
	<CAFEAcA_UBEY7pwtnTpCaX27e4sRHj_jioUq=7f1_UhDidNAkGw@mail.gmail.com>
	<0a225c8e-1dc6-0709-f431-0b918e5d47d2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 11:08:22 +0100
Message-ID: <CAFEAcA8B9DTyWOSvSJ=-qOUuLRxjq8e0qC1H8DdaSDACZqX7oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/11] memory: Document that the RAM MR
 initializers do not handle migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 10 July 2017 at 11:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 10/07/2017 12:04, Peter Maydell wrote:
>> On 10 July 2017 at 11:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>>
>>> On 07/07/2017 16:42, Peter Maydell wrote:
>>>> @@ -522,6 +537,9 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
>>>>   * @name: the name of the region.
>>>>   * @size: size of the region.
>>>>   * @ptr: memory to be mapped; must contain at least @size bytes.
>>>> + *
>>>> + * Note that this function does not do anything to cause the data in the
>>>> + * RAM memory region to be migrated; that is the responsibility of the caller.
>>>
>>> Perhaps add a note that it rarely makes sense for this function?
>>
>> Well, we have 4 callers of this function, and 3 of those
>> register the RAM for migration, so the rare case seems to be
>> the "don't need to handle migration"...
>
> Oops, the diff header is confusing and I didn't notice that when
> trimming.  My comment refers to RAM device regions.

Yeah, no objection to adding a note for that one.

thanks
-- PMM
