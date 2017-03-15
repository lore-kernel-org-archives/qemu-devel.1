Received: from eggs.gnu.org ([2001:4830:134:3::10]:34880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8YL-0004gw-3Y
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8YG-0001mm-3b
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8YF-0001mW-UP
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:01:16 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB991C208079
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:01:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170315081641.20588-1-pbonzini@redhat.com>
Date: Wed, 15 Mar 2017 14:01:13 +0100
In-Reply-To: <20170315081641.20588-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Wed, 15 Mar 2017 09:16:41 +0100")
Message-ID: <87zigmitie.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] coverity-model: model
 address_space_read/write
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Commit eb7eeb8 ("memory: split address_space_read and
> address_space_write", 2015-12-17) made address_space_rw
> dispatch to one of address_space_read or address_space_write,
> rather than vice versa.
>
> For callers of address_space_read and address_space_write this
> causes false positive defects when Coverity sees a length-8 write in
> address_space_read and a length-4 (e.g. int*) buffer to read into.
> As long as the size of the buffer is okay, this is a false positive.
>
> Reflect the code change into the model.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Expect a pull request shortly.
