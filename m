Received: from eggs.gnu.org ([2001:4830:134:3::10]:58119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1cyIYa-000475-6E
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1cyIYZ-0001L8-2M
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:43:36 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:36196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1cyIYY-0001L1-Sx
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:43:34 -0400
Received: by mail-qk0-x22c.google.com with SMTP id d131so23234567qkc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 06:43:34 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Wed, 12 Apr 2017 18:13:33 +0430
Message-ID: <CAGKXQyfCwbZ3w1bi=TVeSH=ZGx-90JBf+Bn6qqMdkUZTOoWAow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] sleeping in vm live migration code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi
why we have below code in vm live migration?
  * g_usleep((initial_time + BUFFER_DELAY - current_time)*1000);*
thanks a lot
