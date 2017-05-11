Received: from eggs.gnu.org ([2001:4830:134:3::10]:47401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1d8pSv-0003PC-BT
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1d8pSs-0002E6-90
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:53:17 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:35876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1d8pSs-0002Dx-2o
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:53:14 -0400
Received: by mail-qk0-x22f.google.com with SMTP id u75so24270864qka.3
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 07:53:13 -0700 (PDT)
Date: Thu, 11 May 2017 10:53:12 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170511145312.GA822@morn.lan>
References: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com

On Thu, May 11, 2017 at 01:35:28PM +0200, Paolo Bonzini wrote:
> Ignore env->a20_mask when running in system management mode.

Thanks Paolo.  I don't think this patch will help SeaBIOS though.  The
SeaBIOS SMM handler doesn't do much - it doesn't even access ram above
1MiB.  See SeaBIOS' code in src/fw/smm.c:handle_smi().

Instead, the SeaBIOS code does a cpu state backup/restore to switch
into 32bit mode.  I thought the A20 state would be part of that cpu
backup/restore.  However, looking at the Intel SDM docs now, it's not
really clear to me how the processor "inhibits" A20 when in SMM mode -
does it save/restore that state on SMI/RSM or does it have special
logic to ignore A20 while in SMM mode?

-Kevin
