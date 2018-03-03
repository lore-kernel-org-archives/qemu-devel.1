Received: from eggs.gnu.org ([2001:4830:134:3::10]:53709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1es7v3-0006wp-Dv
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1es7v2-0004qM-G0
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:13:49 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
	<CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
	<CAE5jQCe8O3BT=6SDdm2p7J_wxgzZTcqhyS1mfnEr=4tci9fipg@mail.gmail.com>
	<efe4a642-a220-5a40-b1e0-769a4216389d@twiddle.net>
	<CAE5jQCcCA=3kkVa=5eMZs-BGAM_p4fZG+GPu1SmQMg7_sPAH5Q@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a9fb7f08-9eeb-4120-620e-1f05715ee329@twiddle.net>
Date: Sat, 3 Mar 2018 06:13:37 -0800
MIME-Version: 1.0
In-Reply-To: <CAE5jQCcCA=3kkVa=5eMZs-BGAM_p4fZG+GPu1SmQMg7_sPAH5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org

On 03/03/2018 06:07 AM, Anatoly Trosinenko wrote:
> Can rewriting TCI in such a way that every operation is aligned at 4- or even
> 8-byte boundary fix the situation or are there some more serious problems?

With the current TCI, there are also problems with calls to helper functions.
The only portable way to do this is to use a library such as libffi.

I once rewrote TCI completely in order to address both problems, but that only
brought questions as to why TCI is useful at all.

So.  Why do you want to use TCI instead of a native TCG backend?


r~
