Received: from eggs.gnu.org ([2001:4830:134:3::10]:53484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFi8X-0003PJ-M4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFi8R-0008H8-TT
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:28:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dFi8R-0008Gk-NU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8F708123F
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 14:28:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1494854073-19898-1-git-send-email-peterx@redhat.com>
	<20170529060813.GF22816@pxdev.xzpeter.org>
	<87k2506ltg.fsf@dusky.pond.sub.org>
	<20170529101331.GA14845@pxdev.xzpeter.org>
	<87d1ar504h.fsf@dusky.pond.sub.org>
	<13985c6d-d24a-ac50-2708-fc3b9cc64acd@redhat.com>
Date: Tue, 30 May 2017 16:28:26 +0200
In-Reply-To: <13985c6d-d24a-ac50-2708-fc3b9cc64acd@redhat.com> (Paolo
	Bonzini's message of "Tue, 30 May 2017 11:16:44 +0200")
Message-ID: <87h902l8qd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

>> Note that a board that doesn't support MSI can take MSI-capable devices
>> just fine.  Only the broken boards can't.
>> 
>> Obviously, broken boards should be fixed.  Once they all are, we can
>> (and should!) remove msi_nonbroken.
>
> That only works if we know what the broken boards are.

Yes.

> Right now, all boards that do not support MSI hide the capability, which
> is wrong.

Agreed.

>            I'd prefer to remove msi_nonbroken completely if we don't
> know where the problem is.

So you're proposing to (1) remove msi_nonbroken, (2) see which boards
burst into flames, and (3) fix them, or perhaps add a less wrong stop
gap msi_broken just for them?
