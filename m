Received: from eggs.gnu.org ([2001:4830:134:3::10]:54204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJlwL-0002Al-57
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJlwI-0005Xj-3X
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:53:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eJlwH-0005XV-TF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:53:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF959356D8
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 19:53:04 +0000 (UTC)
References: <20171122124504.13211-1-quintela@redhat.com>
	<20171122124504.13211-2-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6db20c98-22b1-3e39-a5aa-b3cf3abbf3e6@redhat.com>
Date: Tue, 28 Nov 2017 13:53:01 -0600
MIME-Version: 1.0
In-Reply-To: <20171122124504.13211-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/1] migration: Use proper types in json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 11/22/2017 06:45 AM, Juan Quintela wrote:
> We use int for everything (int64_t), and then we check that value is
> between 0 and 255.  Change it to the valid types.
> 
> This change only happens for HMP.  QMP always use bytes and similars.

s/similars/similar/

> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   hmp.c                 | 22 +++++++++++-----------
>   migration/migration.c | 49 ++++++++++++++++++++-----------------------------
>   qapi/migration.json   | 22 +++++++++++-----------
>   3 files changed, 42 insertions(+), 51 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
