Received: from eggs.gnu.org ([2001:4830:134:3::10]:49263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abenetopoulos@gmail.com>) id 1coYgu-0006wI-LV
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abenetopoulos@gmail.com>) id 1coYgr-0004Vy-MD
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:55:56 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <abenetopoulos@gmail.com>)
	id 1coYgr-0004VS-Ez
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:55:53 -0400
Received: by mail-wr0-x22d.google.com with SMTP id g10so36246154wrg.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:55:52 -0700 (PDT)
Received: from Achilles-MacBook-Pro.local ([147.102.249.65])
	by smtp.gmail.com with ESMTPSA id
	t103sm6867280wrc.43.2017.03.16.09.55.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Mar 2017 09:55:50 -0700 (PDT)
From: Achilles Benetopoulos <abenetopoulos@gmail.com>
Message-ID: <8fb8ed45-6de3-2b74-f5ea-44b374cabcbd@gmail.com>
Date: Thu, 16 Mar 2017 18:55:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Make qemu_thread_create return a flag to indicate if
 it succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am interested in working on the BiteSized Task mentioned in the
subject line. However, I have a question: Since the current behaviour
of qemu_thread_create is to fail in the case of an error, then it
seems logical to make the caller exit (in the patched version) if the
return value of the call to qemu_thread_create indicates an error. Is
this desirable? If so, how detailed should the error messages reported
be? If not, then I'm guessing that the desired behaviour is a more
graceful handling of the error on a case-by-case basis?

Achilles
