Received: from eggs.gnu.org ([2001:4830:134:3::10]:50033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb8Oy-0007w1-00
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb8Ow-0007cb-Vc
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:13:55 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb8Ow-0007bN-Pw
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:13:54 -0500
Received: by mail-wr0-x233.google.com with SMTP id i10so41577232wrb.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 08:13:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485424060-12217-7-git-send-email-fred.konrad@greensocs.com>
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-7-git-send-email-fred.konrad@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 16:13:33 +0000
Message-ID: <CAFEAcA8uOHb3aUWOcM+Ok_fDiECOfLtx2d2TZp7naKJBcf6+nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V2 06/10] docs: add qemu-clock documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

On 26 January 2017 at 09:47,  <fred.konrad@greensocs.com> wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
>
> This adds the qemu-clock documentation.
>
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>
> V1 -> V2:
>   * Fixed in accordance with the changes in the previous patches.
> ---
>  docs/clock.txt | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 docs/clock.txt

Could we have a simple example of what you need to do if you are:
 * a device providing a clock source of some kind
 * a device that takes a clock input and has one or more
   clock outputs which are configured by that device (for
   frequency, on/off, etc)
 * a device that consumes a clock

please? I think that would help make it more concrete how you
need to use these things.

thanks
-- PMM
