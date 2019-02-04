Received: from eggs.gnu.org ([209.51.188.92]:44297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqbud-0004ga-Bf
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqbub-0000ZI-Qb
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:55:39 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqbub-0000Wh-BS
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:55:37 -0500
Received: by mail-wr1-x434.google.com with SMTP id t27so13848992wra.6
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 02:55:35 -0800 (PST)
References: <1549266858-5043-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <61f149b0-0b67-c692-df9e-5f4c9a5e561c@linaro.org>
Date: Mon, 4 Feb 2019 10:55:30 +0000
MIME-Version: 1.0
In-Reply-To: <1549266858-5043-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/moxie: Fix LGPL information in the
 file headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Anthony Green <green@moxielogic.com>

On 2/4/19 7:54 AM, Thomas Huth wrote:
> It's either "GNU *Library* General Public License version 2" or "GNU
> Lesser General Public License version *2.1*", but there was no "version
> 2.0" of the "Lesser" license. So assume that version 2.1 is meant here.
> Also the files mentioned the GPL instead of the LGPL after declaring
> that the files are licensed under the LGPL, so change these spots to
> use LGPL, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/moxie/cpu.c       | 2 +-
>  target/moxie/cpu.h       | 4 ++--
>  target/moxie/helper.c    | 4 ++--
>  target/moxie/mmu.c       | 4 ++--
>  target/moxie/translate.c | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
