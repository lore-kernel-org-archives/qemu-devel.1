Received: from eggs.gnu.org ([2001:4830:134:3::10]:54272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDBAt-0003iX-Ar
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDBAs-0001N9-N4
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:52:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dDBAs-0001MH-Gb
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:52:38 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BC4A4E4CB
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 14:52:37 +0000 (UTC)
References: <1494327362-30727-1-git-send-email-armbru@redhat.com>
	<b3e17067-8cb1-9b2f-413f-5e8b3d3ba503@redhat.com>
	<87vaorbyj9.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <730a6123-61cc-39f2-b62e-0bac48babf80@redhat.com>
Date: Tue, 23 May 2017 16:52:32 +0200
MIME-Version: 1.0
In-Reply-To: <87vaorbyj9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] scsi: Minor cleanups around scsi-disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org



On 23/05/2017 13:30, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 09/05/2017 12:56, Markus Armbruster wrote:
>>> Markus Armbruster (2):
>>>   block: Clarify documentation of BlockInfo member io-status
>>>   virtio-scsi-test: Use scsi-hd instead of legacy scsi-disk
>>>
>>>  qapi/block-core.json     | 3 ++-
>>>  tests/virtio-scsi-test.c | 2 +-
>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Thanks!
> 
> The canonical path is through your tree, but I could stick it into a
> miscellaneous pull request if you like.

I saw you posted these two together so I wasn't sure who would do that.
:)  These are not files that my pull requests touch a lot.

Paolo
