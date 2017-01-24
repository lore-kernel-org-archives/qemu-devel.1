Received: from eggs.gnu.org ([2001:4830:134:3::10]:59496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4Lp-0003yS-TP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4Lp-00075s-5d
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:53:45 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:33659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW4Lp-00075f-2M
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:53:45 -0500
Received: by mail-ua0-x234.google.com with SMTP id i68so138195736uad.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 08:53:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87vat4a081.fsf@linaro.org>
References: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
	<1484937883-1068-3-git-send-email-peter.maydell@linaro.org>
	<87vat4a081.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 16:53:23 +0000
Message-ID: <CAFEAcA_dtWKoNh0Ms5gsQNLmRc3Yu8pPgabWBnapOpC9Oh-+1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/6] armv7m: Replace armv7m.hack
 with unassigned_access handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 24 January 2017 at 16:31, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>> -    /* Hack to map an additional page of ram at the top of the address
>> -       space.  This stops qemu complaining about executing code outside=
 RAM
>> -       when returning from an exception.  */
>> -    memory_region_init_ram(hack, NULL, "armv7m.hack", 0x1000, &error_fa=
tal);
>> -    vmstate_register_ram_global(hack);
>> -    memory_region_add_subregion(system_memory, 0xfffff000, hack);
>> -
>
> What stops a model inadvertently registering a block of memory on-top?
> Should we check the memory region really is unassigned?

It would just be a board code bug, and a pretty implausible one
I think (at least no less plausible than any other typoing of
a device or memory address, 99% of which are uncheckable).

thanks
-- PMM
