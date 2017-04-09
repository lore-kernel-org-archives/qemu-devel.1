Received: from eggs.gnu.org ([2001:4830:134:3::10]:36499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxDoP-0008JI-19
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 10:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxDoL-0007cK-3E
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 10:27:29 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxDoK-0007c5-TM
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 10:27:25 -0400
Received: by mail-wm0-x22c.google.com with SMTP id t189so20801507wmt.1
	for <qemu-devel@nongnu.org>; Sun, 09 Apr 2017 07:27:24 -0700 (PDT)
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<20170408065107.GG27571@umbus>
	<AM5P194MB01292723DDB978AC78F8FDD7C80E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <AM5P194MB01292723DDB978AC78F8FDD7C80E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
Date: Sun, 09 Apr 2017 15:27:29 +0100
Message-ID: <871st1wt9q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "programmingkidx@gmail.com" <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>


luigi burdo <intermediadc@hotmail.com> writes:

> Hi David and Nikuji,
>
> can i suggest to remove the message:
>
>
> Guest not yet converted to MTTCG - you may get unexpected results
> where the mttcg is enabled?

Have you declared the memory ordering for the guest?

>
> another thing im finding  is this message
> Guest expects a stronger memory ordering than the host provides
> This may cause strange/hard to debug errors

See ca759f9e387db87e1719911f019bc60c74be9ed8 for an example.

>
>
> I have 8 gb on my machine and this message come if i gave 512mb on the guest too.
>
> Is possible know where the mttcg is already enabled?
>
> i see on x86,i386,arm too if i set thread=multy the qemu start using the other host cores is on this guest system enabled?
>
> if yes i have the same messages of ppc64 too :
>
> Guest not yet converted to MTTCG - you may get unexpected results
>
> and
>
> Guest expects a stronger memory ordering than the host provides
> This may cause strange/hard to debug errors
>
>
> Ciao
>
> Luigi
>
>
> Applied to ppc-for-2.10.  Anyone object to that for 2/3, which isn't
> within ppc code?


--
Alex Bennée
