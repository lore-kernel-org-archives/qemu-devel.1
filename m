Received: from eggs.gnu.org ([209.51.188.92]:50104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwVuS-0001F5-Dk
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwVuK-00025V-8L
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:43:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwVuE-0001xj-Fu
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:43:40 -0500
Date: Wed, 20 Feb 2019 17:43:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190220174326.GO2608@work-vm>
References: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
	<155025464362.24.1200537447541094855@49fa7ef69f7b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155025464362.24.1200537447541094855@49fa7ef69f7b>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yury-kotov@yandex-team.ru, fam@euphon.net, ehabkost@redhat.com, eblake@redhat.com, imammedo@redhat.com, quintela@redhat.com, lvivier@redhat.com, armbru@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, thuth@redhat.com, peter.maydell@linaro.org, jiangshanlai@gmail.com, qemu-devel@lists.ewheeler.net, wrfsh@yandex-team.ru

* no-reply@patchew.org (no-reply@patchew.org) wrote:
> Patchew URL: https://patchew.org/QEMU/20190215174548.2630-1-yury-kotov@yandex-team.ru/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20190215174548.2630-1-yury-kotov@yandex-team.ru
> Subject: [Qemu-devel] [PATCH v3 0/5] Add ignore-external migration capability
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 5f9e90967e migration: Add capabilities validation
> fad48088a8 tests/migration-test: Add a test for ignore-shared capability
> 68347ad2eb migration: Add an ability to ignore shared RAM blocks
> e3d2fd0298 migration: Introduce ignore-shared capability
> 73d9e23937 exec: Change RAMBlockIterFunc definition
> 
> === OUTPUT BEGIN ===
> 1/5 Checking commit 73d9e23937e9 (exec: Change RAMBlockIterFunc definition)
> 2/5 Checking commit e3d2fd0298a4 (migration: Introduce ignore-shared capability)
> 3/5 Checking commit 68347ad2eb24 (migration: Add an ability to ignore shared RAM blocks)
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #146: FILE: migration/ram.c:169:
> +#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (ramblock_is_ignored(block)) {} else

This is OK, it's just a copy of the existing macro we have for the loop

> ERROR: trailing statements should be on next line
> #148: FILE: migration/ram.c:171:
> +        if (ramblock_is_ignored(block)) {} else
> 
> total: 2 errors, 0 warnings, 386 lines checked
> 
> Patch 3/5 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 4/5 Checking commit fad48088a805 (tests/migration-test: Add a test for ignore-shared capability)
> 5/5 Checking commit 5f9e90967e69 (migration: Add capabilities validation)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20190215174548.2630-1-yury-kotov@yandex-team.ru/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
