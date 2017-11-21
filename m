Received: from eggs.gnu.org ([2001:4830:134:3::10]:50374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHC2z-00040A-85
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHC2y-00085R-Gq
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:09:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eHC2y-00084v-Bg
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:09:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EBFDC054C44
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 17:09:19 +0000 (UTC)
Date: Tue, 21 Nov 2017 19:09:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171121190647-mutt-send-email-mst@kernel.org>
References: <1510834622-28800-1-git-send-email-thuth@redhat.com>
	<20171120175522.76bf71c3@redhat.com>
	<20171120223048-mutt-send-email-mst@kernel.org>
	<20171121142639.3e6d2e79@redhat.com>
	<20171121164254-mutt-send-email-mst@kernel.org>
	<20171121165809.1ec4362a@redhat.com>
	<20171121180202-mutt-send-email-mst@kernel.org>
	<20171121172236.618c8e08@redhat.com>
	<20171121182432-mutt-send-email-mst@kernel.org>
	<20171121175812.6f922e2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121175812.6f922e2e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] tests/bios-tables-test: Fix endianess
 problems when passing data to iasl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Tue, Nov 21, 2017 at 05:58:12PM +0100, Igor Mammedov wrote:
> anyways, if you prefer having mixed endianness here, I won't mind much,
> as impact of test case is much smaller so we'll see down the road
> if it became any better.

I agree here.

> (as far as we continue going in direction
> of using host byteorder within main qemu acpi code, which we were
> doing by gradually converting acpi structures to build_append_foo API)

So APIs are absolutely a good alternative. If we get rid of
packed structures in main qemu code, we could convert tests
to whatever makes sense for tests.

-- 
MST
