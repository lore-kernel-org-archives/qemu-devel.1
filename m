Received: from eggs.gnu.org ([2001:4830:134:3::10]:54111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmyWE-0001Mt-MG
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmyWA-000077-Io
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:43:10 -0400
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
	<20180805182832.3012-6-pavel.zbitskiy@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8de24c1a-a51a-35a4-19a8-cec480848bea@redhat.com>
Date: Tue, 7 Aug 2018 11:42:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180805182832.3012-6-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 5/6] target/s390x: fix PACK
 reading 1 byte less and writing 1 byte more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, "open list:S390" <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 08/05/2018 08:28 PM, Pavel Zbitskiy wrote:
> PACK fails on the test from the Principles of Operation: F1F2F3F4
> becomes 0000234C instead of 0001234C due to an off-by-one error.
> Furthermore, it overwrites one extra byte to the left of F1.

 Hi Pavel,

thanks for fixing these bugs in the s390x instructions! If you've got
some more spare minutes, could you maybe also add regression tests for
these (user space) instruction to the tests/tcg/s390x folder? ... we
really need some tests there ...

 Thomas
