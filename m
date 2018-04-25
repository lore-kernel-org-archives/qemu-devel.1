Received: from eggs.gnu.org ([2001:4830:134:3::10]:37226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBD6q-00088g-Ad
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBD6n-0008Cs-7Q
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:36:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBD6n-0008Bu-20
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1E23406C742
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 05:36:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0cb6d53c-551c-4c2c-d524-c37c4bdcfd0e@redhat.com>
Date: Wed, 25 Apr 2018 07:36:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU monitor banner printed multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

 Hi,

I just noticed that sometimes, the QEMU monitor banner is printed
multiple times when you press "CTRL-a c" to enter the monitor:

$ x86_64-softmmu/qemu-system-x86_64 -no-shutdown -nographic \
    -nodefaults -virtioconsole mon:stdio
QEMU 2.12.0 monitor - type 'help' for more information
QEMU 2.12.0 monitor - type 'help' for more information
QEMU 2.12.0 monitor - type 'help' for more information
QEMU 2.12.0 monitor - type 'help' for more information
(qemu) q
QEMU 2.12.0 monitor - type 'help' for more information
(qemu)
$

That looks quite ugly. Anybody got an idea how to fix this?

 Thomas
