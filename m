Received: from eggs.gnu.org ([2001:4830:134:3::10]:50697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW1VL-0003Nk-Mm
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW1VL-0006Fy-0t
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:23:39 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW1VK-0006Ed-QQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:23:38 -0400
Received: by mail-wm0-x22b.google.com with SMTP id i127so24320530wma.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:23:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713141928.25419-1-alex.bennee@linaro.org>
References: <20170713141928.25419-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 15:23:17 +0100
Message-ID: <CAFEAcA_CCDU+7N8dqL5mRjAKNVQYa4m9j_mkhv1jHZMVKSSk5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/6] arm: fixes for eret,
 isb and DISAS_UPDATE handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 13 July 2017 at 15:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Hi Peter,
>
> All reviews are now in and I've tested against AArch64 OPTEE xtest
> suite and it fixes the hang. Apart from review tags there was one
> minor tweak to gen_goto_tb so it always sets s->is_jmp =3D
> DISAS_TB_JUMP;
>
> I reckon these are ready to be taken into the ARM tree now.
>

Applied to target-arm.next, thanks. We can fix up the long
standing oddity of masking bit 0 of s->pc in a different patch.

-- PMM
