Received: from eggs.gnu.org ([2001:4830:134:3::10]:58526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsBA3-0001YW-Py
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsBA1-0007UT-3F
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:09:15 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:46716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsBA0-0007TD-T9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:09:13 -0400
Received: by mail-pf0-x235.google.com with SMTP id e199so1194469pfh.3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:09:12 -0700 (PDT)
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506083546.19604.543091497330269756.stgit@frigg.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <169db8d7-fe49-05c4-aca7-ad818b12c9c5@linaro.org>
Date: Wed, 13 Sep 2017 10:09:09 -0700
MIME-Version: 1.0
In-Reply-To: <150506083546.19604.543091497330269756.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/7] tcg: Add support for "inlining"
 regions of code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On 09/10/2017 09:27 AM, Lluís Vilanova wrote:
> TCG BBLs and instructions have multiple exit points from where to raise
> tracing events, but some of the necessary information in the generic
> disassembly infrastructure is not available until after generating these
> exit points.
> 
> This patch adds support for "inline points" (where the tracing code will
> be placed), and "inline regions" (which identify the TCG code that must
> be inlined). The TCG compiler will basically copy each inline region to
> any inline points that reference it.

I am not keen on this.

Is there a reason you can't just emit the tracing code at the appropriate place
to begin with?  Perhaps I have to wait to see how this is used...


r~
