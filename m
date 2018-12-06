Received: from eggs.gnu.org ([2001:4830:134:3::10]:42230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUtib-0007Qg-1t
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUtiX-0001oD-93
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:29:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUtiW-0001n7-3f
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:29:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205110131.23049-1-d.csapak@proxmox.com>
Date: Thu, 06 Dec 2018 14:29:20 +0100
In-Reply-To: <20181205110131.23049-1-d.csapak@proxmox.com> (Dominik Csapak's
	message of "Wed, 5 Dec 2018 12:01:28 +0100")
Message-ID: <8736rag4wf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 0/3] qapi: return ShutdownCause for
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

Dominik Csapak <d.csapak@proxmox.com> writes:

> This series improves the QMP SHUTDOWN and RESET events by adding
> the ShutdownCause as additional parameter and splitting
> the HOST_QMP reason into HOST_QMP_QUIT and HOST_QMP_SYSTEM_RESET
> to be able to detect the difference between them when using '--no-reboot'
>
> this is an alternative to my previous patches[1][2] which
> added an exit-script/added a 'reset' argument to the events
>
>  1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00697.html
>  2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01271.html

Queued, thanks!
