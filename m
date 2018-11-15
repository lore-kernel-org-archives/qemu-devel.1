Received: from eggs.gnu.org ([2001:4830:134:3::10]:39521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gNHT4-0006ZI-3e
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gNHT0-0001eG-SX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:13:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gNHSy-0001RL-O2
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:13:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36F1F58E47
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 13:13:31 +0000 (UTC)
References: <20181115122930.25732-1-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5f386119-b879-0387-4122-49d72494be4a@redhat.com>
Date: Thu, 15 Nov 2018 14:13:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181115122930.25732-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1?] qtest: log QEMU command line
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

On 15/11/2018 13:29, Paolo Bonzini wrote:
> Record the command line that was used to start QEMU.  This can be
> useful for debugging.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/libqtest.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

It seems to be a good idea.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
