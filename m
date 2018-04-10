Received: from eggs.gnu.org ([2001:4830:134:3::10]:56273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5wFi-0005uM-9V
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5wFh-0003f3-Gk
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:36:14 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:37479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f5wFh-0003et-Bp
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:36:13 -0400
Received: by mail-yw0-x242.google.com with SMTP id y23so4223297ywy.4
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 09:36:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523377186-32578-5-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<1523377186-32578-5-git-send-email-cota@braap.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 10 Apr 2018 09:36:12 -0700
Message-ID: <CAMo8BfJ1xvZRq_Ue7uC=86URrH43fJ6qW5vykhD7VRVPcTbM2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/10] target/xtensa: avoid integer
 overflow in next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Tue, Apr 10, 2018 at 9:19 AM, Emilio G. Cota <cota@braap.org> wrote:
> If the PC is in the last page of the address space, next_page_start
> overflows to 0. Fix it.
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/xtensa/translate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
