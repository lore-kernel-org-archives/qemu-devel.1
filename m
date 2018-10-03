Received: from eggs.gnu.org ([2001:4830:134:3::10]:51853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7dSS-00058f-HK
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7dSM-0003Y6-Sq
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:28:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7dSI-0003Tg-ES
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:28:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id o21so4567772otb.13
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 02:28:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7f9534ac-0c7f-51da-1b0a-b8b43fe38178@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-10-f4bug@amsat.org>
	<CAFEAcA_DBU6-_EqZP2-bh+JkWeP3s9kcrtJSHLmeziPYcU0nnQ@mail.gmail.com>
	<7f9534ac-0c7f-51da-1b0a-b8b43fe38178@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Oct 2018 10:28:01 +0100
Message-ID: <CAFEAcA98_Kvyfa12QaLwE+3HpBYeZQhyNukedJnEz3gGe2OPRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/15] hw/mips/malta: Replace 'empty_slot'
 by 'unimplemented_device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>

On 2 October 2018 at 20:40, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 10/2/18 3:23 PM, Peter Maydell wrote:
>> Not sure about this one. unimplemented_device means "there should
>> be something here, but QEMU's model is incomplete", and if the user
>> asks for 'unimp' warnings via the -d option then all accesses will
>> generate logging. In this MIPS board, we're modelling the hardware's
>> actual behaviour, and we shouldn't generate debug messages that
>> imply that QEMU has unimplemented functionality here.
>>
>> If we were writing a model of the Malta board from scratch we'd
>> probably do it by having the GT-64120A be modelled as a device
>> which was a container object that instantiated all its various
>> bits and pieces and mapped them into a MemoryRegion that spanned
>> the whole 1GB size of that part of the address space. We could
>> then give that MR a background region with the "RAZ/WI" behaviour
>> the hardware requires.
>
> Is 'git revert c7c3c9f8' a good example of your explanation?

That commit is OK, because the previous version was also
logging accesses as being unimplemented.

thanks
-- PMM
