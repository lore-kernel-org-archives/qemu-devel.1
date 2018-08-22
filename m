Received: from eggs.gnu.org ([2001:4830:134:3::10]:59183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsUMD-0008B2-5S
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsUMA-0002dA-0P
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:43:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fsUM9-0002cf-Qd
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 700D087A6D
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 14:43:33 +0000 (UTC)
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-7-quintela@redhat.com>
	<fdf970ce-baa2-7b87-7e72-bba34d9c1328@redhat.com>
	<8736v6pix0.fsf@trasno.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f518638b-d435-aa2f-da44-1b013e333774@redhat.com>
Date: Wed, 22 Aug 2018 16:43:27 +0200
MIME-Version: 1.0
In-Reply-To: <8736v6pix0.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/10] check: Only test ivshm when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 2018-08-22 16:36, Juan Quintela wrote:
[...]
> I got even more confused.  check-qtest-pci-y is only tested on x86*, go
> figure.

Yes, that's ugly, indeed. We should maybe rework that so that all board
which include pci.mak can use it...

 Thomas
