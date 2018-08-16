Received: from eggs.gnu.org ([2001:4830:134:3::10]:54292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roy@probir.info>) id 1fqOmk-0007tH-6x
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 16:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roy@probir.info>) id 1fqOme-00025R-Vr
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 16:22:21 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:33688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roy@probir.info>) id 1fqOme-00024J-CM
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 16:22:16 -0400
Received: by mail-oi0-x230.google.com with SMTP id 8-v6so10368508oip.0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 13:22:14 -0700 (PDT)
MIME-Version: 1.0
From: Probir Roy <roy@probir.info>
Date: Thu, 16 Aug 2018 15:22:13 -0500
Message-ID: <CA++5wji8hmxezOz=ccBR_hxWXNc-CjAahBKDeMrXewyAsONmJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Handling signal of Qemu thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org

I am registering a signal handler per Qemu thread (per VCPU) and
expecting to handle it in that thread context. But I never receive the
signal on the Qemu thread that is causing the event, rather the signal
is sent to parent thread context. Can you please explain the reason
behind this? I also see that Qemu has a function called
"kvm_eat_signals". Does it have to do anything with my issue?

Regards,
Probir
