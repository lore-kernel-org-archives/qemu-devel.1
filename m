Received: from eggs.gnu.org ([209.51.188.92]:40761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gk59K-0007WU-N5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gk53L-0005S1-So
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:37:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gk53L-0005Dt-Jn
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:37:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DCAF80F81
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:37:22 +0000 (UTC)
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-5-git-send-email-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <2710a024-1549-6fad-22bd-bffb58a71289@redhat.com>
Date: Thu, 17 Jan 2019 11:37:19 +0100
MIME-Version: 1.0
In-Reply-To: <1547576349-13337-5-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/libqos: embed allocators instead
 of malloc-ing them separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 15/01/2019 19:19, Paolo Bonzini wrote:
> qgraph will embed these objects instead of allocating them in a separate
> object.  Expose a new API "generic_alloc_init" and "generic_alloc_destroy"
> for that, and rename the existing API with s/init/new/ and s/uninit/free/.

I'm not the "s/init/new/ and s/uninit/free/" are actually done in this
patch.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
