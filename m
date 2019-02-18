Received: from eggs.gnu.org ([209.51.188.92]:36904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvfhj-0003kG-S9
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvfcf-00048v-8S
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:54:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvfcf-00047M-2D
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:54:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2D13C704C
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 09:53:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1550227757-10869-1-git-send-email-pbonzini@redhat.com>
Date: Mon, 18 Feb 2019 10:53:51 +0100
In-Reply-To: <1550227757-10869-1-git-send-email-pbonzini@redhat.com> (Paolo
	Bonzini's message of "Fri, 15 Feb 2019 11:49:15 +0100")
Message-ID: <87bm39pgls.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] build: get rid of target-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

Paolo Bonzini <pbonzini@redhat.com> writes:

> It is possible to specify the trace/ directory already in objs-y;
> there is no need to have a separate unnest-vars invocation.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Nice cleanup.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
