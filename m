Received: from eggs.gnu.org ([2001:4830:134:3::10]:60313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP3A-000348-5b
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP39-0002FY-D1
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:42:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejP39-0002Dt-95
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:42:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CB654075171
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:41:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180202064546.21746-1-kraxel@redhat.com>
Date: Wed, 07 Feb 2018 13:41:50 +0100
In-Reply-To: <20180202064546.21746-1-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Fri, 2 Feb 2018 07:45:46 +0100")
Message-ID: <87a7wlas4x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] vnc: use stubs for CONFIG_VNC=n dummy
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

I took the liberty to pick this into my "[PULL 00/20] Miscellaneous
patches for 2018-02-07", because there's a semantic dependence between
one of its patches an this one.  Hope that's okay.
