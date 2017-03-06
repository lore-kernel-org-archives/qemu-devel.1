Received: from eggs.gnu.org ([2001:4830:134:3::10]:38890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckxbV-0000T2-VM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckxbS-0006SJ-39
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:43:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ckxbR-0006RZ-T7
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:43:26 -0500
Date: Tue, 7 Mar 2017 00:13:18 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <8ba0840f-43cf-601d-f0ea-3094b935c4b0@redhat.com>
Message-ID: <alpine.LFD.2.20.1703070010520.6862@wniryva>
References: <20170306071721.26708-1-ppandit@redhat.com>
	<20170306071721.26708-3-ppandit@redhat.com>
	<988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
	<alpine.LFD.2.20.1703062325370.6862@wniryva>
	<8ba0840f-43cf-601d-f0ea-3094b935c4b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: allocate heap memory
 for execve arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>

+-- On Mon, 6 Mar 2017, Eric Blake wrote --+
| If you impose any limit smaller than _SC_ARG_MAX, you are needlessly
| limiting things.  Furthermore, _SC_ARG_MAX may not always be the same
| value, depending on how the kernel was compiled.  So it's probably
| asiest to just let execve() impose its own limits (and correctly report
| errors to the caller when execve() fails), rather than trying to impose
| limits yourself.

  Okay.

| In short, the bug that you are fixing is not caused by the guest
| requesting something beyond execve() limits, but caused by poor use of
| alloca() leading to a stack overrun.

  Yes, true.

| You only need to fix the bug (by switching alloca() to heap allocation),

  Okay, I'll send just one revised patch.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
