Received: from eggs.gnu.org ([2001:4830:134:3::10]:37579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ejlWe-00051x-0E
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ejlWa-0002bc-UM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:42:04 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180207162920.28386-1-pbonzini@redhat.com>
References: <20180207162920.28386-1-pbonzini@redhat.com>
Date: Thu, 08 Feb 2018 13:41:58 +0100
Message-ID: <w51zi4jpsa1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: early check for
 blockers on drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On Wed 07 Feb 2018 05:29:20 PM CET, Paolo Bonzini wrote:
> Even if an op blocker is present for BLOCK_OP_TYPE_MIRROR_SOURCE,
> it is checked a bit late and the result is that the target is
> created even if drive-mirror subsequently fails.  Add an early
> check to avoid this.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
