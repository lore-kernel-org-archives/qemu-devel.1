Received: from eggs.gnu.org ([2001:4830:134:3::10]:46882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS8ob-0006D4-Ed
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS8oY-0006zr-CD
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:23:29 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS8oY-0006zb-6F
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:23:26 -0400
Received: by mail-qt0-x242.google.com with SMTP id w12so24948163qta.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 14:23:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170701202600.14057-1-rth@twiddle.net>
	<20170701202600.14057-3-rth@twiddle.net>
	<20170702131804.7it62euy4mah63x6@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4acd2bb1-c140-01b9-a76a-fb08c1d899cb@twiddle.net>
Date: Mon, 3 Jul 2017 14:23:21 -0700
MIME-Version: 1.0
In-Reply-To: <20170702131804.7it62euy4mah63x6@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/8] target/s390x: Implement CONVERT
 UNICODE insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, david@redhat.com

On 07/02/2017 06:18 AM, Aurelien Jarno wrote:
>> +    if (!s390_has_feat(s->insn->fac == S390_FEAT_EXTENDED_TRANSLATION_3
>> +                       ? S390_FEAT_ETF3_ENH : S390_FEAT_ETF2_ENH)) {
>> +        m3 = 0;
>> +    }
> 
> This doesn't look correct to me. The well-formedness checking is part of
> ETF3_ENH facility, for both convert unicode instructions that are part
> of the Z architecture (CU12 and CU21) and for the ones added by the ETF3
> facility (CU14 and CU24).

Quite right.


r~
