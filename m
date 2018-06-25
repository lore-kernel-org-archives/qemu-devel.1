Received: from eggs.gnu.org ([2001:4830:134:3::10]:56753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXNjc-0003P8-FX
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXNjX-0004pS-J6
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:24:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fXNjX-0004p0-Fn
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:24:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CC0A4023336
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:24:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1529917512-10528-1-git-send-email-thuth@redhat.com>
Date: Mon, 25 Jun 2018 11:24:25 +0200
In-Reply-To: <1529917512-10528-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Mon, 25 Jun 2018 11:05:12 +0200")
Message-ID: <87r2kvw75i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] hw/i386: Deprecate the machine types
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> The oldest machine type which is still used in a still maintained distro
> is a pc-0.12 based machine type in RHEL6, so everything that is older
> than pc-0.12 should not be used anymore. Thus let's deprecate pc-0.10
> and pc-0.11 so that we can finally remove them in a future release.
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
