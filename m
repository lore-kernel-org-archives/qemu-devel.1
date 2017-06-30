Received: from eggs.gnu.org ([2001:4830:134:3::10]:58683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQqhM-0008Aq-GQ
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQqhJ-0006BF-Dp
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:50:40 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:35898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQqhJ-0006As-91
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:50:37 -0400
Received: by mail-qt0-x229.google.com with SMTP id i2so92750120qta.3
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 00:50:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<1498768109-4092-5-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <24372543-e6d8-b60d-140e-415bb33b0533@twiddle.net>
Date: Fri, 30 Jun 2017 00:50:33 -0700
MIME-Version: 1.0
In-Reply-To: <1498768109-4092-5-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/7] translate-all: report correct avg host
 TB size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
> +    int *size = data;

I'd really prefer you use size_t for all of these.


r~
