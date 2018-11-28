Received: from eggs.gnu.org ([2001:4830:134:3::10]:42783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS1ps-0008CZ-MH
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS1pr-0004Zj-Df
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:33:08 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gS1pq-0004V7-MW
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:33:06 -0500
Received: by mail-ot1-x343.google.com with SMTP id 40so23877468oth.4
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 07:33:03 -0800 (PST)
MIME-Version: 1.0
References: <1543397736-8198-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1543397736-8198-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Nov 2018 15:32:51 +0000
Message-ID: <CAFEAcA8gA7_jHyZKu_SnE9YqULKvtv39RBcoAx=zdGRGSm5Tkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1?] hw/arm/aspeed: Fix build issue
 with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 28 Nov 2018 at 09:35, Thomas Huth <thuth@redhat.com> wrote:
>
> When using clang 3.4.2, compilation of QEMU fails like this:
>
>   CC      aarch64-softmmu/hw/arm/aspeed.o
> hw/arm/aspeed.c:36:3: error: redefinition of typedef 'AspeedBoardState' is a C11
>       feature [-Werror,-Wtypedef-redefinition]
> } AspeedBoardState;
>   ^
> include/hw/arm/aspeed.h:14:33: note: previous definition is here
> typedef struct AspeedBoardState AspeedBoardState;
>                                 ^
> 1 error generated.
> make[1]: *** [hw/arm/aspeed.o] Error 1
> make: *** [subdir-aarch64-softmmu] Error 2
>
> Remove the duplicated typedef to fix this issue.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Applied, thanks.

-- PMM
