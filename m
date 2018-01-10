Received: from eggs.gnu.org ([2001:4830:134:3::10]:50404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZ4SY-0000rN-DD
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZ4SV-0002mQ-Dj
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:41:38 -0500
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:32964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZ4SV-0002jj-88
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:41:35 -0500
Received: by mail-pg0-x234.google.com with SMTP id i196so9403331pgd.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 16:41:34 -0800 (PST)
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b4c43cc-4ef6-b1e7-e55d-497fd9c08a8b@linaro.org>
Date: Tue, 9 Jan 2018 16:41:30 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: surajjs@au1.ibm.com, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 01/09/2018 07:15 AM, Peter Maydell wrote:
> (This is a build for arm32, running in a chroot on an aarch64
> box, non-debug build.)

It's an arm backend problem.

For 64-bit setcond2, we do

0x6e5c3fa4:  e1570008  cmp      r7, r8
0x6e5c3fa8:  01550004  cmpeq    r5, r4
0x6e5c3fac:  b3a09001  movlt    sb, #1
0x6e5c3fb0:  a3a09000  movge    sb, #0

which looks good, but only works for LTU not LT.

I'll work on a fix.


r~
