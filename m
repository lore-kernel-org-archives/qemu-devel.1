Received: from eggs.gnu.org ([2001:4830:134:3::10]:53097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fE8Kc-0003Q7-TL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fE8KY-00014v-Ch
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:07:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fE8KY-00014f-7z
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:07:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D75F3EBFEE
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 07:07:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525281868-24747-1-git-send-email-thuth@redhat.com>
	<1525281868-24747-3-git-send-email-thuth@redhat.com>
Date: Thu, 03 May 2018 09:07:04 +0200
In-Reply-To: <1525281868-24747-3-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Wed, 2 May 2018 19:24:26 +0200")
Message-ID: <8736z9tdyf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/4] qemu-options: Remove deprecated
 -no-kvm-pit-reinjection
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

> Deprecated since the beginning when it was added for compatibility with
> the ancient qemu-kvm fork of QEMU, and it even printed out the deprecation
> warning since right from the start (i.e. QEMU v1.3.0), so it's really time
> to remove this now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
