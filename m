Received: from eggs.gnu.org ([2001:4830:134:3::10]:37700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1es9IK-0001pf-EG
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 10:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1es9IF-0004Cc-I8
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 10:41:56 -0500
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
	<CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
	<CAE5jQCe8O3BT=6SDdm2p7J_wxgzZTcqhyS1mfnEr=4tci9fipg@mail.gmail.com>
	<efe4a642-a220-5a40-b1e0-769a4216389d@twiddle.net>
	<CAE5jQCcCA=3kkVa=5eMZs-BGAM_p4fZG+GPu1SmQMg7_sPAH5Q@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <57abe9de-1258-3624-2f8a-882f1de1d19d@weilnetz.de>
Date: Sat, 3 Mar 2018 16:41:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAE5jQCcCA=3kkVa=5eMZs-BGAM_p4fZG+GPu1SmQMg7_sPAH5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] tci: eliminate UB due to unaligned
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Am 03.03.2018 um 15:07 schrieb Anatoly Trosinenko:
> Can rewriting TCI in such a way that every operation is aligned at 4- o=
r
> even 8-byte boundary fix the situation or are there some more serious
> problems?

That's my preferred solution. Are there cases which would require 8-byte
alignment?

Richard, the discussion about non-portable calls to helper functions is
not new, but I still have no test case which fails. Do you think of a
special case (architecture, helper function)?

Stefan
