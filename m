Received: from eggs.gnu.org ([2001:4830:134:3::10]:54665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evmLn-0003G5-Q3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evmLk-0003CL-1M
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:31 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:41928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evmLj-0003Bs-Gp
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:27 -0400
Received: by mail-ot0-x236.google.com with SMTP id w38-v6so101095ota.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 09:00:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520850690-23245-3-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1520850690-23245-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1520850690-23245-3-git-send-email-abdallah.bouassida@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 16:00:05 +0000
Message-ID: <CAFEAcA9Jcb11QgYkPh6VnR3CT2ADaCRdwn3TLtBOgCr+WRsYhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 2/4] target/arm: Add "_S" suffix to the
 secure version of a sysreg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 12 March 2018 at 10:31, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> This is a preparation for the coming feature of creating dynamically an XML
> description for the ARM sysregs.
> Add "_S" suffix to the secure version of sysregs that have both S and NS views
> Replace (S) by _S and remove (NS) for the register that are manually defined,
> so all the registers follow the same convention.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
