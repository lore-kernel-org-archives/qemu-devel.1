Received: from eggs.gnu.org ([2001:4830:134:3::10]:39718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcW8t-00059Z-9u
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcW8s-00065a-Hr
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:23:51 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcW8s-00065I-5N
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:23:50 -0400
Received: by mail-oi0-x243.google.com with SMTP id v8-v6so35836593oie.5
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 06:23:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868570BBE04A506513CD9E7C6440@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180706174309.27110-1-peter.maydell@linaro.org>
	<BN7PR08MB4868570BBE04A506513CD9E7C6440@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 14:23:28 +0100
Message-ID: <CAFEAcA-Ca2OyNPtKjZc7cKPZ43eeB+Rh=3y-ZqtbXHeaTbCO0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0] hw/net/dp8393x: don't make prom
 region 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Jason Wang <jasowang@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 9 July 2018 at 12:27, Aleksandar Markovic <amarkovic@wavecomp.com> wrote:
>> Currently we use memory_region_init_rom_nomigrate() to create
>> the "dp3893x-prom" memory region, and we don't manually register
>> it with vmstate_register_ram(). This currently means that its
>> contents are migrated but as a ram block whose name is the empty
>> string; in future it may mean they are not migrated at all. Use
>> memory_region_init_ram() instead.
>>
>> Note that this is a a cross-version migration compatibility break
>> for the MIPS "magnum" and "pica61" machines.
>>
>
> As far as MIPS jazz ("magnum" and "pica61") boards are concerned:
>
> Reviewed-by: Aleksandar Markovic <aleksandar.markovic@wavecomp.com>

Thanks for the review. I'll put this in via target-arm.next,
just for convenience's sake, since I'm doing a pull request
this afternoon anyway.

-- PMM
