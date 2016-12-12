Received: from eggs.gnu.org ([2001:4830:134:3::10]:33258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cGMdd-0000QT-SJ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 04:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cGMdc-0004cN-Ce
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 04:11:13 -0500
Received: from lists.cendio.se ([2a00:801:107:f000::b]:57368
	helo=mail.cendio.se)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ossman@cendio.se>) id 1cGMdc-0004bm-6e
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 04:11:12 -0500
Received: from ossman.lkpg.cendio.se (unknown
	[IPv6:2a00:801:107:4700:92b1:1cff:fe97:f932])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.cendio.se (Postfix) with ESMTPSA id 3904EC0A4AEC
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:11:07 +0100 (CET)
References: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
From: Pierre Ossman <ossman@cendio.se>
Message-ID: <27705b01-d582-d155-4490-15522258c3ef@cendio.se>
Date: Mon, 12 Dec 2016 10:11:07 +0100
MIME-Version: 1.0
In-Reply-To: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] VNC LED state buggy, interop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 10/12/16 16:30, Pierre Ossman wrote:
>
> There are two ways to fix this:
>
>  a) Send an update to the client when the assumption doesn't hold. This
> will most likely be difficult in your case since there is no definite
> point where you can assume a LED change event should have occurred.
>
>  b) Remove the assumption from the code and the protocol.
>
> My vote is for b). Assumptions and side effects are rarely a good idea.
> The downside though is that it will break compatibility with older
> versions of QEMU.
>

Follow-up: Reading the initial proposal, it does indeed seem that b) was=20
the intended behaviour:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg165162.html

Regards
--=20
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Link=C3=B6ping        https://facebook.com/ThinLinc
Phone: +46-13-214600    https://plus.google.com/+CendioThinLinc

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
