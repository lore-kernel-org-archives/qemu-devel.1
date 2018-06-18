Received: from eggs.gnu.org ([2001:4830:134:3::10]:43143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fUvCw-0007JS-C5
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fUvCp-0004DK-Bc
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:32:38 -0400
Received: from tsukuyomi.43-1.org ([188.40.248.50]:35448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tamiko@43-1.org>) id 1fUvCp-00048I-1u
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:32:31 -0400
From: Matthias Maier <tamiko@43-1.org>
In-Reply-To: <87muvssm2t.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 18 Jun 2018 07:25:14 +0200")
References: <20180615220205.6929-1-tamiko@43-1.org>
	<20180615220205.6929-2-tamiko@43-1.org>
	<87muvssm2t.fsf@dusky.pond.sub.org>
Date: Mon, 18 Jun 2018 09:32:22 -0500
Message-ID: <87y3fcgo7d.fsf@43-1.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>


On Mon, Jun 18, 2018, at 00:25 CDT, Markus Armbruster <armbru@redhat.com> wrote:

> Matthias Maier <tamiko@43-1.org> writes:
>
>> This is a different approach to fix the locale dependent encode/decode
>> problem in common.py utilizing the binary read/write mode [1,2], and (if
>> a python 3 interpreter is used) with explicit decode/encode arguments
>> [3].
>
> Why can't we simply pass encoding='utf-8' to open()?

Because this breaks python-2 compatibility.

Best,
Matthias
