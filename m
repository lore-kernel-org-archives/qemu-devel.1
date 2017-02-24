Received: from eggs.gnu.org ([2001:4830:134:3::10]:56034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chKkB-0003Jl-Lm
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chKk7-0003et-6o
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:37:27 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1chKk6-0003cY-Vs
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:37:23 -0500
Received: by mail-wm0-x22f.google.com with SMTP id v77so21039078wmv.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 10:37:21 -0800 (PST)
References: <mailman.54661.1487925109.22739.qemu-devel@nongnu.org>
	<D18A2230-B3C1-46E9-A43E-291E5F672CBB@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <D18A2230-B3C1-46E9-A43E-291E5F672CBB@gmail.com>
Date: Fri, 24 Feb 2017 18:37:18 +0000
Message-ID: <87efynl9k1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v14 00/24] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>


G 3 <programmingkidx@gmail.com> writes:

> Hi I was wondering if your MTTCG patches have been tested with a
> PowerPC guest yet.

You would have to talk to PPC guys about the current status of MTTCG for
the PowerPC architecture. You can force it to run with -accel
tcg,thread=multi but it will likely behave weirdly if the atomic/barrier
updates haven't been made to the front end.

> Also do you have a repo someone could clone to test
> out all your patches?

Sure:

  https://github.com/stsquad/qemu/tree/mttcg/base-patches-v14

Hopefully it will get merged in the next couple of days ;-)

--
Alex Bennée
