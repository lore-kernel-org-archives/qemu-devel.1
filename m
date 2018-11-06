Received: from eggs.gnu.org ([2001:4830:134:3::10]:44488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJxPH-0001zK-Ax
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJxPF-0000qd-4R
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:12:19 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJxPF-0000pv-0Q
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:12:17 -0500
Received: by mail-oi1-x241.google.com with SMTP id x63-v6so6375620oix.9
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 01:12:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1541156463-2730-1-git-send-email-liq3ea@gmail.com>
References: <1541156463-2730-1-git-send-email-liq3ea@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 09:11:55 +0000
Message-ID: <CAFEAcA8-6Ri5K7kpCBJJbs8WB6xK5zWqfVeqFgy08UWsdH6AMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qapi: misc: change the 'pc' to unsinged 64
 in CpuInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 2 November 2018 at 11:01, Li Qiang <liq3ea@gmail.com> wrote:
> When trigger a 'query-cpus' qmp, the pc is an signed value like
> following:
> {"arch": "x86", ...  "pc": -1732653994, "halted": true,...}
> It is strange. Change it to uint64_t.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---

NB: typo in subject line: should be "unsigned".

thanks
-- PMM
