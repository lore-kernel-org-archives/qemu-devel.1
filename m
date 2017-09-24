Received: from eggs.gnu.org ([2001:4830:134:3::10]:41875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEFE-00078G-Ss
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEFA-0001nU-Rn
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:15:20 -0400
References: <1500538486-23453-1-git-send-email-sf@sfritsch.de>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <68c8816f-69a7-8897-9dba-19c0309cd268@msgid.tls.msk.ru>
Date: Mon, 25 Sep 2017 00:15:15 +0300
MIME-Version: 1.0
In-Reply-To: <1500538486-23453-1-git-send-email-sf@sfritsch.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vmxcap: Fix output formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, qemu-trivial@nongnu.org
Cc: Stefan Fritsch <stefan_fritsch@genua.de>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Please excuse me for the long delay with this patch.

20.07.2017 11:14, Stefan Fritsch wrote:
> From: Stefan Fritsch <stefan_fritsch@genua.de>
> 
> One string is longer than 40 chars. Set the field width to 50.

The string is this one, I guess:

Miscellaneous data
  Hex: 0x100401e5
  VMX-preemption timer scale (log2)        5
  Store EFER.LMA into IA-32e mode guest control yes
  HLT activity state                       yes
  Shutdown activity state                  yes

While technically after this change, it will be aligned
in one column, I think it is better to reword this one
entry instead: when widening the alignment column, the
whole thing becomes less and less readable, it is more
difficult this way to follow which value correspond to
which entry.

A better wording for this one entry is welcome :)

Thanks,

/mjt
