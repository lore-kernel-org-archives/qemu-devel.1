Received: from eggs.gnu.org ([2001:4830:134:3::10]:44567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn3wk-0006IB-SH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn3wh-0000OW-J6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:26:22 -0400
Date: Wed, 30 Aug 2017 15:26:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830142615.GT24565@stefanha-x1.localdomain>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/10] scsi,
 file-posix: add support for persistent reservation management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:28PM +0200, Paolo Bonzini wrote:
> +#ifdef CONFIG_LINUX
> +PRManager *pr_manager_lookup(const char *id, Error **errp);
> +#else
> +static inline PRManager *pr_manager_lookup(const char *id,
> +                                                              Error **errp)

Indentation

> diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
> new file mode 100644
> index 0000000000..e80f8d9b31
> --- /dev/null
> +++ b/scsi/pr-manager.c
> @@ -0,0 +1,109 @@
> +/*
> + * Persistent reservation manager abstract class
> + *
> + * Copyright (c) 2017 Red Hat, Inc.
> + *
> + * Author: Paolo Bonzini <pbonzini@redhat.com>
> + *
> + * This code is licensed under the LGPL.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "block/aio.h"
> +#include "block/thread-pool.h"
> +#include "scsi/pr-manager.h"
> +#include "scsi/trace.h"
> +
> +#include <scsi/sg.h>

HACKING "1.2. Include directives" defines the order of #includes.  It
should be "qemu/osdep.h", <scsi/sg.h>, followed by all other QEMU
headers.
