Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5A1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 22:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0462F21739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 22:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0462F21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwZoS-0007rj-6e
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 17:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwZnc-0007Ir-Fm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 17:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwZnb-0000IZ-7G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 17:57:36 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37322)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1iwZnb-0000Gc-2b; Tue, 28 Jan 2020 17:57:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 1367B299A5;
 Tue, 28 Jan 2020 17:57:30 -0500 (EST)
Date: Wed, 29 Jan 2020 09:57:26 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 01/14] dp8393x: Mask EOL bit from descriptor addresses
In-Reply-To: <e7b06341-d433-1f39-19ad-cbe52106398c@redhat.com>
Message-ID: <alpine.LNX.2.21.1.2001290928490.8@nippy.intranet>
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <e5d4133abf4ecbb37d4abc45d7166cbd3cfac1d4.1579474761.git.fthain@telegraphics.com.au>
 <e7b06341-d433-1f39-19ad-cbe52106398c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-648433098-1580252246=:42"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 98.124.60.144
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-648433098-1580252246=:42
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 Jan 2020, Philippe Mathieu-Daud=C3=A9 wrote:

> Hi Finn,
>=20
> On 1/19/20 11:59 PM, Finn Thain wrote:
> > The Least Significant bit of a descriptor address register is used as
> > an EOL flag. It has to be masked when the register value is to be used
> > as an actual address for copying memory around. But when the registers
> > are to be updated the EOL bit should not be masked.
> >=20
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > Tested-by: Laurent Vivier <laurent@vivier.eu>
> > ---
> > Changed since v1:
> >   - Added macros to name constants as requested by Philippe Mathieu-Dau=
d=C3=A9.
> > ---
> >   hw/net/dp8393x.c | 19 ++++++++++++-------
> >   1 file changed, 12 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> > index cdc2631c0c..14901c1445 100644
> > --- a/hw/net/dp8393x.c
> > +++ b/hw/net/dp8393x.c
> > @@ -145,6 +145,9 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ##
> > __VA_ARGS__); } while (0)
> >   #define SONIC_ISR_PINT   0x0800
> >   #define SONIC_ISR_LCD    0x1000
> >   +#define SONIC_DESC_EOL   0x0001
> > +#define SONIC_DESC_ADDR  0xFFFE
>=20
> I'd rather not add SONIC_DESC_ADDR and use ~SONIC_DESC_EOL instead.
>=20
> Please consider it if you respin the series.
>=20

I chose to use 0xFFFE instead of ~SONIC_DESC_EOL because the former=20
correctly implies an unsigned short word, while the latter mask may=20
suggest some need for sign extension or longer words.

I agree that ~SONIC_DESC_EOL is easily understood as "all the other bits".=
=20
But the bits in SONIC_DESC_EOL will never change, since this value is=20
dictated by the hardware.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20

Thanks for reviewing this series.

> > +
> >   #define TYPE_DP8393X "dp8393x"
> >   #define DP8393X(obj) OBJECT_CHECK(dp8393xState, (obj), TYPE_DP8393X)
> >   @@ -197,7 +200,8 @@ static uint32_t dp8393x_crba(dp8393xState *s)
> >     static uint32_t dp8393x_crda(dp8393xState *s)
> >   {
> > -    return (s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA];
> > +    return (s->regs[SONIC_URDA] << 16) |
> > +           (s->regs[SONIC_CRDA] & SONIC_DESC_ADDR);
> >   }
> >     static uint32_t dp8393x_rbwc(dp8393xState *s)
> > @@ -217,7 +221,8 @@ static uint32_t dp8393x_tsa(dp8393xState *s)
> >     static uint32_t dp8393x_ttda(dp8393xState *s)
> >   {
> > -    return (s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA];
> > +    return (s->regs[SONIC_UTDA] << 16) |
> > +           (s->regs[SONIC_TTDA] & SONIC_DESC_ADDR);
> >   }
> >     static uint32_t dp8393x_wt(dp8393xState *s)
> > @@ -506,8 +511,8 @@ static void dp8393x_do_transmit_packets(dp8393xStat=
e *s)
> >                                sizeof(uint16_t) *
> >                                (4 + 3 * s->regs[SONIC_TFC]) * width,
> >                   MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> > -            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
> > -            if (dp8393x_get(s, width, 0) & 0x1) {
> > +            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0);
> > +            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
> >                   /* EOL detected */
> >                   break;
> >               }
> > @@ -763,13 +768,13 @@ static ssize_t dp8393x_receive(NetClientState *nc=
,
> > const uint8_t * buf,
> >       /* XXX: Check byte ordering */
> >         /* Check for EOL */
> > -    if (s->regs[SONIC_LLFA] & 0x1) {
> > +    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
> >           /* Are we still in resource exhaustion? */
> >           size =3D sizeof(uint16_t) * 1 * width;
> >           address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
> >           address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
> >                            (uint8_t *)s->data, size, 0);
> > -        if (dp8393x_get(s, width, 0) & 0x1) {
> > +        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
> >               /* Still EOL ; stop reception */
> >               return -1;
> >           } else {
> > @@ -827,7 +832,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const
> > uint8_t * buf,
> >       address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 *
> > width,
> >           MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> >       s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, 0);
> > -    if (s->regs[SONIC_LLFA] & 0x1) {
> > +    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
> >           /* EOL detected */
> >           s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
> >       } else {
> >=20
>=20
>=20
---1463811774-648433098-1580252246=:42--

