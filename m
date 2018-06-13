Received: from eggs.gnu.org ([2001:4830:134:3::10]:53724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTBUV-00089p-FA
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 15:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTBUQ-0000mp-I1
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 15:31:35 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTBUQ-0000m9-CF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 15:31:30 -0400
Received: by mail-pf0-x242.google.com with SMTP id a63-v6so1944016pfl.1
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 12:31:30 -0700 (PDT)
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-12-f4bug@amsat.org>
	<15d222dd-d2e9-4855-62c6-f89f2ee59c52@linaro.org>
	<76aa5170-1d18-8799-6ff1-a7c0dba0b489@redhat.com>
	<8537ca07-2645-6c2c-5945-a91da035b474@linaro.org>
	<a856ef80-fcab-0003-2bdd-89a1849fe857@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7c27cd3e-124c-1c03-46de-1b016b37edf1@linaro.org>
Date: Wed, 13 Jun 2018 09:31:23 -1000
MIME-Version: 1.0
In-Reply-To: <a856ef80-fcab-0003-2bdd-89a1849fe857@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/40] hw/xen: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>

On 06/13/2018 02:13 AM, Eric Blake wrote:
> Or spell it UINT64_C(1) if you don't want a cast.

Not unsigned is what I want most.


r~
