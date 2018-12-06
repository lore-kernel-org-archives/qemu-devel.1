Received: from eggs.gnu.org ([2001:4830:134:3::10]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUqhe-0007ds-Mt
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUqha-0003m6-Tr
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:16:18 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:35040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUqha-0003lu-O7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:16:14 -0500
Received: by mail-ot1-x32b.google.com with SMTP id 81so21537771otj.2
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 02:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20181206084816.30485-1-ppandit@redhat.com>
	<BN6PR18MB1220A0A33454573CA39058659FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
In-Reply-To: <BN6PR18MB1220A0A33454573CA39058659FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 10:16:02 +0000
Message-ID: <CAFEAcA_B3FNQXLP4YnL70EPoFUbM89Dh1eFdZSVzpkJrgt+j_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: li qiang <liq3ea@outlook.com>
Cc: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 6 Dec 2018 at 09:10, li qiang <liq3ea@outlook.com> wrote:
> Oh... Finally another one find this.....
>
> I've already found this. This is very a serious security issue.

If you find a security issue, we would appreciate it if
you let us know, rather than just waiting to see if
anybody else notices it...

thanks
-- PMM
