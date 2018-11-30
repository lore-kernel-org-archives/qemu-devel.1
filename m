Received: from eggs.gnu.org ([2001:4830:134:3::10]:59203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSkoZ-0007jR-IW
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSkoY-0003P8-0G
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:34:47 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSkoX-0003Fa-NY
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:34:45 -0500
Received: by mail-ot1-x344.google.com with SMTP id 81so5468826otj.2
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
	<20181127202422.32745-1-ricardo.perez_blanco@nokia.com>
In-Reply-To: <20181127202422.32745-1-ricardo.perez_blanco@nokia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:34:32 +0000
Message-ID: <CAFEAcA9hyWEYZWX7OJ=tGDBt7DRMP=kngHcuvT63GOYPm_MbgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] Allow AArch64 processors to boot from a
 kernel placed over 4GB.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ricardo.perez_blanco@nokia.com
Cc: =?UTF-8?Q?Ricardo_P=C3=A9rez?= <ricardoperezblanco@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 27 Nov 2018 at 20:25, Perez Blanco, Ricardo (Nokia -
BE/Antwerp) <ricardo.perez_blanco@nokia.com> wrote:
>
> Some machine based on AArch64 can have its main memory over 4GBs. With
> the current path, these machines can support "-kernel" in qemu.
>
> Note that, currently, none of the QEMU machines have their main memory over
> 4GBs.
>
> Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
> ---

Thanks for the respin; I've added it to target-arm.next for the
4.0 release. (I rephrased the commit message a bit and fixed up
the overlong lines.)

-- PMM
