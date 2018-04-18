Received: from eggs.gnu.org ([2001:4830:134:3::10]:54217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1f8g05-0005FS-9N
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1f8g02-0000gK-73
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:51:25 -0400
References: <CAOuPqTF3nG157ShF-hW+poXbr25zODOz8pj+o9XdY=ZgU8qpFQ@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <81f19d71-d226-29f8-42f8-47f28160289e@tuxfamily.org>
Date: Wed, 18 Apr 2018 07:51:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPqTF3nG157ShF-hW+poXbr25zODOz8pj+o9XdY=ZgU8qpFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] getdents patch for 64-bit app on 32-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Henry Wertz <hwertz10@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 17.04.2018 23:53, Henry Wertz wrote:
> Please find submitted a patch for getdents (this system call stands for
> "get directory entries", it is passed a file descriptor pointing to a
> directory and returns a struct with info on the entries in that
> directory.)  This patch is against qemu-2.10 series but continues to apply
> cleanly on current as of April 15 2018.

 Hi,

thanks for the patch, but when you send patches, please make sure:

1) To send "unified" patches, i.e. "diff -u", or even better, use "git
format-patch" to create it and "git send-email" to send it to the list.

2) Patches should be inline, not in an attachment

3) Patch description should be ready for the changelog, i.e. don't write
something like "Please find submitted..." in the patch description. You
can write additional text below the "---" separator if necessary.
Patches will be applied with "git am", and text below the "---"
separator will then be discarded.

4) Make sure that you put the right maintainers on CC:, or otherwise
your patch might be lost in the high traffic of the qemu-devel mailing
list. Use the MAINTAINERS or the scripts/get_maintainers.pl script to
find out the right maintainers.

Please also see https://wiki.qemu.org/Contribute/SubmitAPatch for some
more details.

 Thomas
