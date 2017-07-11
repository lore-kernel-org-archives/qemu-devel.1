Received: from eggs.gnu.org ([2001:4830:134:3::10]:34437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUqjW-00034l-Aw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUqjV-00027W-L0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUqjV-00026t-Ek
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:41:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 620CF80F6C
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:41:24 +0000 (UTC)
References: <20170710165827.4250-1-pbonzini@redhat.com>
	<20170710165827.4250-4-pbonzini@redhat.com>
	<20170711082451.GA4335@noname.str.redhat.com>
	<555a050c-46cb-72c3-e3c0-fb37fd23bdf4@redhat.com>
	<20170711083911.GC4335@noname.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab39bbb2-3007-6387-2bfd-315c7b6e02db@redhat.com>
Date: Tue, 11 Jul 2017 10:41:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170711083911.GC4335@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] block: convert bdrv_invalidate_cache
 callback to coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

On 11/07/2017 10:39, Kevin Wolf wrote:
> Can you just add a comment to this effect to qcow2/qed_do_open() then?

Good point.

>>> Or maybe the cleaner way would be bdrv_drained_begin/end() around
>>> everything directly in bdrv_co_invalidate_cache().
> 
> Should we do this anyway? Or assert that no requests are in flight?

I can certainly add assertions for clarity, but wouldn't requests have
failed the permission checks and caused assertion failures already?

Paolo
