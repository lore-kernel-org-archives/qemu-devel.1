Received: from eggs.gnu.org ([2001:4830:134:3::10]:52926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fE8Jn-0002c9-NM
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fE8Ji-0000ic-N0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:06:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fE8Ji-0000iD-Ic
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E6818185951
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 07:06:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525281868-24747-1-git-send-email-thuth@redhat.com>
	<1525281868-24747-5-git-send-email-thuth@redhat.com>
Date: Thu, 03 May 2018 09:06:03 +0200
In-Reply-To: <1525281868-24747-5-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Wed, 2 May 2018 19:24:28 +0200")
Message-ID: <877eolte04.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/4] qemu-options: Remove deprecated -no-kvm
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

You're serious about "never", aren't you?  ;->

> option. It's been marked as deprecated in the source code since a long

s/since/for/

> time already, and officially marked as deprecated in the documentation
> since QEMU v2.10, so it should be fine to remove this now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

With the commit message touched up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
