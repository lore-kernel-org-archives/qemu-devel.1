Received: from eggs.gnu.org ([2001:4830:134:3::10]:57690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1d2gvp-0005Qj-7M
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1d2gvm-00031s-4I
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:45 -0400
Received: from mout.web.de ([212.227.15.14]:56910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gm.ijewski@web.de>) id 1d2gvl-00031P-QG
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:42 -0400
References: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
	<20170424125016.GM20809@redhat.com>
	<CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
	<20170424133624.GP20809@redhat.com>
	<CAFEAcA_LrsgToPR842redVqG7VnntTdg2ANgkDpnFAWiEqQVVw@mail.gmail.com>
	<20170424135749.GR20809@redhat.com>
	<CAFEAcA8YyeQ3NOGQkr8xVZ9S5F7RmdeDwcRkLGSyNci3hf4OCw@mail.gmail.com>
	<20170424154117.GB7705@redhat.com>
	<CAFEAcA8noBf9VCZ+n24NMqVKGZC9D7KKMhLoacNyEA=WJ39uAg@mail.gmail.com>
	<20170424155255.GD7705@redhat.com>
From: Geert Martin Ijewski <gm.ijewski@web.de>
Message-ID: <f92490f5-a09c-0f11-4ea5-f09969f78870@web.de>
Date: Mon, 24 Apr 2017 18:33:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170424155255.GD7705@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] error: qcrypto_random_bytes() tried to read from
 /dev/[u]random, even on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

 > We can have the existing qcrypto_init() call a qcrypto_random_init()
 > method to do the one-time initialization task, since that's already
 > required to run early in order to initialize gnutls when we use it.

Wouldn't it make sense to also move the unix initalization to that function?

And what about deinitalization? Though because that handle needs to stay 
valid throughout the whole lifetime of QEMU anyway, that probably can be 
ignored and taken care of by the OS

Regards,
Geert
