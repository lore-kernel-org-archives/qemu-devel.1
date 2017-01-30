Received: from eggs.gnu.org ([2001:4830:134:3::10]:37650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cYCAZ-0002r7-Tn
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cYCAV-0006AF-SP
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:38:55 -0500
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:52020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cYCAV-00069j-Lh
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:38:51 -0500
Received: from player774.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 35CCD9426B
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 14:38:48 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-11-git-send-email-clg@kaod.org>
	<CAFEAcA-6vi3UbSa5naSqbk-JG+UysiwM6TyvqE29VUbswD7MFA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3a9e6ba8-5b0c-48de-e0c5-7e2f701bbcba@kaod.org>
Date: Mon, 30 Jan 2017 14:38:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-6vi3UbSa5naSqbk-JG+UysiwM6TyvqE29VUbswD7MFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/11] aspeed: use first FMC flash as a
 boot ROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcin Krzeminski <marcin.krzeminski@nokia.com>

>> +#define FIRMWARE_ADDR 0x0
>> +
>> +static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
>> +                           Error **errp)
>> +{
>> +    BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
>> +    uint8_t *storage;
>> +
>> +    if (rom_size > blk_getlength(blk)) {
>> +        rom_size = blk_getlength(blk);
>> +    }
>> +
>> +    storage = g_new0(uint8_t, rom_size);
> 
> Hi -- coverity points out that you're not checking for the
> case where blk_getlength() returns negative. (This can happen
> for the case where the BlockBackend represents an insertable
> device like a floppy or cdrom with no medium present.)
> 
> Since for aspeed this dinfo always represents a flash device,
> we know this shouldn't happen, so you can just make it a fatal
> error if blk_getlength() doesn't return what you're expecting.

OK. I will send a fix to improve this routine. 

Thanks,

C.
