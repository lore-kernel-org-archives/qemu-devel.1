Received: from eggs.gnu.org ([2001:4830:134:3::10]:60606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8pzu-0001NF-Gw
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8pzq-0005BN-FQ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:27:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8pzq-0005AY-97
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:27:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B29DC059756
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 15:27:17 +0000 (UTC)
Date: Thu, 11 May 2017 16:27:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170511152710.GI2078@work-vm>
References: <20170511143901.6340-1-quintela@redhat.com>
	<149451627681.336.14543368400046903247@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149451627681.336.14543368400046903247@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PATCH] migration: Move check_migratable() into
 qdev.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: lvivier@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org

* no-reply@patchew.org (no-reply@patchew.org) wrote:
> Hi,
> 
>   CC      armeb-linux-user/gdbstub-xml.o
>   CC      armeb-linux-user/trace/generated-helpers.o
>   LINK    armeb-linux-user/qemu-armeb
> ../hw/core/qdev.o: In function `check_only_migratable':
> /var/tmp/patchew-tester-tmp-uf2ealih/src/hw/core/qdev.c:869: undefined reference to `only_migratable'
> collect2: error: ld returned 1 exit status
> Makefile:201: recipe for target 'qemu-armeb' failed
> make[1]: *** [qemu-armeb] Error 1
> Makefile:327: recipe for target 'subdir-armeb-linux-user' failed
> make: *** [subdir-armeb-linux-user] Error 2
> === OUTPUT END ===

Right, you see why I suggested testing for the user only build!

Dave

> 
> Test command exited with code: 2
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
