Received: from eggs.gnu.org ([2001:4830:134:3::10]:60477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdAb-0008JS-T9
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdAa-00073c-Vm
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:40:53 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZdAa-00072Y-Nw
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:40:52 -0500
Received: by mail-wm0-x235.google.com with SMTP id v77so26179763wmv.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 04:40:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170131114310.6768.79416.stgit@PASHA-ISP>
References: <20170131114310.6768.79416.stgit@PASHA-ISP>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 12:40:30 +0000
Message-ID: <CAFEAcA8aKSCxOcxno=-YNWcbaQkmsqW9+hopdABNjk2JWXdf-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] integratorcp: adding vmstate for
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 31 January 2017 at 11:43, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru> wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> VMState added by this patch preserves correct
> loading of the integratorcp device state.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

You don't need to set minimum_version_id_old (unless it's
different from minimum_version_id and you have the code
to support migration from whatever ancient pre-vmstate
format that is), so I've deleted those lines.

Applied to target-arm.next, thanks.

-- PMM
