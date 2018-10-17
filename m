Received: from eggs.gnu.org ([2001:4830:134:3::10]:55722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCk7l-0000QS-3m
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCk7h-00067X-ES
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCk7g-00064S-UJ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:36:21 -0400
References: <20181008131924.7377-1-d.csapak@proxmox.com>
	<1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
	<d2f89cb6-0ea5-75bc-1bb1-3f0ce6509ec4@redhat.com>
	<d5d914fc-daa1-4164-44ba-a02365a44ddb@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be7e85ab-a29c-9925-78fd-2a306b40f225@redhat.com>
Date: Wed, 17 Oct 2018 13:36:15 +0200
MIME-Version: 1.0
In-Reply-To: <d5d914fc-daa1-4164-44ba-a02365a44ddb@proxmox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi: add info about reset to SHUTDOWN
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com

On 17/10/2018 13:34, Dominik Csapak wrote:
> i would find it nicer to always be able to distinguish between
> a reset and a normal exit, since it would be less work on the
> management side (i.e. we would have to handle the qmp reset elsewhere
> instead of in the same process that monitors the events)

Ok---I am not opposed to this patch at all.  I mentioned ShutdownCause
only because it was brought up as a possible future extension when
'guest' was added.

> also it would make the 'guest' parameter redundant or change the api and
> i am not sure about how stable it has to be?

The guest parameter would have to stay even if it is redundant.

Paolo
