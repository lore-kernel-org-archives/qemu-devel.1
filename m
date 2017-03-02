Received: from eggs.gnu.org ([2001:4830:134:3::10]:47734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjM2d-00057K-H0
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjM2Y-0001zw-Ck
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:24:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjM2Y-0001zd-7R
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:24:46 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 02 Mar 2017 09:24:42 +0100
Message-ID: <871sugkrw5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] New QMP command without a test -> automatic NAK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Alan Gilbert <dgilbert@redhat.com>

I hereby declare the days of adding QMP commands without tests over.

I expect these tests to cover all errors.  I know this isn't always
practical.  When you think it's not, I still expect you to explain why.

If you need assistance with writing such tests, cry for help on the list
cc'ing me.

Cc'ing people I hope will be able to help me with the NAKing.
