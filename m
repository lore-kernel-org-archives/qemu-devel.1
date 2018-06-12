Received: from eggs.gnu.org ([2001:4830:134:3::10]:54483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSexg-0004uc-M2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSexa-0003Fv-UP
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:47:32 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSexa-0003FO-H5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:47:26 -0400
Received: by mail-oi0-x22a.google.com with SMTP id i205-v6so20391794oib.1
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 01:47:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABhKiVUfJw9gntCUfT7vCJyTHusZSnt6kTjZq2hMS5-bT4g8kQ@mail.gmail.com>
References: <CABhKiVUfJw9gntCUfT7vCJyTHusZSnt6kTjZq2hMS5-bT4g8kQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Jun 2018 09:47:05 +0100
Message-ID: <CAFEAcA8ueTKXyT25JmjqGY5YMv4yXuM2V13RWMiWQ8H6QDRHFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-discuss] Questions about qemu enabling TCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yt zhang <zyt510998645@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss <qemu-discuss@nongnu.org>

On 12 June 2018 at 06:45, yt zhang <zyt510998645@gmail.com> wrote:
> Dear technicians=EF=BC=8C
> Good day.
>      I encountered some problems in the process of learning qemu, so I
> would like to ask technical staff.
>      QEMU is running User Model mode and enables TCI function. What is th=
e
> workflow of qemu at TCG and TCI stages? Is there a related program flow
> diagram?

TCI is just another backend for TCG. Instead of directly
generating native host instructions, we generate TCI bytecodes,
which are then runtime interpreted.

You almost certainly never want to use TCI. Use a proper
TCG backend instead.

thanks
-- PMM
