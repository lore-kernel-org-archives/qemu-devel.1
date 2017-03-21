Received: from eggs.gnu.org ([2001:4830:134:3::10]:52867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqHNQ-0005yW-TA
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqHNQ-0000kc-3K
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:50:56 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:33289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqHNP-0000jG-FV
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:50:55 -0400
Received: by mail-wm0-x235.google.com with SMTP id v203so2075425wmg.0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 03:50:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490091581-21912-1-git-send-email-maozy.fnst@cn.fujitsu.com>
References: <1490091581-21912-1-git-send-email-maozy.fnst@cn.fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 10:50:33 +0000
Message-ID: <CAFEAcA-voeh7zLHEugB8chErQ2y1OsdMZgvuAKrpb26qg8Dffw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] elfload: Replace malloc with g_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 21 March 2017 at 10:19, Mao Zhongyi <maozy.fnst@cn.fujitsu.com> wrote:
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  bsd-user/elfload.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Thanks for this patch. How have you tested it? (You'd need to be
on a BSD host system to test). I ask because bsd-user is currently
not really maintained, and so I'm a bit reluctant to take cleanup
patches to code we aren't building and testing.

thanks
-- PMM
