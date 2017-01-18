Received: from eggs.gnu.org ([2001:4830:134:3::10]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTus6-0007J1-5k
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTus2-0001Gt-8o
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:22:10 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTus2-0001Gf-3U
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:22:06 -0500
Received: by mail-pf0-x243.google.com with SMTP id e4so1595882pfg.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 10:22:06 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-11-git-send-email-batuzovk@ispras.ru>
	<5ccf8414-c5d1-6006-b654-799cf6cd757b@twiddle.net>
	<alpine.DEB.2.11.1701181535540.1724@bulbul.intra.ispras.ru>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4a773d2d-5242-b544-7fea-657aabefa1d7@twiddle.net>
Date: Wed, 18 Jan 2017 10:22:00 -0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1701181535540.1724@bulbul.intra.ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/18] tcg/i386: add support for vector
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 01/18/2017 05:05 AM, Kirill Batuzov wrote:
>> Why are you not defining xmm8-15?
>
> At first I thought about supporting both x86_64 and i386 targets, but
> put this idea away (at least for the time being). Since defining xmm8-15
> does not contradict anything (as I see it now) I'll add them too.

Thanks.  Although (potentialy) all you need to do to support i386 is to make 
sure that TCG_TARGET_HAS_add_* are properly conditionalized on a runtime 
have_sse2 check.  There are other examples of how such runtime checks should be 
done.

(That said, I can imagine there might be other issues with respect to i64 vs 
v64 that might turn out to be complicated.  It wouldn't bother me if we 
restricted vector support to 64-bit hosts.)


r~
