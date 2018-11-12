Received: from eggs.gnu.org ([2001:4830:134:3::10]:59416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gM9su-0003E4-AM
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gM9sm-0000r0-2S
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:55:59 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gM9sj-0000iB-IE
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:55:51 -0500
Received: by mail-wm1-x341.google.com with SMTP id r11-v6so7984073wmb.2
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 02:55:45 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-9-f4bug@amsat.org>
	<BN6PR2201MB1251ADAEA3C596FD3F1AB3E6C6C10@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<ad3bd757-861d-2086-94e5-64779cd0affb@linaro.org>
	<CY4PR2201MB12548AC0153261DF7E3BABECC6C10@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <725979ee-296e-61c1-c2c8-53370616f709@twiddle.net>
Date: Mon, 12 Nov 2018 11:55:39 +0100
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB12548AC0153261DF7E3BABECC6C10@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] target/mips: Add a decodetree
 stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 11/12/18 11:04 AM, Aleksandar Markovic wrote:
> Hello, Richard.
> 
> I am a little taken aback by your tone. I hope we can communicate in much friendlier maner, as we used to do.

I too was put off by your tone.  Beginning with "there is no plan" and
continuing with "there is no point" is a curt reply.  It is off-putting to
someone attempting to contribute, and I felt it was unwarranted.

> I am not preventing anyone from experimenting. I just want to warn Philippe about high-level view that the code in question, although not the nicest, works, and is planned to be maintained with minimal changes. The focus of MIPS target is on adding new architectures and ASEs, and (I correct myself) it could be that decodetree would kick in in such cases - but not for mature code driving older architectures. It just doesn't make enough sense.

I think this is a mistake.  The legacy code is quite tangled.  It *should* have
an overhaul.  If someone is willing to do that work, fantastic.


r~
