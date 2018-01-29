Received: from eggs.gnu.org ([2001:4830:134:3::10]:42995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jonemilj@gmail.com>) id 1eg0sm-0006yD-C3
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jonemilj@gmail.com>) id 1eg0sl-00057k-Kr
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:17:24 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:39525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jonemilj@gmail.com>) id 1eg0sl-00057J-EO
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:17:23 -0500
Received: by mail-lf0-x244.google.com with SMTP id w27so7919589lfd.6
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 20:17:23 -0800 (PST)
From: Jon Emil Jahren <jonemilj@gmail.com>
Date: Mon, 29 Jan 2018 05:16:46 +0100
Message-Id: <20180129041648.30884-1-jonemilj@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] tracetool: Fix ust tracepoint issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Jon Emil Jahren <jonemilj@gmail.com>

There are some issues with the argument parsing for ust.
The first issue is that the regex pattern matching arguments with PRI
types matched too much. This was fixed by using a non-greedy star,
instead of a greedy.
The second issue is that bool type is not recognized. This was fixed by
adding the bool type to be traced as an integer.
Both issues causes missing information in the trace.

The following patches fix the issues mentioned.

Jon Emil Jahren (2):
  tracetool: Update argument format regex to non-greedy star
  tracetool: For ust trace bool type as ctf_integer

 scripts/tracetool/__init__.py            | 5 +++--
 scripts/tracetool/format/ust_events_h.py | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.14.3
