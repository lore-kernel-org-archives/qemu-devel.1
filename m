Received: from eggs.gnu.org ([2001:4830:134:3::10]:42751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLW5c-0004Vm-0o
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLW5X-0008Ks-2D
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:49:40 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLW5W-0008KX-T6
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:49:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id d17so303863wme.3
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 07:49:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
	<CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
	<d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
	<CAFEAcA_BkOaRCs1tm2dv+mYZj4yaNTg7VhR2C-NAQGAhw1wazA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebda6a7d-6523-c7ea-c126-95fc23712872@redhat.com>
Date: Thu, 15 Jun 2017 16:49:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_BkOaRCs1tm2dv+mYZj4yaNTg7VhR2C-NAQGAhw1wazA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: KONRAD Frederic <fred.konrad@greensocs.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>



On 15/06/2017 16:40, Peter Maydell wrote:
> On 14 June 2017 at 12:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> I think the various bindings and rates could be refreshed as devices are
>> migrated.  This assumes that the device migration order is okay
>> according to the clock tree
> 
> Unfortunately we make no guarantees at all about migration order
> for devices as far as I'm aware, so devices have to cope regardless.

It's device realization order, so there are some guarantees.  A board
can realize devices in its preferred order (and realization will also
bind clocks and set rates IIUC, just like migration), and a qdev bus's
children will be visited after the bus owner.

> (There's also the possibility of an oddball bit of hardware which
> has a clocktree with loops in it.)

For these cases there is post_load, I guess.

Paolo
