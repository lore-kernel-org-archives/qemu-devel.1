Received: from eggs.gnu.org ([2001:4830:134:3::10]:51103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXNRA-0002lQ-4O
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXNR7-0002V1-1L
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:33:12 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eXNR6-0002TX-O3
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:33:08 -0500
Received: by mail-wm0-f65.google.com with SMTP id a79so1030860wma.0
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 00:33:08 -0800 (PST)
References: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
	<446087972.818501.1515050674109.JavaMail.zimbra@oxygem.tv>
	<1548618960.818551.1515050828217.JavaMail.zimbra@oxygem.tv>
	<cb656289-97ee-d45e-cfcc-51e86b9a11ce@profihost.ag>
	<130240891.820052.1515054901352.JavaMail.zimbra@oxygem.tv>
	<671681eb-5d03-1797-4b0e-70b6e8b7b257@redhat.com>
	<b3231ee0-a232-057b-dbfe-bd31e0d4bf02@profihost.ag>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24204049-c489-df35-3775-ee5121e13f0f@redhat.com>
Date: Fri, 5 Jan 2018 09:33:04 +0100
MIME-Version: 1.0
In-Reply-To: <b3231ee0-a232-057b-dbfe-bd31e0d4bf02@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Alexandre DERUMIER <aderumier@odiso.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 04/01/2018 21:15, Stefan Priebe - Profihost AG wrote:
> attached the relevant patch for everybody who needs it.

This is the original patch from Intel, which doesn't work unless you
have a patched kernel (which you almost certainly don't have) and
doesn't even warn you about that.

In other words, it's rubbish.  Please read
https://www.qemu.org/2018/01/04/spectre/ several times, until you
understand why there is no urgent need to update QEMU.

Days are 24 hours for QEMU developers just like for you (and believe me,
we wished several times that they weren't during the last two months).
We are prioritizing the fixes according to their effect in mitigating
the vulnerability, their applicability and the availability of patches
to the lower levels of the stack.  Right now, the most urgent part is
the simple mitigations that can go in Linux 4.15 and stable kernels.

Paolo
