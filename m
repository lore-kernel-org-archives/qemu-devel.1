Received: from eggs.gnu.org ([2001:4830:134:3::10]:42513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez5ih-0001u0-4I
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez5ic-0001w0-KL
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:17:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ez5ic-0001vg-FW
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:17:46 -0400
References: <20180322180940.8253-1-jcmvbkbc@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbfa79c8-50cf-e902-bcd3-3ae39a5c3dce@redhat.com>
Date: Thu, 22 Mar 2018 14:17:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180322180940.8253-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] target/xtensa: improvements for
 core-specific files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 03/22/2018 01:09 PM, Max Filippov wrote:
> Hello,
> 
> this series adds .inc. to the names of non-top level xtensa core-specific
> files and fixes script import_core.sh so that it does it automatically.
> It also adds a fixup to the script that changes #include <xtensa-isa.h>
> to #include "xtensa-isa.h".
> 
> Max Filippov (3):
>    target/xtensa: add .inc. to non-top level source file names
>    target/xtensa/import_core.sh: fix names of non-top level files
>    target/xtensa/import_core.sh: fix #include <xtensa-isa.h>

Simple enough.  I don't know if it qualifies as a bug fix, so up to you 
as maintainer whether you feel comfortable enough getting it into 2.12. 
See my per-patch comments about possibly merging 1 and 2; but for the 
series,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
