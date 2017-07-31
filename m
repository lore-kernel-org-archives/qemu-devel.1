Received: from eggs.gnu.org ([2001:4830:134:3::10]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dcAVa-0006ZJ-Hq
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dcAVX-0005VP-6W
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:13:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dcAVX-0005Un-00
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:13:15 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
	<1501249552-788-2-git-send-email-armbru@redhat.com>
	<000901d309ca$9ee30c00$dca92400$@ru>
Date: Mon, 31 Jul 2017 15:13:12 +0200
In-Reply-To: <000901d309ca$9ee30c00$dca92400$@ru> (Pavel Dovgalyuk's message
	of "Mon, 31 Jul 2017 09:59:57 +0300")
Message-ID: <87y3r43g2f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] replay: Define ReplayMode without QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>

"Pavel Dovgalyuk" <dovgaluk@ispras.ru> writes:

>> From: Markus Armbruster [mailto:armbru@redhat.com]
>> ReplayMode is defined in the QAPI schema, but not used there.  Of the
>> stuff QAPI generates for it only the typedef is actually used.  Use of
>> QAPI is pointless and only complicates things, so don't.
>
> This a bit useless now, but we plan to add more patches that include
> QAPI commands for controlling and inspecting the record/replay process.

I assume YAGNI until proven otherwise.

Posting patches putting ReplayMode to use could serve as proof.
