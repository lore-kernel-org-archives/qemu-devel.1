Received: from eggs.gnu.org ([2001:4830:134:3::10]:32947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUqcy-0006wg-FA
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUqcx-0007U1-Ny
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:34:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUqcx-0007Tf-Gx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:34:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87A83C0587CD
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:34:38 +0000 (UTC)
References: <20170710165827.4250-1-pbonzini@redhat.com>
	<20170710165827.4250-2-pbonzini@redhat.com>
	<20170711082836.GB4335@noname.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fcbd4204-3604-b562-0cde-af697344f2a6@redhat.com>
Date: Tue, 11 Jul 2017 10:34:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170711082836.GB4335@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] qcow2: make qcow2_do_open a
 coroutine_fn
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

On 11/07/2017 10:28, Kevin Wolf wrote:
> Am 10.07.2017 um 18:58 hat Paolo Bonzini geschrieben:
>> It is called from qcow2_invalidate_cache in coroutine context, so always
>> load metadata from a coroutine.
>> ---
>>  block/qcow2.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 40 insertions(+), 5 deletions(-)
> 
> Missing S-o-b on patches 1 and 2?

Oops, yes.  Though I don't think these patches are for 2.10.  They are
on top of Stefan's bdrv_co_create series, by the way.

Paolo

> These patches suggest that .bdrv_co_open() might be the next thing to
> get rid of the coroutine wrappers again in driver code. But we'll always
> have some wrappers in the drivers in an intermediate state, so doing
> .bdrv_invalidate_cache first is fine.
> 
> Kevin
> 
