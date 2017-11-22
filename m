Received: from eggs.gnu.org ([2001:4830:134:3::10]:58930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHQQW-0002qk-CN
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHQQS-0005Nb-8P
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:30:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHQQS-0005NB-2Z
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:30:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76ADE61D0D
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 08:30:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171121184738.8502-1-quintela@redhat.com> (Juan Quintela's
	message of "Tue, 21 Nov 2017 19:47:36 +0100")
References: <20171121184738.8502-1-quintela@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Nov 2017 09:30:27 +0100
Message-ID: <87d14apvfg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/2]  Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> THis has two fixes for migration, please apply.
>
> Later, Juan.
>
> The following changes since commit a15d835f00dce270fd3194e83d9910f4b5b44ac0:
>
>   Update version for v2.11.0-rc2 release (2017-11-21 17:50:36 +0000)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20171121
>
> for you to fetch changes up to 383d8a77222c016610d626887de80e770cdd9936:
>
>   migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END (2017-11-21 19:42:26 +0100)


Nack myself.

Old version of Daniel patch.

>
> ----------------------------------------------------------------
> migration/next for 20171121
>
> ----------------------------------------------------------------
> Anthony PERARD (1):
>       migration, xen: Fix block image lock issue on live migration
>
> Daniel Henrique Barboza (1):
>       migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END
>
>  migration/ram.c     | 22 +++++++++++++++-------
>  migration/savevm.c  | 23 ++++++++++++++++++++++-
>  qapi/migration.json |  6 +++++-
>  3 files changed, 42 insertions(+), 9 deletions(-)
