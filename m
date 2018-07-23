Received: from eggs.gnu.org ([2001:4830:134:3::10]:36101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fhesN-000352-5Q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fhesJ-0007MQ-7o
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:44:03 -0400
Received: from mail-by2nam05on0721.outbound.protection.outlook.com
	([2a01:111:f400:fe52::721]:61248
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fhesI-0007MA-S3
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:43:59 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 23 Jul 2018 17:43:37 +0000
Message-ID: <BN7PR08MB4868DA02358F9A0CA3AA14F1C6560@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-33-git-send-email-stefan.markovic@rt-rk.com>,
	<8d1a14bf-8cc5-91cb-5aed-cefeb8d97962@linaro.org>,
	<BN7PR08MB4868FFAE6CA4BF4074D7F87AC6560@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868FFAE6CA4BF4074D7F87AC6560@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 32/40] elf: Add nanoMIPS specific
 variations in ELF header fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic
> Sent: Monday, July 23, 2018 7:39 PM
>
> > From: Richard Henderson <richard.henderson@linaro.org>
> > Sent: Monday, July 23, 2018 6:59 PM
> > On 07/19/2018 05:55 AM, Stefan Markovic wrote:
> > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > >
> > > Add nanoMIPS-related values in ELF header fields as specified in
> > > nanoMIPS' "ELF ABI Supplement".
> > >
> > > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > > ---
> > >  include/elf.h | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> >
> > None of these values have made it upstream to binutils yet,
> > so I can't double-check them.  However,
> >
> > Acked-by: Richard Henderson <richard.henderson@linaro.org>
> >
> >
> > r~
>
> Hi, Richard.
>
> True, binutils headers were not updated with these ELF-related values. Ho=
wever, there is a publicly-available > document at https://codescape.mips.c=
om/components/toolchain/nanomips/2018.04-02/releasenotes.html that should b=
e > the source of information for binutils headers, or any other related he=
ader in similar tools. Specifically, see > Section 5.1 of that document.
>
> Regards,
> Aleksandar

I meant to link here to "nanoMIPS ABI Supplement":

https://codescape.mips.com/components/toolchain/nanomips/2018.04-02/docs/MI=
PS_nanoMIPS_ABI_supplement_01_02_DN00179.pdf
