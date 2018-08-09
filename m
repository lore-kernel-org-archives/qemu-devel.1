Received: from eggs.gnu.org ([2001:4830:134:3::10]:54690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnkyU-0002rP-4S
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnkyQ-00050P-SX
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:27:34 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:43531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fnkyQ-000502-L7
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:27:30 -0400
Received: by mail-ed1-x529.google.com with SMTP id j21-v6so2858647edp.10
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 06:27:30 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-6-e.emanuelegiuseppe@gmail.com>
	<f5a3c33f-f459-806c-1465-3b5415a5ccc1@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <a848be63-1cde-3fe4-ad6a-5d56104f5590@gmail.com>
Date: Thu, 9 Aug 2018 15:27:28 +0200
MIME-Version: 1.0
In-Reply-To: <f5a3c33f-f459-806c-1465-3b5415a5ccc1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 05/34] tests/qgraph: sdhci driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>


>> +{
>> +    QSDHCI_PCI *spci = (QSDHCI_PCI *)obj;
>> +    qpci_device_enable(&spci->dev);
>> +}
>> +
>> +static void sdhci_destroy(QOSGraphObject *obj)
> "sdhci_pci_destructor()"?
In general, I called the constructor name  *_create, so in theory to 
keep it consistent the destructor should be *_destroy, no?

Thank you,
Emanuele
