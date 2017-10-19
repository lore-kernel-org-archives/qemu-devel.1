Received: from eggs.gnu.org ([2001:4830:134:3::10]:51407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e5GGS-0006P7-PS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e5GGP-00059K-JZ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:13:56 -0400
Received: from chuckie.co.uk ([82.165.15.123]:47294
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e5GGP-00058m-DN
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:13:53 -0400
References: <20171019071036.GB20805@kentang.lan>
	<CAFEAcA_KWLxNKSr3cDDoQE2JPaKm8L4MCKRDJYri4THpqjbBdw@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <29d59a68-437c-8157-0dcf-d9f16c8fda8f@ilande.co.uk>
Date: Thu, 19 Oct 2017 20:13:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_KWLxNKSr3cDDoQE2JPaKm8L4MCKRDJYri4THpqjbBdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL] Update OpenBIOS images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19/10/17 19:18, Peter Maydell wrote:

> On 19 October 2017 at 08:10, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> Hi Peter,
>>
>> Here are the latest set of updates for OpenBIOS which should be pulled after the sun4u
>> patches have been applied due to breaking changes in the sun4u machine.
>>
>>
>> ATB,
>>
>> Mark.
>>
>>
>> The following changes since commit 861cd431c99e56ddb5953ca1da164a9c32b477ca:
>>
>>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171017' into staging (2017-10-17 15:26:51 +0100)
>>
>> are available in the git repository at:
>>
>>
>>   https://github.com/mcayland/qemu.git tags/qemu-openbios-signed
>>
>> for you to fetch changes up to 08e2c1854d8bc32b3b6fcefbead0ea808c44cbc8:
>>
>>   Update OpenBIOS images to 83818bd built from submodule. (2017-10-19 08:04:15 +0100)
>>
>> ----------------------------------------------------------------
>> Update OpenBIOS images
>>
>> ----------------------------------------------------------------
>> Mark Cave-Ayland (1):
>>       Update OpenBIOS images to 83818bd built from submodule.
>>
>>  pc-bios/openbios-ppc     |  Bin 754936 -> 754936 bytes
>>  pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
>>  pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
>>  roms/openbios            |    2 +-
> 
> This fails to merge, because your other pullreq also
> updated pc-bios/openbios-sparc64 and git can't automatically
> resolve merge conflicts between binary files.
> 
> If you tell me which version of the binary to prefer I can
> fix it up by hand in the merge commit I guess.

Ah yes indeed, I didn't realise until I tried just now that it wouldn't
work.

I've gone for the assumption that the patches would be applied on a
first come, first served basis so the binaries for the OpenBIOS commit
should completely replace the openbios-sparc64 from the sun4u commit.

If you check the signed tag again, I've rebased the commit and re-pushed
to github again so you should now hopefully be able to apply without any
issues.


ATB,

Mark.
