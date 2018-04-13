Received: from eggs.gnu.org ([2001:4830:134:3::10]:41684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6xGp-00058l-UM
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6xGp-0002oZ-0J
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:53:35 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:33399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6xGo-0002oA-RC
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:53:34 -0400
Received: by mail-ot0-x235.google.com with SMTP id 23-v6so9545332otj.0
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 04:53:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d0z3pd6x.fsf@secure.laptop>
References: <152360619100.1854.4118391342119729453@71c20359a636>
	<87d0z3pd6x.fsf@secure.laptop>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 12:53:13 +0100
Message-ID: <CAFEAcA-ifRco0bKCbbSDGQkz33_jdP03mOB3+WJ3_zObcAisrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: no-reply@patchew.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhenyuw@linux.intel.com, Yulei Zhang <yulei.zhang@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, zhi.a.wang@intel.com, David Gibson <david@gibson.dropbear.id.au>

On 13 April 2018 at 12:18, Juan Quintela <quintela@redhat.com> wrote:
> no-reply@patchew.org wrote:
>> === OUTPUT BEGIN ===
>> Checking PATCH 1/1: migration: discard non-migratable RAMBlocks...
>> ERROR: Macros with multiple statements should be enclosed in a do - while loop
>> #96: FILE: migration/ram.c:191:
>> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
>> +    RAMBLOCK_FOREACH(block)                            \
>> +        if (!qemu_ram_is_migratable(block)) {} else
>>
>> ERROR: trailing statements should be on next line
>> #98: FILE: migration/ram.c:193:
>> +        if (!qemu_ram_is_migratable(block)) {} else
>>
>> total: 2 errors, 0 warnings, 167 lines checked
>
> To be fair, I don't know how to fix this outside of:
>
> BEGIN_RAMBLOCK_FOREACH(...)
>
> END_RAMBLOCK_FOREACH()
>
> type of construct.  I was wondering about what could happen if the
> RAMBLOCK_FOREACH was insied an if, but checkpatch beated me to it.

RAMBLOCK_FOREACH inside if() should work fine here. I don't
think we can expect checkpatch to be able to cope with all
of the complicated macro magic we do, so if we're satisfied
that the macro is doing what we want then we should just
ignore the checkpatch error.

thanks
-- PMM
