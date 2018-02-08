Received: from eggs.gnu.org ([2001:4830:134:3::10]:52844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejuxx-0006Zk-9e
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejuxr-00021m-45
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:46:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejuxr-00021b-0D
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:46:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54134404084E
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 22:46:44 +0000 (UTC)
References: <1518120582-26647-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a69d126-d541-baec-b9fe-5e43a2abf067@redhat.com>
Date: Thu, 8 Feb 2018 16:46:39 -0600
MIME-Version: 1.0
In-Reply-To: <1518120582-26647-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/14] qtest patches
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
> Here's a set of qtest patches that have been posted to the list before
> and are IMHO ready for inclusion. I've included the patches from Eric's
> "Preliminary libqtest cleanups" series that do not need major reworks
> (the rest needs some more love later), and some additional entries for
> the boot-serial tester. If there are no objections, I'll sent a PULL
> request for these patches next week.

Thanks for reviving my patches (and now I have more incentive to give 
that "more love later" to the rest of my series).  I feel odd reviewing 
my work, but the edits you have made to resolve rebase conflicts look 
reasonable on the patches that bear my name.

> 
> Eric Blake (10):
>    libqtest: Use qemu_strtoul()
>    libqos: Track QTestState with QPCIBus
>    libqos: Use explicit QTestState for fw_cfg operations
>    libqos: Use explicit QTestState for rtas operations
>    libqos: Use explicit QTestState for i2c operations
>    libqos: Use explicit QTestState for ahci operations
>    libqos: Use explicit QTestState for remaining libqos operations
>    qmp-test: Drop dependence on global_qtest
>    tests/boot-sector: Drop dependence on global_qtest
>    wdt_ib700-test: Drop dependence on global_qtest
> 
> Markus Armbruster (1):
>    tests: Clean up wait for event
> 
> Thomas Huth (2):
>    tests/boot-serial: Enable the boot-serial test on SPARC machines, too
>    tests/boot-serial: Add tests for PowerPC Mac machines
> 
> Wei Huang (1):
>    tests/boot-serial-test: Add support for the aarch64 virt machine
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
