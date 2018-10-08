Received: from eggs.gnu.org ([2001:4830:134:3::10]:34686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9PAI-0003Y2-7i
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9PAE-00068D-8I
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:37:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g9PAE-00067p-0O
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:37:10 -0400
References: <1538756242-54922-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c44ae171-cce9-851e-3495-7e4170c3244b@redhat.com>
Date: Mon, 8 Oct 2018 08:37:05 +0200
MIME-Version: 1.0
In-Reply-To: <1538756242-54922-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: remove gcov-files- variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2018-10-05 18:17, Paolo Bonzini wrote:
> Commit 31d2dda ("build-system: remove per-test GCOV reporting", 2018-06-20)
> removed users of the variables, since those uses can be replaced by a simple
> overall report produced by gcovr.  However, the variables were never removed.
> Do it now.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/testing.rst |   4 +-
>  tests/Makefile.include | 118 -------------------------------------------------
>  2 files changed, 1 insertion(+), 121 deletions(-)

Good idea, I think these variables were pretty much out of sync anyway.

Acked-by: Thomas Huth <thuth@redhat.com>
