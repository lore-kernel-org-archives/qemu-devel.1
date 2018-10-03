Received: from eggs.gnu.org ([2001:4830:134:3::10]:54783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g7kMj-0005ZN-KJ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 12:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g7kMi-0001aw-C7
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 12:51:13 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:37080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1g7kMh-0001VK-IB
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 12:51:12 -0400
Received: by mail-ed1-x52c.google.com with SMTP id c22-v6so5987845edc.4
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 09:51:10 -0700 (PDT)
MIME-Version: 1.0
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 3 Oct 2018 19:50:58 +0300
Message-ID: <CAKPgXcHEVrW7a5WqcoPn6X8=-j07K3yvXo4sjYJKNonYd2asQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Hi all,

I am trying to get the hotplug handler of a pci device in Qemu using
"qdev_get_hotplug_handler" function. This function simply tries to get
the hotplug handler from the parent bus. For some reason it's always
null. Why it is not initialized?

Thanks!
