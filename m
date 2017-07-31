Received: from eggs.gnu.org ([2001:4830:134:3::10]:45170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1dcAmH-0005bh-9f
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1dcAmE-0000aV-71
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:30:33 -0400
Received: from mail.ispras.ru ([83.149.199.45]:35962)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1dcAmD-0000Zw-Nb
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:30:30 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <1501249552-788-1-git-send-email-armbru@redhat.com>	<1501249552-788-2-git-send-email-armbru@redhat.com>	<000901d309ca$9ee30c00$dca92400$@ru>
	<87y3r43g2f.fsf@dusky.pond.sub.org>
In-Reply-To: <87y3r43g2f.fsf@dusky.pond.sub.org>
Date: Mon, 31 Jul 2017 16:30:13 +0300
Message-ID: <001101d30a01$247886c0$6d699440$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH 1/3] replay: Define ReplayMode without QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Markus Armbruster' <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>

> From: Markus Armbruster [mailto:armbru@redhat.com]
> "Pavel Dovgalyuk" <dovgaluk@ispras.ru> writes:
> 
> >> From: Markus Armbruster [mailto:armbru@redhat.com]
> >> ReplayMode is defined in the QAPI schema, but not used there.  Of the
> >> stuff QAPI generates for it only the typedef is actually used.  Use of
> >> QAPI is pointless and only complicates things, so don't.
> >
> > This a bit useless now, but we plan to add more patches that include
> > QAPI commands for controlling and inspecting the record/replay process.
> 
> I assume YAGNI until proven otherwise.
> 
> Posting patches putting ReplayMode to use could serve as proof.

This is a sample of not yet included patch.

https://lists.nongnu.org/archive/html/qemu-devel/2014-07/msg04278.html

Pavel Dovgalyuk
