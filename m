Received: from eggs.gnu.org ([2001:4830:134:3::10]:53336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fE8M5-0004cB-Vz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fE8M5-0001X1-5S
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:08:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fE8M4-0001We-W2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:08:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52F0881A88A7
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 07:08:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525281868-24747-1-git-send-email-thuth@redhat.com>
	<1525281868-24747-4-git-send-email-thuth@redhat.com>
Date: Thu, 03 May 2018 09:08:39 +0200
In-Reply-To: <1525281868-24747-4-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Wed, 2 May 2018 19:24:27 +0200")
Message-ID: <87y3h1rzbc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/4] qemu-options: Remove deprecated
 -no-kvm-irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> We've never documented this option in our qemu-doc, so unless the users
> used qemu-kvm before, they never should never have been aware of this
> option. It's been marked as deprecated in the source code since a long
> time already, and officially marked as deprecated in the documentation
> since QEMU v2.10, so it should be fine to remove this now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

With the commit message touched up like PATCH 4's:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
