Received: from eggs.gnu.org ([2001:4830:134:3::10]:36760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFdGk-0000u4-R7
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFdGi-0000oZ-El
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:16:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFdGi-0000oJ-8F
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:16:48 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B03D83F40
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:16:47 +0000 (UTC)
References: <1494854073-19898-1-git-send-email-peterx@redhat.com>
	<20170529060813.GF22816@pxdev.xzpeter.org>
	<87k2506ltg.fsf@dusky.pond.sub.org>
	<20170529101331.GA14845@pxdev.xzpeter.org>
	<87d1ar504h.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13985c6d-d24a-ac50-2708-fc3b9cc64acd@redhat.com>
Date: Tue, 30 May 2017 11:16:44 +0200
MIME-Version: 1.0
In-Reply-To: <87d1ar504h.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>


> Note that a board that doesn't support MSI can take MSI-capable devices
> just fine.  Only the broken boards can't.
> 
> Obviously, broken boards should be fixed.  Once they all are, we can
> (and should!) remove msi_nonbroken.

That only works if we know what the broken boards are.

Right now, all boards that do not support MSI hide the capability, which
is wrong.  I'd prefer to remove msi_nonbroken completely if we don't
know where the problem is.

Paolo

> Ideally, the broken boards would mark themselves by clearing
> msi_nonbroken, with a comment explaining why.
> 
> Sadly, that's not what they do.  Instead, the *non-broken* boards mark
> themselves by setting msi_nonbroken.  Which ones of the boards that
> don't are actually broken is anyone's guess.  So is what exactly needs
> fixing.
> 
> I guess the first step towards removing msi_nonbroken would be
> addressing that particular sadness.  Patches welcome :)
> 
