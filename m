Received: from eggs.gnu.org ([2001:4830:134:3::10]:55052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dhDOi-0004hA-1G
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dhDOd-00025D-1j
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:19:04 -0400
Date: Mon, 14 Aug 2017 13:18:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <0d150f9d-bca2-7bbd-aecf-584d65646c23@redhat.com>
Message-ID: <alpine.BSF.2.21.1708141316200.10227@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<f07c7c77f83136f938f346e1f3b2aa5296ff4223.1502643878.git.balaton@eik.bme.hu>
	<0d150f9d-bca2-7bbd-aecf-584d65646c23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [RFC PATCH 05/12] ppc4xx: Split off 4xx I2C
 emulation from ppc405_uc to its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Mon, 14 Aug 2017, Paolo Bonzini wrote:
> On 13/08/2017 19:04, BALATON Zoltan wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ppc/Makefile.objs |   2 +-
>>  hw/ppc/ppc405.h      |   2 +
>>  hw/ppc/ppc405_uc.c   | 241 ---------------------------------------------
>>  hw/ppc/ppc4xx_i2c.c  | 272 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 275 insertions(+), 242 deletions(-)
>>  create mode 100644 hw/ppc/ppc4xx_i2c.c
>
> Can you move it to hw/i2c while you're at it?

I could if that's the preferred way but I've left it in hw/ppc because 
this is not a generic device but specific to PPC SoCs and it was easier
to work with files in one dir than scattered through the tree. Should I 
still move it to hw/i2c?

Regards,
BALATON Zoltan
