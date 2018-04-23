Received: from eggs.gnu.org ([2001:4830:134:3::10]:46868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <omer@kazuar-tech.com>) id 1fAd7C-0005Fo-10
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <omer@kazuar-tech.com>) id 1fAd77-0002kq-RY
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:10:49 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:46062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <omer@kazuar-tech.com>)
	id 1fAd77-0002j7-Gk
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:10:45 -0400
Received: by mail-lf0-x22a.google.com with SMTP id q5-v6so15495289lff.12
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 08:10:45 -0700 (PDT)
MIME-Version: 1.0
From: Omer Katz <omer@kazuar-tech.com>
Date: Mon, 23 Apr 2018 15:10:32 +0000
Message-ID: <CAA-pg_qXZLDEHq6jMN_4GUrFvQgf0AS8Fs559JbucptK6_zrFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Filtering files passing through MTP devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi everyone,

We have a use case that requires us to only allow certain files to pass
through to the guest machine from USB storage devices.

I was told on IRC that such a feature does not exist but the easiest way to
achieve our goal is to contribute a patch the the MTP device driver since
other drivers operate on a filesystem level instead of a file level which
is what we need.

The plan is to pass the contents of each file to a program through stdin
and decide based on the exit code if the file should be allowed to pass
through to the guest or not.

Since this is the first time I'm contributing to QEMU I'd like some
guidance to where the filtering code should be.
https://github.com/qemu/qemu/blob/master/hw/usb/dev-mtp.c doesn't look that
complicated but I still need to understand it better to continue.
Furthermore, I need to know where to add such a command line option to
point QEMU to the filtering program.

Would such a patch be accepted if all the requirements above are met?

Best Regards,
Omer Katz.
