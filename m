Received: from eggs.gnu.org ([2001:4830:134:3::10]:35214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f6j4y-0005zA-PH
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f6j4v-00065e-O7
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:44:24 -0400
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f6j4v-00065K-IF
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:44:21 -0400
Received: by mail-pl0-x236.google.com with SMTP id w12-v6so3784816plp.0
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 13:44:21 -0700 (PDT)
References: <222EDB99-2ED5-4CCB-B550-7A02BC4BDC7F@psware.com>
	<c8484d2f-bc72-5e6d-d0a2-d3900a4b25ae@linaro.org>
	<09D6C852-DF1C-4179-B5D6-D2FDEBA9FE0D@psware.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <63066734-c597-1a2e-6bcd-2820d8a41c6c@linaro.org>
Date: Thu, 12 Apr 2018 10:44:15 -1000
MIME-Version: 1.0
In-Reply-To: <09D6C852-DF1C-4179-B5D6-D2FDEBA9FE0D@psware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Bad icount read when running qemu-system-ppc64 and
 mfspr atbu guest instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Darrell Leinwand <darrell.leinwand@psware.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 04/11/2018 04:37 PM, Darrell Leinwand wrote:
> Ah I see, that makes sense and the atb instructions are marked as unused in
the mainline which when I compared I recall now that we modifed them because
the guest software we are running is trying to use those special registers.
> 
> I added the wrappers into those function, is that correct?

Yes.


r~
