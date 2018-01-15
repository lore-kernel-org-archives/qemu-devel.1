Received: from eggs.gnu.org ([2001:4830:134:3::10]:45841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb8j3-0001Sx-RM
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb8iz-0005rr-Jp
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:39:13 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:43503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eb8iz-0005rB-Dj
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:39:09 -0500
Received: by mail-pf0-x22d.google.com with SMTP id y26so828702pfi.10
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:39:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <1515562748-32287-1-git-send-email-rth@twiddle.net>
	<CAFEAcA8TxNTjvsqeHss=7BEm6SzwLHZ54UqDmOPMWA5z0oTsUA@mail.gmail.com>
	<2706dc83-cf36-31e9-71d7-ec7ca0cecff0@linaro.org>
Message-ID: <91de5a58-7f75-213d-b5cd-09259e517f0a@linaro.org>
Date: Mon, 15 Jan 2018 09:39:04 -0800
MIME-Version: 1.0
In-Reply-To: <2706dc83-cf36-31e9-71d7-ec7ca0cecff0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/arm: Fix double-word comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 01/15/2018 09:31 AM, Richard Henderson wrote:
> But we can't *not* swap the arguments to the generated comparison.  Otherwise
> we're computing the wrong thing.

Bah.  I have of course forgotten about the RSC instruction, which takes an
immediate.  Will fix.


r~
