Received: from eggs.gnu.org ([2001:4830:134:3::10]:51020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejurz-0001WD-48
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejurw-0006eq-23
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:40:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50786 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejurv-0006ed-T3
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:40:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D349140FB634
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 22:40:36 +0000 (UTC)
References: <1518120582-26647-1-git-send-email-thuth@redhat.com>
	<1518120582-26647-13-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <836a1719-013e-7f93-6ad5-3216334b5b30@redhat.com>
Date: Thu, 8 Feb 2018 16:40:33 -0600
MIME-Version: 1.0
In-Reply-To: <1518120582-26647-13-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/14] tests/boot-serial: Enable the
 boot-serial test on SPARC machines, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 02/08/2018 02:09 PM, Thomas Huth wrote:
> OpenBIOS prints out the name of the detected CPU here, so looking for
> this string is a nice test to verify that the CPU detection is still
> working correctly.
> 
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include   | 2 ++
>   tests/boot-serial-test.c | 4 ++++
>   2 files changed, 6 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
