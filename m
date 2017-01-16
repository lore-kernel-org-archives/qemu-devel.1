Received: from eggs.gnu.org ([2001:4830:134:3::10]:44244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTG3U-000711-Ef
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTG3P-0005Oi-Jl
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:47:12 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:49498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1cTG3P-0005OL-C8
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:47:07 -0500
References: <20170116224431.19010-1-glaubitz@physik.fu-berlin.de>
	<20170116224431.19010-2-glaubitz@physik.fu-berlin.de>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <8659cb7e-34dc-2173-40d5-46d709c9b2c8@physik.fu-berlin.de>
Date: Mon, 16 Jan 2017 23:47:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170116224431.19010-2-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Update m68k syscall
 definitions to match Linux 4.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

On 01/16/2017 11:44 PM, John Paul Adrian Glaubitz wrote:
> +#define TARGET_NR_file_range            376
> +#define TARGET_NR_preadv2               377
> +#define TARGET_NR_pwritev2              378

Oops, there's a copy-and-paste error. This should be
TARGET_NR_copy_file_range. Will update in a second.

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
