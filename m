Received: from eggs.gnu.org ([2001:4830:134:3::10]:52292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMygj-0005ag-TG
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMyge-0001Cb-3f
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:06:17 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:44369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMygd-0001Be-U2
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:06:12 -0500
Received: by mail-oi0-x22b.google.com with SMTP id l6so5231627oih.11
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 08:06:11 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Dec 2017 16:05:50 +0000
Message-ID: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] in a device or CPU instance init/realize,
 can I rely on something having the BQL or equivalent?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi; I'm currently writing '-cpu max' support for ARM. For that I'd
like to be able to do the "probe host kernel for its supported feature
set" in the CPU object's instance-init function, but I'd like to do
it just once and cache the answer. Can I rely on something or other
having the BQL or otherwise ensuring that two threads don't run
the instance_init method in parallel (eg in a hotplug situation),
or do I need to create and use my own mutex to protect the cached
answer data?

thanks
-- PMM
