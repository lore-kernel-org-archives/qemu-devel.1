Received: from eggs.gnu.org ([2001:4830:134:3::10]:49061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cP3OV-0000Xi-8e
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 03:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cP3OU-0003ni-Gv
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 03:27:31 -0500
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:33016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1cP3OU-0003mg-A8
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 03:27:30 -0500
Received: by mail-lf0-x22b.google.com with SMTP id k86so30666930lfi.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 00:27:28 -0800 (PST)
MIME-Version: 1.0
From: Bob Chen <a175818323@gmail.com>
Date: Thu, 5 Jan 2017 16:27:26 +0800
Message-ID: <CAMxP3BTmayVS5VHYm6iXgZFetiv8YAPnyd_1-6p_q33gDLTrEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Live migration + cpu/mem hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

According to the docs, the destination Qemu must have the exactly same
parameters as the source one. So if the source has just finished cpu or
memory hotplug, what would the dest's parameters be like?

Does DIMM device, or logically QOM object, have to be reflected on the new
command-line parameters?



Regards, Bob
