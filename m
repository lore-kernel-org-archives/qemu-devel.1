Received: from eggs.gnu.org ([2001:4830:134:3::10]:46425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCnh-0006by-Ni
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCnd-0000xK-Oy
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:12:25 -0500
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:44164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCnd-0000wr-Kv
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:12:21 -0500
Received: by mail-qt0-x22b.google.com with SMTP id m59so31480915qte.11
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:12:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180118123219.19410-1-f4bug@amsat.org>
	<20180118123219.19410-7-f4bug@amsat.org>
	<16165fc9-6593-8ee9-1dd9-a28400876e66@amsat.org>
	<6dc16a38-1b4a-91f9-a68c-e216cbe279fe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8467d651-4124-8657-0cf8-301ef9aa5dd3@amsat.org>
Date: Thu, 18 Jan 2018 13:12:16 -0300
MIME-Version: 1.0
In-Reply-To: <6dc16a38-1b4a-91f9-a68c-e216cbe279fe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 06/16] sdhci: add
 init_readonly_registers() to initialize the CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On 01/18/2018 01:00 PM, Paolo Bonzini wrote:
> On 18/01/2018 16:44, Philippe Mathieu-Daudé wrote:
>>>  static void sdhci_common_realize(SDHCIState *s, Error **errp)
>>>  {
>>> +    sdhci_init_readonly_registers(s, errp);
>>> +    if (errp && *errp) {
>> Paolo said this is wrong (as in bad pattern?).
>>
>> I will respin probably using 'bool sdhci_init_readonly_registers()' instead.
>>
> 
> Please use the local_err idiom instead.

Will do, thanks!

Phil.
