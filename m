Received: from eggs.gnu.org ([2001:4830:134:3::10]:60806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUyfI-0001mj-Eq
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUyfE-0000q2-54
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:46:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gUyfD-0000pY-TP
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:46:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A5B880F96
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 18:46:19 +0000 (UTC)
References: <1544114998-1513-1-git-send-email-thuth@redhat.com>
	<1544114998-1513-5-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8a74997f-1a7c-b7a8-93d1-fae304edfb1c@redhat.com>
Date: Thu, 6 Dec 2018 12:46:17 -0600
MIME-Version: 1.0
In-Reply-To: <1544114998-1513-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 4/5] tests/prom-env: Make test
 independent of global_qtest
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
> global_qtest is only needed here for one readl(). Let's replace it
> with qtest_readl() and we can remove the global_qtest variable here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/prom-env-test.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
