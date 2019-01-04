Received: from eggs.gnu.org ([208.118.235.92]:45467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfLkw-0003L8-Ii
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfLks-0006vW-En
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:27:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gfLks-0006ui-9Z
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:27:02 -0500
Date: Fri, 4 Jan 2019 10:26:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190104102655.3bf599f5.cohuck@redhat.com>
In-Reply-To: <20190104082731.24967-2-pbonzini@redhat.com>
References: <20190104082731.24967-1-pbonzini@redhat.com>
	<20190104082731.24967-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] scripts/update-linux-headers.sh:
 adjust for Linux 4.21-rc1 (or 5.0-rc1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org

On Fri,  4 Jan 2019 09:27:30 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> There are three new indirect inclusions: vhost_types.h, which we'll
> shortly put to use as a portable header and thus is copied to
> standard-headers; and new per-subtarget versions of MIPS unistd.h
> and PowerPC unistd.h.
> 
> Because vhost.h includes vhost_types.h, we also need a proxy include
> from linux/vhost.h to standard-headers.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I still think we could squash this change (and the description :) with
the headers update, but I don't object to a separate change, either.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
