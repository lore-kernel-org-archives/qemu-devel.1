Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A3EC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18AE22133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AE22133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47287 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYGr-000720-Da
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:53:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEYG7-0006ko-Qx
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEYG6-00074L-8f
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:52:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEYG5-00071q-PM
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:52:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05EF13172D75;
	Thu, 11 Apr 2019 11:52:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AC0C5D756;
	Thu, 11 Apr 2019 11:52:19 +0000 (UTC)
Date: Thu, 11 Apr 2019 12:52:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190411115216.GN3641@redhat.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
	<BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<cd833acf-4643-0d3c-78f5-7677d224954e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <cd833acf-4643-0d3c-78f5-7677d224954e@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 11 Apr 2019 11:52:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Markus Armbruster <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Lidong Chen <lidong.chen@oracle.com>,
	"darren.kenny@oracle.com" <darren.kenny@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Aurelien Jarno <aurelien@aurel32.net>, "f4bug@amsat.org" <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411115216.DOQXXDvc-ijcZrunSNLbSe0r3rXP4bm177xs0r0fbK4@z>

On Tue, Apr 09, 2019 at 11:37:44AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 4/9/19 10:59 AM, Aleksandar Markovic wrote:
> >>
> >> Lidong Chen <lidong.chen@oracle.com> writes:
> >>
> >>> Due to an off-by-one error, the assert statements allow an
> >>> out-of-bounds array access.
> >>>
> >>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> >>> ---
> >>>  hw/sd/sd.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> >>> index aaab15f..818f86c 100644
> >>> --- a/hw/sd/sd.c
> >>> +++ b/hw/sd/sd.c
> >>> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardSta=
tes state)
> >>>      if (state =3D=3D sd_inactive_state) {
> >>>          return "inactive";
> >>>      }
> >>> -    assert(state <=3D ARRAY_SIZE(state_name));
> >>> +    assert(state < ARRAY_SIZE(state_name));
> >>>      return state_name[state];
> >>>  }
> >>>
> >>> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type=
_t rsp)
> >>>      if (rsp =3D=3D sd_r1b) {
> >>>          rsp =3D sd_r1;
> >>>      }
> >>> -    assert(rsp <=3D ARRAY_SIZE(response_name));
> >>> +    assert(rsp < ARRAY_SIZE(response_name));
> >>>      return response_name[rsp];
> >>>  }
> >>
> >> This is the second fix for this bug pattern in a fortnight.  Where's
> >> one, there are more:
> >>
> >> $ git-grep '<=3D ARRAY_SIZE'
> >> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_=
apr[0]));
> >> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_=
apr[0]));
> >> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <=3D ARRAY_SI=
ZE(s->tx_fifo)) {
> >> hw/sd/pxa2xx_mmci.c:        && s->tx_len <=3D ARRAY_SIZE(s->tx_fifo)
> >> hw/sd/pxa2xx_mmci.c:        && s->rx_len <=3D ARRAY_SIZE(s->rx_fifo)
> >> hw/sd/pxa2xx_mmci.c:        && s->resp_len <=3D ARRAY_SIZE(s->resp_f=
ifo);
> >> hw/sd/sd.c:    assert(state <=3D ARRAY_SIZE(state_name));
> >> hw/sd/sd.c:    assert(rsp <=3D ARRAY_SIZE(response_name));
> >> hw/usb/hcd-xhci.c:    assert(n <=3D ARRAY_SIZE(tmp));
> >=20
> >> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D=
 ARRAY_SIZE (multiple_regs)) {
> >> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D=
 ARRAY_SIZE (multiple_regs)) {
> >> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D=
 ARRAY_SIZE (multiple_regs)) {
> >> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D=
 ARRAY_SIZE (multiple_regs)) {
> >=20
> > The last four items are OK as they are. The variable multiple_regs is=
, in fact,
> > an array of 9 int constants:
> >=20
> > static const int multiple_regs[] =3D { 16, 17, 18, 19, 20, 21, 22, 23=
, 30 };
> >=20
> > ARRAY_SIZE (multiple_regs) will always be equal to 9.
> >=20
> > The variable base_reglist (that is checked to be > 0 and <=3D9) is us=
ed
> > in succeeding lines like this:
> >=20
> >         for (i =3D 0; i < base_reglist; i++) {
> >             do_sw(env, addr, env->active_tc.gpr[multiple_regs[i]], me=
m_idx,
> >                   GETPC());
> >             addr +=3D 4;
> >         }
> >=20
> > Therefore, the array multiple_regs will always be accessed within its=
 bounds.
> >=20
> >> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> >> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> >> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <=3D=
 ARRAY_SIZE(dbg->arch.bp));
> >> tcg/tcg.c:    tcg_debug_assert(pi <=3D ARRAY_SIZE(op->args));
> >> util/main-loop.c:    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
> >> util/module.c:    assert(n_dirs <=3D ARRAY_SIZE(dirs));
> >>
> >> Lidong Chen, would you like to have a look at these?
> >>
> >> Cc'ing maintainers to help with further investigation.
> >>
> >=20
> > Thank you for bringing this to our attention, Markus. And thanks to L=
idong too.
> >=20
> > Aleksandar
> >=20
> > P. S. Shouldn't perhaps our macro ARRAY_SIZE() be renamed to
> > NUMBER_OF_ELEMENTS()?
>=20
> I remember this post from Daniel where he suggests sticking to GLib
> G_N_ELEMENTS() (which looks similar to your suggestion):
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02676.html
>=20
> $ git grep G_N_ELEMENTS|wc -l
> 125
> $ git grep ARRAY_SIZE|wc -l
> 939
>=20
> Now it is not obvious to me to understand which GLib API we are
> encouraged to use and which ones we shouldn't.

We have a bunch of duplication that is essentially a historical
artifact from before we used GLib in QEMU. IMHO, if GLib provides
something that is equivalent with no functional downside that
matters to QEMU, then there's no reason to keep QEMU's duplicate.

IOW, I would always prefer GLib unless there's a compelling reason
not to in order to minimize what we maintain ourselves


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

