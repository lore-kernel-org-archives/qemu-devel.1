Received: from eggs.gnu.org ([2001:4830:134:3::10]:48657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD81h-0006F2-Ho
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD81d-0003T1-Ds
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD81d-0003Sm-0b
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:30:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC49E448D65
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 11:30:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1494327362-30727-1-git-send-email-armbru@redhat.com>
	<b3e17067-8cb1-9b2f-413f-5e8b3d3ba503@redhat.com>
Date: Tue, 23 May 2017 13:30:50 +0200
In-Reply-To: <b3e17067-8cb1-9b2f-413f-5e8b3d3ba503@redhat.com> (Paolo
	Bonzini's message of "Tue, 9 May 2017 12:59:07 +0200")
Message-ID: <87vaorbyj9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] scsi: Minor cleanups around scsi-disk
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

> On 09/05/2017 12:56, Markus Armbruster wrote:
>> Markus Armbruster (2):
>>   block: Clarify documentation of BlockInfo member io-status
>>   virtio-scsi-test: Use scsi-hd instead of legacy scsi-disk
>> 
>>  qapi/block-core.json     | 3 ++-
>>  tests/virtio-scsi-test.c | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>> 
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

The canonical path is through your tree, but I could stick it into a
miscellaneous pull request if you like.
