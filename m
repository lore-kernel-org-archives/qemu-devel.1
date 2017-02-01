Received: from eggs.gnu.org ([2001:4830:134:3::10]:40467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYoph-0004cR-OX
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 01:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYopd-0007f1-3U
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 01:55:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cYopc-0007eS-UL
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 01:55:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1a4f4e94-7d31-e8de-dc28-516120ed03b7@redhat.com>
Date: Wed, 01 Feb 2017 07:55:49 +0100
In-Reply-To: <1a4f4e94-7d31-e8de-dc28-516120ed03b7@redhat.com> (Max Reitz's
	message of "Wed, 1 Feb 2017 04:06:10 +0100")
Message-ID: <87zii6iemi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/2] block/qapi: refactor and optimize
 the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com, famz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> Thanks, dropped one of the duplicate info->value assignments in patch 2
> and applied the series to my block tree:
>
> https://github.com/XanClic/qemu/commits/block
>
> (Assuming Markus' R-b meant that he does not intends to take it through
> his tree.)

"Does not intend" is a bit too strong, but please go ahead and save me
work :)
