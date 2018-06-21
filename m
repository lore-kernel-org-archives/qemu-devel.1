Received: from eggs.gnu.org ([2001:4830:134:3::10]:57236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW5qP-0006n1-Le
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 16:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW5qL-0004rr-MK
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 16:06:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fW5qL-0004rj-GN
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 16:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B02FC4007389
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 20:06:08 +0000 (UTC)
References: <20180620132546.27128-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b3034f45-18f4-eb6d-3553-82d777f30777@redhat.com>
Date: Thu, 21 Jun 2018 16:06:06 -0400
MIME-Version: 1.0
In-Reply-To: <20180620132546.27128-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ahci: fix FIS I bit and PIO Setup FIS
 interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com



On 06/20/2018 09:25 AM, Paolo Bonzini wrote:
> +    pio_fis_i = is_atapi ? ad->done_atapi_packet : !is_write;

Per DPIOO1, does this go to false for the first DRQ block, or did I
misunderstand? Currently my understanding:

- device->host
	DPIOI1
	Interrupt bit shall be set.
- host->device:
	DPIOO1:
	0 for first block, 1 otherwise
- ATAPI:
	0 for packet itself
	1 for all data otherwise.

Yes?
