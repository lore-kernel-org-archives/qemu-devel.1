Received: from eggs.gnu.org ([2001:4830:134:3::10]:52424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDmbj-00088O-3O
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDmbe-0006gt-2P
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:55:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fDmbd-0006fp-Rx
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:55:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9297140711B2
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 07:55:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180427192852.15013-1-lersek@redhat.com>
	<20180427192852.15013-3-lersek@redhat.com>
Date: Wed, 02 May 2018 09:55:06 +0200
In-Reply-To: <20180427192852.15013-3-lersek@redhat.com> (Laszlo Ersek's
	message of "Fri, 27 Apr 2018 21:28:49 +0200")
Message-ID: <878t928pb9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: add SysEmuTarget to
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
Cc: qemu-devel@nongnu.org

Laszlo Ersek <lersek@redhat.com> writes:

> We'll soon need an enumeration type that lists all the softmmu targets
> that QEMU (the project) supports. Introduce @SysEmuTarget to
> "common.json".
>
> The enum constant @x86_64 doesn't match the QAPI convention of preferring
> hyphen ("-") over underscore ("_"). This is intentional; the @SysEmuTarget
> constants are supposed to produce QEMU executable names when stringified
> and appended to the "qemu-system-" prefix. Put differently, the
> replacement text of the TARGET_NAME preprocessor macro must be possible to
> look up in the list of (stringified) enum constants.
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
