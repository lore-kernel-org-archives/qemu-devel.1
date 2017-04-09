Received: from eggs.gnu.org ([2001:4830:134:3::10]:35091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxDey-0005n2-1d
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 10:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxDeu-0004e6-9O
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 10:17:44 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxDeu-0004bu-3a
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 10:17:40 -0400
Received: by mail-wr0-x22d.google.com with SMTP id o21so105562548wrb.2
	for <qemu-devel@nongnu.org>; Sun, 09 Apr 2017 07:17:37 -0700 (PDT)
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<AM5P194MB01294EAC74E1825F9210E04CC80C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
	<AM5P194MB012946E7708F112D8F8327E6C80C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
	<AM5P194MB0129FDB6B5EF9BD99DA02F05C80F0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <AM5P194MB0129FDB6B5EF9BD99DA02F05C80F0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
Date: Sun, 09 Apr 2017 15:17:42 +0100
Message-ID: <8737dhwtq1.fsf@linaro.org>
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
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "rth@twiddle.net" <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, G 3 <programmingkidx@gmail.com>


luigi burdo <intermediadc@hotmail.com> writes:

> Hi, on info is mttcg using an amouth of ram for cpu caching and
> translating operations like was did in past by emulators like
> virtualpc,realpc, bluelabel or softwindows?

It's a fixed buffer. You can see if it being flushed by running:

  info jit

On the QEMU monitor console.

>
> in case of yes is possible increase it from the command line?
>
> Thanks
>
> Luigi


--
Alex Bennée
