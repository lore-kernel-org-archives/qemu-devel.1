Received: from eggs.gnu.org ([2001:4830:134:3::10]:38315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhBEn-0002i9-5V
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhBEj-0006b9-VS
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:00:41 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhBEj-0006a8-Ps
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:00:37 -0400
Received: by mail-wm0-f43.google.com with SMTP id t201so32703072wmt.1
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 02:00:37 -0700 (PDT)
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<f07c7c77f83136f938f346e1f3b2aa5296ff4223.1502643878.git.balaton@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d150f9d-bca2-7bbd-aecf-584d65646c23@redhat.com>
Date: Mon, 14 Aug 2017 11:00:34 +0200
MIME-Version: 1.0
In-Reply-To: <f07c7c77f83136f938f346e1f3b2aa5296ff4223.1502643878.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 13/08/2017 19:04, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/Makefile.objs |   2 +-
>  hw/ppc/ppc405.h      |   2 +
>  hw/ppc/ppc405_uc.c   | 241 ---------------------------------------------
>  hw/ppc/ppc4xx_i2c.c  | 272 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 275 insertions(+), 242 deletions(-)
>  create mode 100644 hw/ppc/ppc4xx_i2c.c

Can you move it to hw/i2c while you're at it?

Paolo
