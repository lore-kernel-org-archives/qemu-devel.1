Received: from eggs.gnu.org ([2001:4830:134:3::10]:53904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFi9s-0004Wx-Oe
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFi9p-00006H-GY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:30:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFi9p-000065-BP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:30:01 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D36465D17
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 14:30:00 +0000 (UTC)
References: <1494854073-19898-1-git-send-email-peterx@redhat.com>
	<20170529060813.GF22816@pxdev.xzpeter.org>
	<87k2506ltg.fsf@dusky.pond.sub.org>
	<20170529101331.GA14845@pxdev.xzpeter.org>
	<87d1ar504h.fsf@dusky.pond.sub.org>
	<13985c6d-d24a-ac50-2708-fc3b9cc64acd@redhat.com>
	<87h902l8qd.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a6a91cc-7ea1-2b45-a4bd-31aa3cfef917@redhat.com>
Date: Tue, 30 May 2017 16:29:57 +0200
MIME-Version: 1.0
In-Reply-To: <87h902l8qd.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>



On 30/05/2017 16:28, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>>> Note that a board that doesn't support MSI can take MSI-capable devices
>>> just fine.  Only the broken boards can't.
>>>
>>> Obviously, broken boards should be fixed.  Once they all are, we can
>>> (and should!) remove msi_nonbroken.
>>
>> That only works if we know what the broken boards are.
> 
> Yes.
> 
>> Right now, all boards that do not support MSI hide the capability, which
>> is wrong.
> 
> Agreed.
> 
>>            I'd prefer to remove msi_nonbroken completely if we don't
>> know where the problem is.
> 
> So you're proposing to (1) remove msi_nonbroken, (2) see which boards
> burst into flames, and (3) fix them, or perhaps add a less wrong stop
> gap msi_broken just for them?

Yes, adding back msi_broken is one "git revert" away.

Of course, this means the edu memory leak should be fixed in a separate
small patch.

Thanks,

Paolo
