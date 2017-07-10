Received: from eggs.gnu.org ([2001:4830:134:3::10]:52292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUXR5-0005A0-Lb
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUXR2-0004kf-Gv
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:05:07 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUXR2-0004kJ-Ax
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:05:04 -0400
Received: by mail-wr0-f171.google.com with SMTP id 77so135799128wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 05:05:04 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-22-git-send-email-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e69fe832-f4e8-f59d-e0dd-3472f498c04e@redhat.com>
Date: Mon, 10 Jul 2017 14:05:01 +0200
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-22-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/22] tcg: enable per-thread TCG for
 softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 09/07/2017 09:50, Emilio G. Cota wrote:
> User-mode is kept out of this: contention due to concurrent translation
> is more commonly found in full-system mode.

Out of curiosity, is it harder or you just didn't try?  It would be nice
if the commit message mentioned the problems (if any) in addition to the
reason why you didn't do it.

Having similar policies for user and softmmu emulation is much more
maintainable (for an earlier example, see the unification of user mode
emulation's start/end_exclusive logic with softmmu's "safe work").

Paolo
