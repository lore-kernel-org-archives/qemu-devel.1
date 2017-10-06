Received: from eggs.gnu.org ([2001:4830:134:3::10]:34915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0VFv-0008PC-90
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0VFt-00064P-5C
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:13:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e0VFs-00063m-VL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:13:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02EB0285C1
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 16:13:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171005190725.18712-1-dgilbert@redhat.com>
	<874lrc92u1.fsf@dusky.pond.sub.org>
Date: Fri, 06 Oct 2017 18:13:38 +0200
In-Reply-To: <874lrc92u1.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 06 Oct 2017 09:01:58 +0200")
Message-ID: <87d1601cgd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu_opt_print: Remove shadowing opt decl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
>
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> opt was declared as a separate local inside the last loop,
>> shadowing the local at the top of the function.
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> I can take this through my tree.

I'd like to change the headline to "option: Remove shadowing opt decl
from qemu_opt_print()", if that's alright with you.
