Received: from eggs.gnu.org ([2001:4830:134:3::10]:46559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ded6J-0001wm-5w
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ded6E-0003qv-J3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ded6E-0003qf-DA
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:09:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0783C356E8
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 08:09:17 +0000 (UTC)
Date: Mon, 7 Aug 2017 16:09:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170807080913.GI14780@lemon>
References: <20170804012551.2714-1-eblake@redhat.com>
	<150181165680.60.17068931498958654477@93e45bedd699>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150181165680.60.17068931498958654477@93e45bedd699>
Subject: Re: [Qemu-devel] [PATCH v4 00/22] Clean up around qmp() and hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com

On Thu, 08/03 18:54, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.

As said in the sub-thread of this message, this is a false positive because
patchew didn't know the dependency. With that fixed, this test and the other
falsely failed one both pass. Thanks.

Fam
