Received: from eggs.gnu.org ([2001:4830:134:3::10]:35225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eK1kA-00030T-F4
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eK1k7-0005P5-Ei
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:45:38 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171129102513.9153-3-pbonzini@redhat.com>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-3-pbonzini@redhat.com>
Date: Wed, 29 Nov 2017 13:45:32 +0100
Message-ID: <w51fu8xmexf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/4] blockjob: remove clock
 argument from block_job_sleep_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org

On Wed 29 Nov 2017 11:25:11 AM CET, Paolo Bonzini wrote:
> All callers are using QEMU_CLOCK_REALTIME, and it will not be possible to
> support more than one clock when block_job_sleep_ns switches to a single
> timer stored in the BlockJob struct.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
