Received: from eggs.gnu.org ([2001:4830:134:3::10]:56807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBxem-0008GW-6H
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBxej-0004zh-25
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:19:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBxei-0004zd-Ta
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:18:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D9F78D77D
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 07:18:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180426183404.3756-1-lersek@redhat.com>
	<20180426183404.3756-3-lersek@redhat.com>
Date: Fri, 27 Apr 2018 09:18:55 +0200
In-Reply-To: <20180426183404.3756-3-lersek@redhat.com> (Laszlo Ersek's message
	of "Thu, 26 Apr 2018 20:34:02 +0200")
Message-ID: <8736zhunfk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qapi: add SysEmuTarget to
 "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>

Laszlo Ersek <lersek@redhat.com> writes:

> We'll soon need an enumeration type that lists all the softmmu targets
> that QEMU (the project) supports. Introduce @SysEmuTarget to
> "common.json".
>
> The enum constant @x86_64 is not spelled @x86-64 because the corresponding
> emulator is called qemu-system-x86_64.
>
> Like other enum types, @SysEmuTarget too can be used for discriminator
> fields in unions. For the @i386 constant, a C-language union member called
> "i386" would be generated. On mingw build hosts, "i386" is a macro
> however. Add "i386" to "polluted_words" at once.
>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
