Received: from eggs.gnu.org ([2001:4830:134:3::10]:43283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2DOs-0007Xl-Vt
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 05:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2DOp-0001LL-An
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 05:01:47 -0400
References: <20170320173828.3874-1-sauravsachidanand@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <45ac325f-0496-b63a-b8a3-af1a2f8bdb8e@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 12:01:39 +0300
MIME-Version: 1.0
In-Reply-To: <20170320173828.3874-1-sauravsachidanand@gmail.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] util: Use g_malloc/g_free in envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Saurav Sachidanand <sauravsachidanand@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, stefanha@gmail.com, laurent@vivier.eu

20.03.2017 20:38, Saurav Sachidanand wrote:
> Change malloc/strdup/free to g_malloc/g_strdup/g_free in
> util/envlist.c.
> 
> Remove NULL checks for pointers returned from g_malloc and g_strdup
> as they exit in case of failure. Also, update calls to envlist_create
> to reflect this.
> 
> Free array and array contents returned by envlist_to_environ using
> g_free in bsd-user/main.c and linux-user/main.c.

Applied to -trivial, as-is, with the tabs instead of spaces.

Thanks,

/mjt
