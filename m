Received: from eggs.gnu.org ([2001:4830:134:3::10]:59901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUycm-0007dm-MG
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUyci-0006Wj-M6
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:43:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gUyci-0006WY-FG
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:43:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D24293961
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 18:43:43 +0000 (UTC)
References: <1544114998-1513-1-git-send-email-thuth@redhat.com>
	<1544114998-1513-3-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a8eb2be-30ad-e7e3-65fc-7102890cea60@redhat.com>
Date: Thu, 6 Dec 2018 12:43:42 -0600
MIME-Version: 1.0
In-Reply-To: <1544114998-1513-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/5] tests/test-filter: Make tests
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
> Apart from using qmp() in the qmp_discard_response() macro, these
> tests do not have any dependencies to the global_qtest variable,
> so we can simply get rid of it here by replacing the qmp() with
> qtest_qmp() in the macro.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/test-filter-mirror.c     |  9 +++++----
>   tests/test-filter-redirector.c | 16 +++++++++-------
>   2 files changed, 14 insertions(+), 11 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
