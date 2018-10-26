Received: from eggs.gnu.org ([2001:4830:134:3::10]:32799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1gFtdE-0007AA-JR
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 00:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1gFtcB-00048M-RZ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 00:20:55 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:42396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rafaelkioji@gmail.com>)
	id 1gFtcB-000489-JY
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 00:20:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id f26-v6so5259171pfn.9
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 21:20:51 -0700 (PDT)
Received: from [143.89.131.93] (eepc93.ee.ust.hk. [143.89.131.93])
	by smtp.gmail.com with ESMTPSA id
	n79-v6sm15849533pfk.19.2018.10.25.21.20.49
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Oct 2018 21:20:49 -0700 (PDT)
From: "Rafael K. V. Maeda" <rafaelkioji@gmail.com>
Message-ID: <784f1213-282f-14ca-4126-145dead59a77@gmail.com>
Date: Fri, 26 Oct 2018 12:20:41 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] Guest application exit point.
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

I am implementing a plugin that allocates several resources. I need to 
cleanup some of these resources when QEMU finishes executing the guest 
application. Where is the best exit point to place my cleanup functions?

I have tried registering a function call "atexit" but it does not seem 
to work. Any suggestions? At the moment, I am looking for a solution for 
x86_64 (user emulation mode).

Kind regards,
Rafael
