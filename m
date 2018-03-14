Received: from eggs.gnu.org ([2001:4830:134:3::10]:33448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evxCd-0004Nm-RT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 23:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evxCa-00059U-LX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 23:35:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evxCa-000598-GY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 23:35:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E3CE7B4C8
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 03:35:40 +0000 (UTC)
Date: Wed, 14 Mar 2018 11:35:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180314033531.GL11787@xz-mi>
References: <20180313224719.4954-1-pbonzini@redhat.com>
	<152098654112.42.12932252584766342295@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <152098654112.42.12932252584766342295@71c20359a636>
Subject: Re: [Qemu-devel] [PULL 00/69] Misc patches for QEMU soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On Tue, Mar 13, 2018 at 05:15:41PM -0700, no-reply@patchew.org wrote:

[...]

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 2/69: net: allow using any PCI NICs in -net or -nic...
> Checking PATCH 3/69: q35: change default NIC to e1000e...
> Checking PATCH 4/69: scsi-disk.c: consider bl->max_transfer in INQUIRY emulation...
> Checking PATCH 5/69: qemu-doc: update deprecation section to use -nic and -netdev hubport...
> Checking PATCH 6/69: qemu-doc: Add the paragraph about the -no-frame deprecation again...
> Checking PATCH 7/69: build-sys: make help could have 'modules' target...
> Checking PATCH 8/69: hw: Do not include "sysemu/block-backend.h" if it is not necessary...
> Checking PATCH 9/69: checkpatch: Exempt long URLs...
> Checking PATCH 10/69: vl: export machine_init_done...
> Checking PATCH 11/69: chardev: fix handling of EAGAIN for TCP chardev...
> Checking PATCH 12/69: chardev: update net listener gcontext...
> Checking PATCH 13/69: chardev: allow telnet gsource to switch gcontext...
> Checking PATCH 14/69: chardev: introduce chr_machine_done hook...
> Checking PATCH 15/69: chardev: use chardev's gcontext for async connect...
> Checking PATCH 16/69: chardev: tcp: postpone async connection setup...
> Checking PATCH 17/69: chardev: tcp: let TLS run on chardev context...

It seems that Dan's last patch is still missing in the pull
request:

http://patchwork.ozlabs.org/patch/883155/

I hope the monitor-oob series can survive the qtests even without that
single patch...

Thanks,

-- 
Peter Xu
