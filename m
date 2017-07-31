Received: from eggs.gnu.org ([2001:4830:134:3::10]:48888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7kD-00015V-RD
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7kA-0002c4-ML
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:16:13 -0400
References: <20170728115318.31781-1-otubo@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <ffffff7a-5353-305f-134c-521d93c6955f@msgid.tls.msk.ru>
Date: Mon, 31 Jul 2017 13:16:09 +0300
MIME-Version: 1.0
In-Reply-To: <20170728115318.31781-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix qemu-system-unicore32 crashing when
 calling without -kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org
Cc: thuth@redhat.com, gxt@mprc.pku.edu.cn, qemu-devel@nongnu.org

28.07.2017 14:53, Eduardo Otubo wrote:
> Starting qemu-system-unicore32 without the -kernel parameter results in
> an assert() returns false and aborts qemu. This patch replaces it with a
> proper error message followed by exit(1).

Applied to -trivial, thanks!

/mjt
