Received: from eggs.gnu.org ([2001:4830:134:3::10]:37564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naftaly.avadiaev@gmail.com>) id 1d0cGH-0000oC-FR
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 19:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naftaly.avadiaev@gmail.com>) id 1d0cGE-0001Yq-B0
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 19:10:17 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naftaly.avadiaev@gmail.com>)
	id 1d0cGE-0001Yd-16
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 19:10:14 -0400
Received: by mail-wr0-x234.google.com with SMTP id l28so4487712wre.0
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 16:10:13 -0700 (PDT)
Received: from m5510 (bzq-109-66-9-25.red.bezeqint.net. [109.66.9.25])
	by smtp.gmail.com with ESMTPSA id r4sm714809wra.69.2017.04.18.16.10.11
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 18 Apr 2017 16:10:11 -0700 (PDT)
From: "Naftaly Avadiaev" <naftaly.avadiaev@gmail.com>
Date: Wed, 19 Apr 2017 02:10:10 +0300
Message-ID: <000001d2b898$eed2d520$cc787f60$@gmail.com>
MIME-Version: 1.0
Content-Language: en-us
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Simulating Soft Error with MCE Injection method
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

 

QEMU has a build in mechanism for MCE injection. 

However the mechanism is not perfect, QEMU just fills MCA registers with
partial data and then triggers MCE.

I want to add a real corruption before triggering MCE.

The first thing which I tried is to add all MSRs as described in Intel
Software Developer's Manual [now qemu implements 3 of 4 general status
registers and 4 of 5 error reporting registers in a bank], however it seems
that the guest OS is still not aware of the new registers that I have add.

I did the following: 

1. Added the MSRs in CPUX86State. 

2. Added support for reading the new MSRs in helper_rdmsr & helper_wrmsr.

Why the guest OS still unaware of these MSRs?

I also tried to corrupt the EIP before triggering MCE, but the guest OS just
crashed without arriving to MCE handler.

In my understanding the MCE handler is exactly to deal with such errors.
What I'm I missing?

 

Thanks,

Naftaly
