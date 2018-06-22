Received: from eggs.gnu.org ([2001:4830:134:3::10]:40488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDeY-0000fw-Im
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDeT-0004oE-Jy
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:26:30 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:35212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDeT-0004nZ-En
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:26:25 -0400
Received: by mail-qt0-x233.google.com with SMTP id z6-v6so4944345qti.2
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 21:26:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <263756cc-6869-de24-3f9b-140d24025829@amsat.org>
Date: Fri, 22 Jun 2018 01:26:20 -0300
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/35] nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, James.Hogan@mips.com
Cc: qemu-devel@nongnu.org, Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, aurelien@aurel32.net, Paul Burton <paul.burton@mips.com>

Hi Yongbok,

On 06/20/2018 09:05 AM, Yongbok Kim wrote:
> This series of patches is implementing recently announced nanoMIPS on QEMU.
> nanoMIPS is a variable length ISA containing 16, 32 and 48 bit wide 
> instructions. It is designed to be portable at assembly level with other MIPS
> and microMIPS code, but contains a number of changes which enhance code density
> and efficiency.
[...]

I noticed various patches use the imgtec.com domain.

In commit 94d973bdaac Paul Burton wrote:

    MIPS will soon no longer be a part of Imagination Technologies
    & as such the @imgtec.com address will soon cease to function.

Your's got updated in 0eb4e1f33a4, and James in a7a2d7d2a04.

Assuming this is rebase using previous internal patches, shouldn't you
update those addresses to your new domain? Else the checkpatch.pl script
will continue to extract imgtec.com addresses from commits.

Regards,

Phil.
