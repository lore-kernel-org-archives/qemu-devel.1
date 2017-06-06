Received: from eggs.gnu.org ([2001:4830:134:3::10]:58517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIGe0-0000xN-5S
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIGdw-0007EZ-72
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:43:44 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:42547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dIGdv-0006sk-R9
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:43:40 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170605123908.18777-19-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-19-pbonzini@redhat.com>
Date: Tue, 06 Jun 2017 17:43:00 +0200
Message-ID: <w51mv9l3ywr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 18/19] block: split BlockAcctStats creation
 and setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On Mon 05 Jun 2017 02:39:07 PM CEST, Paolo Bonzini wrote:
> block_acct_destroy is called unconditionally in blk_delete, but there is
> no BlockAcctStats function that is called unconditionally in blk_new.
> Split block_acct_init in two, so that it will be possible to create a
> QemuMutex in block_acct_init and destroy it in block_acct_cleanup.
>
> Cc: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
