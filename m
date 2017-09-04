Received: from eggs.gnu.org ([2001:4830:134:3::10]:58238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1douQG-0007Be-JU
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1douQB-0004qK-Tw
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:40:28 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1douQB-0004po-NS
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:40:23 -0400
Received: by mail-wr0-x230.google.com with SMTP id a43so3057478wrc.0
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 09:40:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ef498496-0009-0483-841c-7d6a793365bf@vivier.eu>
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
	<1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
	<941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
	<c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
	<CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
	<a91359d6-457c-7164-18f9-050193f2d419@vivier.eu>
	<CAFEAcA8VYnJgru6bV7_tNkPoJSKm3pwTH=8oJRdpTEW9PXycug@mail.gmail.com>
	<b79a96fa-74ac-cab3-8f87-a94be96e7ae5@gmx.com>
	<ef498496-0009-0483-841c-7d6a793365bf@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 17:40:02 +0100
Message-ID: <CAFEAcA_gAq4Gi7DZiPunTt1xwB8UpGSdw9uZqTTu602f99WEcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4 September 2017 at 17:38, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 04/09/2017 =C3=A0 18:38, Kamil Rytarowski a =C3=A9crit :
>> I will push my patch as is and later it can be refactored by a
>> maintainer. Is this fine?
>>
>> https://github.com/NetBSD/pkgsrc-wip/blob/master/qemu-git/patches/patch-=
target_m68k_fpu__helper.c
>>
>
> If Peter agrees, the patch is good for me as is: I never liked the mix
> of macros and values in this array. Send it to the list, I will put it
> in my next pull request.

OK, if you're happy with it I'm happy with it.

thanks
-- PMM
