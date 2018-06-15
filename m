Received: from eggs.gnu.org ([2001:4830:134:3::10]:48408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fTwgc-0006EU-Vo
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 17:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fTwgZ-0000It-Pe
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 17:55:15 -0400
Received: from tsukuyomi.43-1.org ([188.40.248.50]:52238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tamiko@43-1.org>) id 1fTwgZ-0000Hn-Ia
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 17:55:11 -0400
From: Matthias Maier <tamiko@43-1.org>
In-Reply-To: <87602kysk2.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 15 Jun 2018 17:31:57 +0200")
References: <20180615044042.7928-1-tamiko@43-1.org>
	<20180615044042.7928-3-tamiko@43-1.org>
	<87602kysk2.fsf@dusky.pond.sub.org>
Date: Fri, 15 Jun 2018 16:55:06 -0500
Message-ID: <87efh7pvet.fsf@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: open files in binary mode and
 use explicit decoding/encoding in common.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>


On Fri, Jun 15, 2018, at 10:31 CDT, Markus Armbruster <armbru@redhat.com> wrote:

> If I understand 7.2.3. Standard Encodings[*] correctly, the canonical
> name is "utf-8".  Let's use that.  Wait, it's the default, no need to
> pass an argument.

Roger. I will change this in v3.
