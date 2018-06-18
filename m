Received: from eggs.gnu.org ([2001:4830:134:3::10]:60726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUmfK-00051h-FP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 01:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUmfG-0000dq-CC
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 01:25:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUmfG-0000dD-7b
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 01:25:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180615220205.6929-1-tamiko@43-1.org>
	<20180615220205.6929-2-tamiko@43-1.org>
Date: Mon, 18 Jun 2018 07:25:14 +0200
In-Reply-To: <20180615220205.6929-2-tamiko@43-1.org> (Matthias Maier's message
	of "Fri, 15 Jun 2018 17:02:04 -0500")
Message-ID: <87muvssm2t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qapi: open files in binary mode and
 use explicit decoding/encoding in common.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthias Maier <tamiko@43-1.org>
Cc: qemu-devel@nongnu.org, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Matthias Maier <tamiko@43-1.org> writes:

> This is a different approach to fix the locale dependent encode/decode
> problem in common.py utilizing the binary read/write mode [1,2], and (if
> a python 3 interpreter is used) with explicit decode/encode arguments
> [3].

Why can't we simply pass encoding='utf-8' to open()?

> This approach is preferred over the fix in commit d4e5ec877ca because it
> is (a) locale independent, and (b) does not depend on the en_US.UTF_8
> locale to be available.
>
> [1] https://docs.python.org/3.6/library/stdtypes.html#bytes.decode
> [2] https://docs.python.org/3.6/library/stdtypes.html#str.encode
> [3] https://docs.python.org/3/howto/unicode.html
>
> Signed-off-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>
> Signed-off-by: Matthias Maier <tamiko@43-1.org>
