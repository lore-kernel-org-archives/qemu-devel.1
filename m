Received: from eggs.gnu.org ([2001:4830:134:3::10]:46945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSLdJ-00083T-Tp
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSLdG-0003LV-NC
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:09:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSLdG-0003L8-Ir
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:09:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 387EF400225D
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 12:09:10 +0000 (UTC)
Date: Mon, 11 Jun 2018 13:09:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611120906.GE2661@work-vm>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<87a7s1il25.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7s1il25.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Reenable hmp for preconfig mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:
> Let's also provide "quit", both in HMP and QMP.

I tried enabling quit, but it fails with an incorrect
state transition.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
