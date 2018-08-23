Received: from eggs.gnu.org ([2001:4830:134:3::10]:39117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsiZB-0007Se-9T
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 01:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsiZ8-00015V-3e
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 01:53:57 -0400
References: <20180822144039.5796-1-pavel.zbitskiy@gmail.com>
	<20180822144039.5796-2-pavel.zbitskiy@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <63deac49-ef52-dfe0-673f-df2ca9ae89c9@redhat.com>
Date: Thu, 23 Aug 2018 07:53:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180822144039.5796-2-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 1/3] target/s390x: use
 regular spaces in translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, cohuck@redhat.com, richard.henderson@linaro.org, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2018-08-22 16:40, Pavel Zbitskiy wrote:
> In a few places translate.c contains non-breaking spaces (0xc2 0xa0)
> instead of regular ones (0x20):
> 
>   7c 7c c2 a0 63 63
>   7c 7c 20    63 63
>   |  |        c  c
> 
> This confuses some text editors.

Without your patch:

$ file target/s390x/translate.c
target/s390x/translate.c: C source, UTF-8 Unicode text

With your patch:

$ file target/s390x/translate.c
target/s390x/translate.c: C source, ASCII text

Looks like you've got all spots :-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
