Received: from eggs.gnu.org ([2001:4830:134:3::10]:51570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLc2N-0006W0-8N
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLc2I-0000Vp-1z
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:10:43 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:34829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLc2H-0000Vg-Sw
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:10:37 -0400
Received: by mail-qt0-x22c.google.com with SMTP id w1so37434225qtg.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 14:10:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170615055356.20684-1-rth@twiddle.net>
	<20170615055356.20684-6-rth@twiddle.net>
	<20170615204908.3izswcs4q6l34wrg@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a1abdb2d-68c0-74d1-cb32-9ceb5c879151@twiddle.net>
Date: Thu, 15 Jun 2017 14:10:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170615204908.3izswcs4q6l34wrg@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] target/s390x: mark CSST, CSST2,
 FPSEH facilities as available
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

On 06/15/2017 01:49 PM, Aurelien Jarno wrote:
>> +        S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
> 
> Theoretically the floating-point-support-enhancement facilities include
> the DFP rounding facility. Given We don't implement the DFP facility I
> guess this can be ignored.

We *do* implement the one instruction in DFP-rounding-facility: SRNMT.


r~
