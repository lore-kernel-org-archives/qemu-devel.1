Received: from eggs.gnu.org ([2001:4830:134:3::10]:33487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVAb8-0000hr-0A
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVAb4-0005RJ-TF
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gVAb4-0005Qx-Mv
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:30:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 239E3169751
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 07:30:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181206232333.22408-1-pbonzini@redhat.com>
	<20181206232333.22408-4-pbonzini@redhat.com>
Date: Fri, 07 Dec 2018 08:30:47 +0100
In-Reply-To: <20181206232333.22408-4-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Fri, 7 Dec 2018 00:23:30 +0100")
Message-ID: <87bm5x3iag.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/6] qemu/queue.h: typedef QTAILQ heads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> This will be needed when we change the QTAILQ head and elem structs
> to unions.  However, it is also consistent with the usage elsewhere
> in QEMU for other list head structs (see for example FsMountList).
>
> Note that most QTAILQs only need their name in order to do backwards
> walks.  Those do not break with the struct->union change, and anyway
> the change will also remove the need to name heads when doing backwards
> walks, so those are not touched here.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
