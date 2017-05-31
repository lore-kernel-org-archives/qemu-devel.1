Received: from eggs.gnu.org ([2001:4830:134:3::10]:41147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihai.dontu@gmail.com>) id 1dG7k0-0000MK-TA
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihai.dontu@gmail.com>) id 1dG7jw-0003yE-1u
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:49:04 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mihai.dontu@gmail.com>)
	id 1dG7jv-0003xR-RV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:48:59 -0400
Received: by mail-wm0-x233.google.com with SMTP id d127so29314786wmf.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 10:48:58 -0700 (PDT)
Message-ID: <1496252935.14809.59.camel@gmail.com>
From: Mihai =?UTF-8?Q?Don=C8=9Bu?= <mihai.dontu@gmail.com>
Date: Wed, 31 May 2017 20:48:55 +0300
In-Reply-To: <CAEB0U7On7OPAytSMjx94pfMKswuEzrty87Asz_9TYV_wrc4p4w@mail.gmail.com>
References: <CAEB0U7On7OPAytSMjx94pfMKswuEzrty87Asz_9TYV_wrc4p4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Doubts about Kvm architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Maur=EDcio?= Almeida <malmeida@inf.ufsm.br>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Wed, 2017-05-31 at 14:09 -0300, Maurício Almeida wrote:
> My name is Maurício, we are making a study about Kvm Paravirtualized
> and Full virtualized at our University, we are from University Federal
> of Santa Maria.
> Can you give us some papers about how the Kvm or Qemu executes the I/O
> Network with one emulated Device?
> 
> We executed some tests using Virtio Driver and e1000 emulated driver,
> the network output of Virtio is normal and use four of the four
> Machine Cpu's, but the output of e1000 Emulated driver was too low
> about Virtio and It onlyused one of the four machine cpu's during the
> network test execution.
> The Traffic of Virtio was 956 MB/s while e1000 Emulated Driver was 192
> MB/s, both using Packet size of 1518 Bytes.
> 
> Why when it used e1000 Emulated Driver the traffic was to low and use
> only one Cpu all the time?
> Do Qemu or Kvm Guest need some specific configuration to use all CPU's?
> 
> Do you have any paper where we can find in details if Qemu is limited
> to use one CPU when use Network Emulated Driver?

A cursory look over the qemu e1000 driver would suggest that it does
not support multithreading. virtio largely bypasses the qemu hw
machinery.

-- 
Mihai Donțu
