Received: from eggs.gnu.org ([2001:4830:134:3::10]:43968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d5DkU-0004DP-5N
	for qemu-devel@nongnu.org; Mon, 01 May 2017 12:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d5DkR-0008Pk-2K
	for qemu-devel@nongnu.org; Mon, 01 May 2017 12:00:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1d5DkQ-0008PT-T4
	for qemu-devel@nongnu.org; Mon, 01 May 2017 12:00:27 -0400
References: <CAGKXQyewQkpv=KgCYt86VAvrPmFdsQvs3kev_W74OrJApUvfEg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <464e19e7-a11e-fc28-a6ed-b6f1506658be@redhat.com>
Date: Mon, 1 May 2017 12:00:24 -0400
MIME-Version: 1.0
In-Reply-To: <CAGKXQyewQkpv=KgCYt86VAvrPmFdsQvs3kev_W74OrJApUvfEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] bytes xfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>, qemu-devel@nongnu.org



On 04/29/2017 01:23 AM, ali saeedi wrote:
> Hi
> what does 'bytes_xfer' and 'xfer_limit' mean?
> I am new in qemu.
> thanks a lot
> 

The exact meaning is going to change depending on where you are looking.
As advice for mailing a technical list, please be prepared with code
excerpts from the files you are investigating and provide filenames and
line numbers so that your question can be answered.

As for your question:

'bytes_xfer' is likely short for "Bytes Transferred" and counts the
number of bytes sent over a socket or stream.

'xfer_limit' is likely short for "Transfer Limit" and counts either a
total or per-time-slice count of how many bytes can be transferred
before we hit some kind of quota, to avoid saturating resources.

--js
