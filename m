Received: from eggs.gnu.org ([2001:4830:134:3::10]:49630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHU1n-00006A-Fy
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHU1i-0007zF-H4
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:25:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHU1i-0007ti-A0
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:25:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so4375903wrb.13
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:25:37 -0700 (PDT)
References: <20181026073034.16648-1-ppandit@redhat.com>
	<CAFEAcA_WduaLJZG-gu9oywCaUb2mR9DeBJ9WKqsTkKu4uGT7Uw@mail.gmail.com>
	<nycvar.YSQ.7.76.1810301716590.30516@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f15fc5de-43ff-0178-f4da-559b5008fdce@redhat.com>
Date: Tue, 30 Oct 2018 14:25:33 +0100
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1810301716590.30516@xnncv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] strongarm: mask off high[32:28] bits
 from dir and state registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: liqsub1 <liqsub1@163.com>, Qemu Developers <qemu-devel@nongnu.org>, Moguofang <moguofang@huawei.com>

On 30/10/18 12:49, P J P wrote:
> +-- On Mon, 29 Oct 2018, Peter Maydell wrote --+
> | >      switch (offset) {
> | >      case GPDR:        /* GPIO Pin-Direction registers */
> | > -        s->dir = value;
> | > +        s->dir = value & 0x3fffff;
> |
> | The commit message says it's masking [31:28], but the
> | code is masking [31:22]. The SA1110 spec suggests the
> | commit message is correct and the code is not.
> 
> Ouch, sorry! Sent revised patch v3.

That's where the extract32() is more convenient and less bug prone:

                s->dir = extract32(value, 0, 28); /* mask off [31:28] */
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
> 
