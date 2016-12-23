Received: from eggs.gnu.org ([2001:4830:134:3::10]:43802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cKLFN-0005SA-7z
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 03:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cKLFJ-0004dS-VM
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 03:30:37 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cKLFJ-0004d5-P3
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 03:30:33 -0500
Received: by mail-wj0-f194.google.com with SMTP id hb5so6012594wjc.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 00:30:33 -0800 (PST)
References: <585c0f59.2350c20a.e5711.e639@mx.google.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <6897002c-9618-ba6b-3d42-8595bb13ac09@tuxfamily.org>
Date: Fri, 23 Dec 2016 09:30:30 +0100
MIME-Version: 1.0
In-Reply-To: <585c0f59.2350c20a.e5711.e639@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] virus in colibriOS QEMU iso?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vilcadam@gmail.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kashyap Chamarthy <kashyapc@fedoraproject.org>

On 22.12.2016 18:37, vilcadam@gmail.com wrote:
> Hi, just letting you know that Avira found some crypto-locker virus in ColibriOS iso that you featured in QEMU Advent Calendar 2016. Maybe you should look into that. I am not sure if it’s a false positive or not.. You can check the attachment for a screenshot  of the result.

That sounds ugly ... I think we just packaged the .iso from the official
KolibriOS website here (Kashyap, can you confirm?), so if this is not
just a false positive, the problem very likely comes from there.
If you've got some spare minutes, could you maybe check the download
from http://kolibrios.org/en/download , too?

As far as I can see, there should not be any real danger here unless you
put the .iso file onto a real CD-ROM or USB stick and start the .exe
files in there (which is of course not necessary for starting a VM with
the .iso file). But anyway, this needs some closer investigation, to see
whether it's a false positive or not, so I've disabled that download for
now. We'll let you know when we know more ... Thanks for reporting the
issue!

 Thomas
