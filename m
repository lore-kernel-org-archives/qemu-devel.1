Received: from eggs.gnu.org ([2001:4830:134:3::10]:36786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW2TF-0004tE-WD
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW2TF-00086S-D3
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:25:34 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW2TF-00086I-4R
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:25:33 -0400
Received: by mail-wr0-x235.google.com with SMTP id 77so69069584wrb.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 08:25:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E069C2FF-508A-4F1B-8821-BAE8451D06F6@gmail.com>
References: <E069C2FF-508A-4F1B-8821-BAE8451D06F6@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 16:25:11 +0100
Message-ID: <CAFEAcA8fY7W87x+8mv90J9SdeTbGhTGJQVEfwHkxRmw8aqB1PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] help with tilegx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Chen Gang <xili_gchen_5257@hotmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 14 July 2017 at 16:01, Programmingkid <programmingkidx@gmail.com> wrote:
> How do I build the tilegx target? I have tried "./configure --target-list=tilegx" and "./configure --target-list=tilegx-softmmu". They both fail with this message: "ERROR: Unknown target name".

tilegx at the moment only supports linux-user, so
--target-list=tilegx-linux-user (and you'll need to be on
a Linux host).

thanks
-- PMM
