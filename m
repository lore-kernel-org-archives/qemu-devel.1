Received: from eggs.gnu.org ([2001:4830:134:3::10]:56530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zoup@zoup.org>) id 1crMbd-0002eS-6E
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zoup@zoup.org>) id 1crMbb-0003Yz-Vm
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:38:05 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:34983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zoup@zoup.org>) id 1crMbb-0003Yv-Pg
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:38:03 -0400
Received: by mail-io0-x230.google.com with SMTP id z13so14164133iof.2
	for <Qemu-devel@nongnu.org>; Fri, 24 Mar 2017 03:38:03 -0700 (PDT)
MIME-Version: 1.0
From: Armin Ranjbar <zoup@zoup.org>
Date: Fri, 24 Mar 2017 15:07:42 +0430
Message-ID: <CAOvx4-1MYO14+hkP8ZZg6Y4v_GFU8HtzYSeRo692zbsZN8D79A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] guest-exec of qemu-guest-agent fails on Windows guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-devel@nongnu.org
Cc: Behrooz <everplays@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi everyone,

We are trying to use guest-exec[0] command of qemu-guest-agent. However,
discovered that whatever command we try to run, it ends up with the
following error on the host side:

> error: Guest agent is not responding: Guest agent not available for now

An example of what we run on the host side:

> virsh qemu-agent-command --domain armin_1 '{ "execute": "guest-exec",
"arguments": { "path": "C:/Windows/System32/ipconfig.exe",
"capture-output": false } }'

Because Windows was complaining about `gspawn-win64-helper-console.exe`
whenever we ran a command on host, we tried to run it directly from cli and
it failed on the following assertion:

> g_assert (argc >= ARG_COUNT); // [1]

This picture[2] might be a bit more useful as it includes the output of
`qemu-ga` in verbose mode.

Any idea how we can solve it and/or what we are doing wrong?

Thanks in advance.

[0]
https://github.com/qemu/qemu/blob/fbddc2e5608eb655493253d080598375db61a748/qga/qapi-schema.json#L1024
[1]
https://github.com/GNOME/glib/blob/8edcf67b0221efa3c2ada67c44eff29939b1704d/glib/gspawn-win32-helper.c#L208
[2] https://ibin.co/3GTVo4WXfR7a.png

---
Armin ranjbar
