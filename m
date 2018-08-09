Received: from eggs.gnu.org ([2001:4830:134:3::10]:55501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fno24-0007zM-0B
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fno20-00076Z-TV
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:43:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fno20-00074v-Jy
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:43:24 -0400
References: <20180809160011.17225-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
Date: Thu, 9 Aug 2018 18:43:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180809160011.17225-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>

On 09/08/2018 18:00, Peter Maydell wrote:
> The kernel's checkpatch does not enforce "leading /* on
> a line of its own, so that part is unique to QEMU's checkpatch.

Yeah, that's because for some reason the Linux network subsystem uses
the style without the lone leading "/*".  Which is actually what QEMU is
using in most of the code, I think, so...

> I'm still not used to the leeading-/*-on-it's-own style,
> so having checkpatch catch my lapses is handy...

... if it's not what we are using, why enforce it?

Paolo
