Received: from eggs.gnu.org ([2001:4830:134:3::10]:50242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRb1o-0006bI-Ng
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 04:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRb1o-0007Am-1e
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 04:51:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRb1n-00079a-RU
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 04:51:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 524894903B
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:51:06 +0000 (UTC)
Date: Wed, 20 Dec 2017 17:51:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171220095104.GB10812@lemon>
References: <20171205151553.7834-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205151553.7834-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Add share-rw option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 12/05 23:15, Fam Zheng wrote:
> Add the property to the device model, then parse it by calling
> blkconf_apply_backend_options().
> 
> In addition to blk_set_perm(), the called function also handles error
> options and wce. For error options we've already checked that the
> default values are used, for wce we don't have the option either so it
> is always the default (true). In other words there is no change of
> behavior in these regards.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Ping? :)

Fam
