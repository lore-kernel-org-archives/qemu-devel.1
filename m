Received: from eggs.gnu.org ([2001:4830:134:3::10]:35524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMEdn-000089-Mg
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMEdj-0002W0-59
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:00:43 -0500
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:34173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMEdh-0002Sx-28
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:00:37 -0500
Received: by mail-it1-x141.google.com with SMTP id t189-v6so11072129itf.1
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 08:00:31 -0800 (PST)
References: <20181108175246.13416-1-richard.henderson@linaro.org>
	<20181108175246.13416-3-richard.henderson@linaro.org>
	<CAFEAcA_WJMAsHWx+OTO+j0eTsHodpXkyxLv6cAdXxgjsCmTYhw@mail.gmail.com>
	<6ace0700-23b9-d004-a5d9-6ab1bdb90835@linaro.org>
	<CAFEAcA-3yT-Tw_Q6fiioyxTF8oEJ0r+ZTKdYCg4inYgtdwcxRA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8f544b44-6400-8f85-3600-78347feb1575@linaro.org>
Date: Mon, 12 Nov 2018 17:00:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-3yT-Tw_Q6fiioyxTF8oEJ0r+ZTKdYCg4inYgtdwcxRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: Fill in ARMISARegisters
 for kvm64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11/12/18 3:34 PM, Peter Maydell wrote:
>> The other id_aa64* register fields are all extensions to v8.0, so they should
>> be zero.  I am of course assuming that AdvSIMD is present, otherwise qemu
>> itself probably have failed before now.
> 
> You don't set the id_isar* to say "AdvSIMD present" (or "VFP present"), though.

Those two are almost unique in that they are signed fields.  So 0 indicates
present and -1 indicates not present (and 1 indicates fp16 support).


r~
