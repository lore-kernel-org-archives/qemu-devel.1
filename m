Received: from eggs.gnu.org ([2001:4830:134:3::10]:34545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUyjD-0006Ot-3n
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUyj9-0005Pt-OZ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:50:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gUyj9-0005Or-Gd
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:50:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6D933081D08
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 18:50:22 +0000 (UTC)
References: <1544114998-1513-1-git-send-email-thuth@redhat.com>
	<1544114998-1513-6-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be2f78fb-3453-d1d2-70e7-71ccf96851f2@redhat.com>
Date: Thu, 6 Dec 2018 12:50:19 -0600
MIME-Version: 1.0
In-Reply-To: <1544114998-1513-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 5/5] tests/pxe: Make test
 independent from global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 12/6/18 10:49 AM, Thomas Huth wrote:
> global_qtest is not really required here, since boot_sector_test()
> is already independent from that global variable.

Inconsistency in the use of 'independent of' and 'independent from' 
across the series. I think both work grammatically (English is screwy 
that way), but I prefer 'independent of'; it also matches your existing 
commits such as 7cbe423c.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/pxe-test.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
