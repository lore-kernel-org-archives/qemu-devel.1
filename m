Received: from eggs.gnu.org ([2001:4830:134:3::10]:48303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0rFy-0000s0-TH
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0rFu-00076W-JU
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:15:30 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:36458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0rFu-00076J-Er
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:15:26 -0400
Received: by mail-qk0-x22c.google.com with SMTP id o205so11260267qke.3
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:15:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4502cb42-45cc-26b0-7101-3587345c32c6@amsat.org>
Date: Tue, 27 Mar 2018 13:15:23 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] correct path for qemu-*-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi Thomas,

<th_huth> is there are reason that qemu-bridge-helper is installed into
$libexecdir but qemu-pr-helper is rather installed into $bindir instead?

I'm not familiar with these utilities, but my understanding is $bindir
is for user executable binaries.

These helpers aren't expected to be started directly by user but by
daemon/systemd, so both would belong to $libexecdir.

Regards,

Phil.
