Received: from eggs.gnu.org ([2001:4830:134:3::10]:52336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctb4K-0003fX-4e
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctb4G-0007Wa-Sl
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:28:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctb4G-0007W6-MZ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:28:52 -0400
Date: Thu, 30 Mar 2017 11:28:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170330142848.GK3709@thinpad.lan.raisama.net>
References: <20170330050924.22134-1-iwona260909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330050924.22134-1-iwona260909@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] hmp: fix "info cpu" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Iwona Kotlarska <iwona260909@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Thu, Mar 30, 2017 at 07:09:24AM +0200, Iwona Kotlarska wrote:
> Running QEMU with "qemu-system-x86_64 -M none -nographic -m 256" and executing
> "dump-guest-memory /dev/null 0 8192" results in segfault.
> Fix by checking if we have CPU.
> 
> Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Thanks!

Paolo, are you queueing x86 bug fixes for the next -rc?

-- 
Eduardo
