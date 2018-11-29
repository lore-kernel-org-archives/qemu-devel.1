Received: from eggs.gnu.org ([2001:4830:134:3::10]:44766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSLnN-0006Yl-Oa
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSLnI-00056D-QM
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:51:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSLnI-000565-Kv
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:51:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <5BE31F76020000760003D33A@prv-mh.provo.novell.com>
Date: Thu, 29 Nov 2018 13:51:46 +0100
In-Reply-To: <5BE31F76020000760003D33A@prv-mh.provo.novell.com> (Kirk Allan's
	message of "Wed, 07 Nov 2018 10:23:02 -0700")
Message-ID: <87mups82sd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] getting link errors when building for qga-vss.dll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirk Allan <kallan@suse.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Michael Roth <mdroth@linux.vnet.ibm.com>

Cc'ing folks who might be able to help.

"Kirk Allan" <kallan@suse.com> writes:

> When I try to build qga-vss.dll I get the following link error:
>
> LINK    qga/vss-win32/qga-vss.dll
> /usr/lib64/gcc/i686-w64-mingw32/8.2.0/../../../../i686-w64-mingw32/bin/ld: qga/vss-win32/requester.o: in function `requester_freeze':
> /src/qemu/qga/vss-win32/requester.cpp:284: undefined reference to `g_assertion_message_expr'
>
> I started getting this link error with commit 3ebee3b191e755d3f7311a6a62eea5c9628b221b where assert is redefined to g_assert.
>
> Is there something additional I need to add to my configure or make commands to resolve g_assertion_message_expr?
>
> My configure command is: ./configure --cross-prefix=i686-w64-mingw32- --enable-guest-agent --with-vss-sdk
>
> My make command is: make qemu-ga.exe qga/vss-win32/qga-vss.dll
>
> Thanks,
> Kirk
