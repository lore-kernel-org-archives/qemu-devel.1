Received: from eggs.gnu.org ([209.51.188.92]:52087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1Vgp-00062x-Kh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1Vgo-0006HL-Is
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:30:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h1Vgk-0005vh-Ov
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:30:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93F3730EBE6E
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 12:30:12 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <32ad1a44-5398-53de-9adf-9e6ac9f60805@redhat.com>
Date: Wed, 6 Mar 2019 13:30:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] recursive submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi,

in order to build any OVMF platform firmware image from the submodule at
"roms/edk2", the (recursive) OpenSSL submodule at
"roms/edk2/CryptoPkg/Library/OpensslLib/openssl" needs to be initialized
as well.

Am I right to think this would be the first recursive submodule in QEMU?
How should I approach this? (I see we have a related script at
"scripts/git-submodule.sh".)

Thanks,
Laszlo
