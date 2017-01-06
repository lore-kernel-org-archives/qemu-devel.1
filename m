Received: from eggs.gnu.org ([2001:4830:134:3::10]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPZ9S-0007uD-HM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPZ9N-000107-Hf
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:22:06 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cPZ9N-0000zl-AY
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:22:01 -0500
References: <20170102211110.4801-1-jcd@tribudubois.net>
	<CAFEAcA_qPjjZijzL5L29tw6JQ+82od3wB959oPK-r=US65Bb9w@mail.gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <8a0e0b95-a05f-6020-2603-7bf0fc0f7075@tribudubois.net>
Date: Fri, 6 Jan 2017 19:21:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qPjjZijzL5L29tw6JQ+82od3wB959oPK-r=US65Bb9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] [i.MX] Remove MSGDATA register support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marcin_Krzemi=c5=84ski?= <mar.krzeminski@gmail.com>

Le 06/01/2017 à 16:11, Peter Maydell a écrit :
>> +    case ECSPI_MSGDATA:
>> +        /* it is not clear from the spec what MSGDATA is for */
>> +        /* Anyway it is not used by Linux driver */
>> +        /* So for now we just ignore it */
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "[%s]%s: Trying to write to MSGDATA, ignoring\n",
>> +                      TYPE_IMX_SPI, __func__);
>> +        break;
> This should be LOG_UNIMP, not LOG_GUEST_ERROR.

OK

>
> thanks
> -- PMM
>
