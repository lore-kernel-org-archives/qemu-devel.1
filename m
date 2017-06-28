Received: from eggs.gnu.org ([2001:4830:134:3::10]:50481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dQHH9-0005Zx-9x
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dQHH5-0005eR-En
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1dQHH5-0005di-9M
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:01:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 252BA3DEE4
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:01:09 +0000 (UTC)
Date: Wed, 28 Jun 2017 23:31:01 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <afe9f097-e08f-4b11-3cf9-9af4c18915f0@redhat.com>
Message-ID: <alpine.LFD.2.20.1706282326030.25534@wniryva>
References: <20170611123714.31292-1-mreitz@redhat.com>
	<afe9f097-e08f-4b11-3cf9-9af4c18915f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Ignore SIGPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

+-- On Tue, 27 Jun 2017, Eric Blake wrote --+
| > $ qemu-nbd -x foo -f raw -t null-co:// &
| > [1] 12726
| > $ qemu-io -c quit nbd://localhost/bar
| > can't open device nbd://localhost/bar: No export with name 'bar' available
| > [1]  + 12726 broken pipe  qemu-nbd -x foo -f raw -t null-co://
| > 
| > In this case, the client sends an NBD_OPT_ABORT and closes the
| > connection (because it is not required to wait for a reply), but the
| > server replies with an NBD_REP_ACK (because it is required to reply).
| > 
| > Signed-off-by: Max Reitz <mreitz@redhat.com>
| > ---
| 
| As mentioned in another thread, I'm trying to figure out if this patch
| belongs as a third patch to fix CVE-2017-9524, or whether we want to
| open a second CVE by considering this a slightly different
| denial-of-service attack than what my patches fixed.

  Yes, this would be a separate issue, as it breaks 'qemu-nbd' server 
irrespective of whether 'CVE-2017-9524' fix is applied or not.

I'll get a CVE assigned and process it further.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
