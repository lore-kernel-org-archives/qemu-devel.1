Received: from eggs.gnu.org ([2001:4830:134:3::10]:40285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dBK2w-0002Sl-LJ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dBK2t-0007Yy-IL
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:56:46 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170511144208.24075-9-pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-9-pbonzini@redhat.com>
Date: Thu, 18 May 2017 13:56:39 +0200
Message-ID: <w51h90igyyw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 08/18] throttle-groups: do not
 use qemu_co_enter_next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On Thu 11 May 2017 04:41:58 PM CEST, Paolo Bonzini wrote:
> Prepare for removing this function; always restart throttled requests
> from coroutine context.  This will matter when restarting throttled
> requests will have to acquire a CoMutex.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
