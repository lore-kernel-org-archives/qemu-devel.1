Received: from eggs.gnu.org ([2001:4830:134:3::10]:35324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAHZp-00071U-LZ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAHZk-0002Et-Vb
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:43:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gAHZj-0002Dw-50
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:43:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26E443084024
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 16:43:06 +0000 (UTC)
References: <20181010061113.6057-1-armbru@redhat.com>
	<20181010061113.6057-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97edaf90-6e1b-92b0-9bcf-3e894328512e@redhat.com>
Date: Wed, 10 Oct 2018 11:43:05 -0500
MIME-Version: 1.0
In-Reply-To: <20181010061113.6057-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 3/5] tests: Restore check-qdict unit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 10/10/18 1:11 AM, Markus Armbruster wrote:
> Commit 0bcc8e5bd8d accidentally dropped check-qdict from the list of
> unit tests (again, see commit 4429532b48a).  Put it back, and fix up
> the test.

Since this seems to be a recurring problem...

> +++ b/tests/Makefile.include
> @@ -40,7 +40,7 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
>   
>   check-unit-y = tests/check-qdict$(EXESUF)

How about a followup patch that does:

-   check-unit-y = tests/check-qdict$(EXESUF)
+   check-unit-y =
+   check-unit-y += tests/check-qdict$(EXESUF)


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
