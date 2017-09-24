Received: from eggs.gnu.org ([2001:4830:134:3::10]:35063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwDqP-000251-N5
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 16:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwDqM-0003Ts-MS
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 16:49:41 -0400
References: <20170922225533.1928-1-lyan@suse.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <0dfef71c-cb6a-d959-0d4e-ea5a534048fa@msgid.tls.msk.ru>
Date: Sun, 24 Sep 2017 23:49:27 +0300
MIME-Version: 1.0
In-Reply-To: <20170922225533.1928-1-lyan@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] chardev/baum: fix baum that releases
 brlapi twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Yan <lyan@suse.com>, samuel.thibault@ens-lyon.org, pbonzini@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

23.09.2017 01:55, Liang Yan wrote:
> Error process of baum_chr_open needs to set brlapi null, so it won't
> get released twice in char_braille_finalize, which will cause
> "/usr/bin/qemu-system-x86_64: double free or corruption (!prev)"

Applied to -trivial, thanks!

/mjt
