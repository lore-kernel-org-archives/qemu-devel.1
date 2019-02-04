Received: from eggs.gnu.org ([209.51.188.92]:50319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gqh2J-0007rF-5w
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gqgoO-0002ap-Er
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:09:33 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gqgoO-0002U3-0Y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:09:32 -0500
Date: Mon, 4 Feb 2019 11:09:12 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190204160912.GA27413@flamenco>
References: <1549294992-46543-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549294992-46543-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] queue: fix QTAILQ_FOREACH_REVERSE_SAFE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Richard Henderson <richard.henderson@linaro.org>

On Mon, Feb 04, 2019 at 16:43:12 +0100, Paolo Bonzini wrote:
> The iteration was stopping as soon as prev_var was set to NULL, and
> therefore it skipped the first element.  Fortunately, or unfortunately,
> we have only one use of QTAILQ_FOREACH_REVERSE_SAFE.  Thus this only
> showed up as incorrect register preferences on the very first translation
> block that was compiled.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
