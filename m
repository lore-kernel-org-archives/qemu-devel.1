Received: from eggs.gnu.org ([2001:4830:134:3::10]:37499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cl2n8-0006KY-Ed
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 19:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cl2n7-0005g3-OA
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 19:15:50 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:33639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cl2n7-0005fx-Ik
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 19:15:49 -0500
Received: by mail-yw0-x241.google.com with SMTP id p77so5149293ywg.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 16:15:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170302195337.31558-9-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-9-alex.bennee@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 6 Mar 2017 16:15:48 -0800
Message-ID: <CAMo8BfK3haFRhywjF9svgSa-ZZw6r7tKLEkh0F+Vvhg3kojPjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] target/xtensa: hold BQL for
 interrupt processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, mttcg@listserver.greensocs.com, Frederic Konrad <fred.konrad@greensocs.com>, a.rigo@virtualopensystems.com, cota@braap.org, Pranith Kumar <bobby.prani@gmail.com>, nikunj@linux.vnet.ibm.com

On Thu, Mar 2, 2017 at 11:53 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Make sure we have the BQL held when processing interrupts.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/xtensa/helper.c    | 1 +
>  target/xtensa/op_helper.c | 7 +++++++
>  2 files changed, 8 insertions(+)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
