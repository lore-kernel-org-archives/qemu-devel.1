Received: from eggs.gnu.org ([2001:4830:134:3::10]:36224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkO7f-00084E-OF
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkO7e-0005fQ-VA
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:22:35 -0400
References: <1503414375-21009-1-git-send-email-thuth@redhat.com>
	<27da1dae-1e2f-559a-d8f0-c7e15289363e@adacore.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d5be8092-dc56-14aa-b950-d82e7f959ec1@redhat.com>
Date: Wed, 23 Aug 2017 07:22:25 +0200
MIME-Version: 1.0
In-Reply-To: <27da1dae-1e2f-559a-d8f0-c7e15289363e@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/misc/auxbus.c: Mark the
 aux-to-i2c-bridge device as non-hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-trivial@nongnu.org

On 22.08.2017 20:15, KONRAD Frederic wrote:
> Hi Thomas,
> 
> Looking to this seems there is a second issue:
> The aux-to-i2c-bridge device should connect on a TYPE_AUX_BUS.
> 
> I don't think there isn't any on integratorcp..
> 
> Anyway the patch you sent fix this issue indirectly and as far as
> I remember I wasn't able to make this I2C bridge an
> TYPE_AUX_DEVICE as it's a special device and it is internal (only
> instantiated at the bus creation).

If it is intended to be completely internal only (i.e. also not for use
with the "-device" parameter), then it should even be marked with
"user_creatable = false"! ... if you got some spare minutes, could you
maybe sent a patch for that? I'm not familiar with that code, so I'm
always having trouble to give the reasoning for setting a
"user_creatable = false" somewhere...

 Thanks,
  Thomas
