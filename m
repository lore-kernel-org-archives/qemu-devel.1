Received: from eggs.gnu.org ([2001:4830:134:3::10]:41745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXryQ-0006cu-1B
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXryP-000394-94
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:41:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180614142944.10084-1-armbru@redhat.com>
	<20180626144659.GC3964@dhcp-200-186.str.redhat.com>
Date: Tue, 26 Jun 2018 19:41:41 +0200
In-Reply-To: <20180626144659.GC3964@dhcp-200-186.str.redhat.com> (Kevin Wolf's
	message of "Tue, 26 Jun 2018 16:46:59 +0200")
Message-ID: <87tvppcune.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block/crypto: Simplify block_crypto_{open,
 create}_opts_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 14.06.2018 um 16:29 hat Markus Armbruster geschrieben:
>> block_crypto_open_opts_init() and block_crypto_create_opts_init()
>> contain a virtual visit of QCryptoBlockOptions and
>> QCryptoBlockCreateOptions less member "format", respectively.
>> 
>> Change their callers to put member "format" in the QDict, so they can
>> use the generated visitors for these types instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> This doesn't seem to apply cleanly any more. Can you rebase?

v2 sent.
