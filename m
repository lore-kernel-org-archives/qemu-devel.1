Received: from eggs.gnu.org ([2001:4830:134:3::10]:60488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cda6j-0002XV-70
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cda6i-0003g3-2x
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:13:13 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cda6h-0003fW-Sb
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:13:11 -0500
Received: by mail-wm0-x231.google.com with SMTP id v77so13223909wmv.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 02:13:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170214062242.26124-1-ppandit@redhat.com>
References: <20170214062242.26124-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 10:12:50 +0000
Message-ID: <CAFEAcA-cnpn321oTvxPXAx55ngztojr=Q6KKTEcgKTvfDV8f8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4] sd: sdhci: mask transfer mode register
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 14 February 2017 at 06:22, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> In SDHCI protocol, the transfer mode register is defined
> to be of 6 bits. Mask its value with '0x0037' so that an
> invalid value could not be assigned.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

What has happened to the other patches that were in this
patchset in v3 ?

thanks
-- PMM
