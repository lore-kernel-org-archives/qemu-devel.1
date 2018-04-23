Received: from eggs.gnu.org ([2001:4830:134:3::10]:48365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAd9j-0006Je-OU
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAd9f-0004KX-OE
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:13:27 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAd9f-0004KH-IX
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:13:23 -0400
Received: by mail-ot0-x241.google.com with SMTP id y10-v6so4596939otg.10
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 08:13:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9be72244-9d04-db2f-c05b-d9e4abcfc14e@st.com>
References: <20180423075215.4572-1-christophe.lyon@st.com>
	<20180423075215.4572-4-christophe.lyon@st.com>
	<CAFEAcA_fkkHFX1Ud36f9fy+-rrbK_TSu9wuiFVSLFC-tyD7cqA@mail.gmail.com>
	<9be72244-9d04-db2f-c05b-d9e4abcfc14e@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 16:13:02 +0100
Message-ID: <CAFEAcA9unNz=hnQ5Aj+UHWFP_jQ25z4uaXdsa9qGsyAj9L8aRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ARM/FDPIC v2 3/4] linux-user: ARM-FDPIC: Add
 support of FDPIC for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 23 April 2018 at 15:13, Christophe Lyon <christophe.lyon@st.com> wrote:
> On 23/04/2018 14:49, Peter Maydell wrote:
> This patch defines and uses info_is_fdpic, the next one in the
> series uses information for TaskState, so I suppose it's OK
> not to add this new flag as you suggest, and in the next patch
> use info_is_fdpic(ts->info) instead of adding task_is_fdpic() ?

Yes, that works too.

thanks
-- PMM
