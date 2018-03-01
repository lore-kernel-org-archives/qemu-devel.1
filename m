Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erVJe-0004he-0g
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erVJZ-00027c-VB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:00:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erVJZ-00026U-ON
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:00:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD171C057F87
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 21:00:32 +0000 (UTC)
References: <151993767396.1299.15660444397103345250@bdbb90650ae5>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06c1a363-0005-5a53-7099-cbeaad18cf37@redhat.com>
Date: Thu, 1 Mar 2018 15:00:23 -0600
MIME-Version: 1.0
In-Reply-To: <151993767396.1299.15660444397103345250@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/30] QAPI patches for 2018-03-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

On 03/01/2018 02:54 PM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> Type: series
> Message-id: 20180301194245.29854-1-eblake@redhat.com
> Subject: [Qemu-devel] [PULL 00/30] QAPI patches for 2018-03-01
> 

>    CC      s390x-softmmu/hw/s390x/s390-skeys-kvm.o
>    CC      s390x-softmmu/hw/s390x/s390-stattrib-kvm.o
>    CC      sh4eb-softmmu/memory.o
>    CC      s390x-softmmu/hw/s390x/s390-ccw.o
>    CC      s390x-softmmu/target/s390x/cpu.o
> /var/tmp/patchew-tester-tmp-u79v_jwg/src/target/s390x/cpu.c:38:10: fatal error: qapi-visit.h: No such file or directory
>   #include "qapi-visit.h"
>            ^~~~~~~~~~~~~~

Real problem introduced by this series, looks like I get to rebase and 
send v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
