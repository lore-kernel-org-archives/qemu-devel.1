Received: from eggs.gnu.org ([2001:4830:134:3::10]:38069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.rigo@virtualopensystems.com>) id 1cHFHK-0003no-3e
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.rigo@virtualopensystems.com>) id 1cHFHG-0007Yu-WE
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:31:50 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:35329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.rigo@virtualopensystems.com>)
	id 1cHFHG-0007Uc-PO
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:31:46 -0500
Received: by mail-io0-f174.google.com with SMTP id h30so49249034iod.2
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 11:31:23 -0800 (PST)
MIME-Version: 1.0
From: Alvise Rigo <a.rigo@virtualopensystems.com>
Date: Wed, 14 Dec 2016 20:30:07 +0100
Message-ID: <CAH47eN3AVo-4CWN8XHhVz5F811Dc-iS8pVmW+4EW_1mvbpVgpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel]  Making TCG configurable in system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, chao.p.peng@linux.intel.com, Claudio Fontana <Claudio.Fontana@huawei.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>

Hi all,

I am looking at the possibility to add a new QEMU configuration option
to make TCG optional (in qemu-system-*). What I am exploring is a way
to exclude any of the TCG code not needed by KVM from the QEMU binary.
There has been a previous attempt in the past from Paolo Bonzini,
namely https://github.com/bonzini/qemu/tree/disable-tcg, that
eventually was not upstreamed. I was looking into this work mainly,
mostly to understand if the same approach can be respinned and used to
support all the QEMU's targets. Any input on this is welcome.

I was also wondering if an approach could be based on the recent patch
series that allows to use the TCG frontend as a library --
https://www.mail-archive.com/qemu-devel@nongnu.org/msg415514.html.
Making qemu-user and qemu-system users of such a library might help in
having TCG optional. Obviously this solution introduces many other
challenges and I'm not even sure if it's actually viable.

I would like to hear your opinion on this, ideally to identify what
would be the best direction to follow for bringing this new feature
into QEMU.

Thank you,
alvise
