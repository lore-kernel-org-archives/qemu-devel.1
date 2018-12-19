Received: from eggs.gnu.org ([2001:4830:134:3::10]:45710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZdH6-0005It-A7
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZdH0-000782-2S
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:56:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZdGz-00075D-Pl
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:56:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DEDB796F2
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 14:56:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1545225205-7227-1-git-send-email-thuth@redhat.com>
Date: Wed, 19 Dec 2018 15:56:30 +0100
In-Reply-To: <1545225205-7227-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Wed, 19 Dec 2018 14:13:25 +0100")
Message-ID: <87h8f9efa9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc/ivshmem: Remove deprecated
 "ivshmem" legacy device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> It's been marked as deprecated in QEMU v2.6.0 already, so really nobody
> should use the legacy "ivshmem" device anymore (but use ivshmem-plain or
> ivshmem-doorbell instead). Time to remove the deprecated device now.
>
> Belatedly also update a mention of the deprecated "ivshmem" in the file
> docs/specs/ivshmem-spec.txt to "ivshmem-doorbell". Missed in commit
> 5400c02b90b ("ivshmem: Split ivshmem-plain, ivshmem-doorbell off ivshmem").
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
