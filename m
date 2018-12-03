Received: from eggs.gnu.org ([2001:4830:134:3::10]:45369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTnWx-0007S1-FQ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTnM1-0002cH-7Y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:29:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTnM1-0002bu-2k
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:29:37 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181203092617.24090-1-d.csapak@proxmox.com>
Date: Mon, 03 Dec 2018 13:29:34 +0100
In-Reply-To: <20181203092617.24090-1-d.csapak@proxmox.com> (Dominik Csapak's
	message of "Mon, 3 Dec 2018 10:26:14 +0100")
Message-ID: <871s6y4wup.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qapi: return ShutdownCause for
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

Paolo, would you like me to take this through my tree?
