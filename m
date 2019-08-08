Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E6CC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615CC21874
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615CC21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hviot-0001JG-IA
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 09:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45900)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mtosatti@redhat.com>) id 1hvinb-0000iZ-Cd
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mtosatti@redhat.com>) id 1hvinX-0002tS-U7
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1hvimE-00010q-I0
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:49:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C9E761281;
 Thu,  8 Aug 2019 13:47:12 +0000 (UTC)
Received: from amt.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B56760600;
 Thu,  8 Aug 2019 13:47:09 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
 by amt.cnet (Postfix) with ESMTP id 6ABAA10512C;
 Thu,  8 Aug 2019 10:46:52 -0300 (BRT)
Received: (from marcelo@localhost)
 by amt.cnet (8.14.7/8.14.7/Submit) id x78DkkWd006995;
 Thu, 8 Aug 2019 10:46:46 -0300
Date: Thu, 8 Aug 2019 10:46:46 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190808134646.GA6915@amt.cnet>
References: <20190808090652.2478-1-ppandit@redhat.com>
 <39a5c98f-f402-2985-2d49-800e73f53f4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <39a5c98f-f402-2985-2d49-800e73f53f4f@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 08 Aug 2019 13:47:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] scsi: lsi: exit infinite loop while
 executing script (CVE-2019-12068)
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Bugs SysSec <bugs-syssec@rub.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 08, 2019 at 11:31:02AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 8/8/19 11:06 AM, P J P wrote:
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >=20
> > When executing script in lsi_execute_script(), the LSI scsi
> > adapter emulator advances 's->dsp' index to read next opcode.
> > This can lead to an infinite loop if the next opcode is empty.
> > Exit such loop after reading 10k empty opcodes.
> >=20
> > Reported-by: Bugs SysSec <bugs-syssec@rub.de>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> >  hw/scsi/lsi53c895a.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > Update v2: define LSI_MAX_INSN 10000
> >   -> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01370.h=
tml
> >=20
> > diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> > index 10468c1ec1..2adab341b1 100644
> > --- a/hw/scsi/lsi53c895a.c
> > +++ b/hw/scsi/lsi53c895a.c
> > @@ -185,6 +185,9 @@ static const char *names[] =3D {
> >  /* Flag set if this is a tagged command.  */
> >  #define LSI_TAG_VALID     (1 << 16)
> > =20
> > +/* Maximum instructions to process. */
> > +#define LSI_MAX_INSN    10000
> > +
> >  typedef struct lsi_request {
> >      SCSIRequest *req;
> >      uint32_t tag;
> > @@ -1132,7 +1135,10 @@ static void lsi_execute_script(LSIState *s)
> > =20
> >      s->istat1 |=3D LSI_ISTAT1_SRUN;
> >  again:
> > -    insn_processed++;
> > +    if (++insn_processed > LSI_MAX_INSN) {
> > +        s->waiting =3D LSI_NOWAIT;
> > +        goto exitloop;
> > +    }
>=20
> If I understand the datasheet correctly, the model should set the
> DSTAT.IID bit.
>=20
>   Illegal Instruction Detected
>=20
>   This status bit is set any time an illegal or reserved
>   instruction opcode is detected, whether the LSI53C895A
>   is operating in single step mode or automatically
>   executing SCSI SCRIPTS.

Sounds the correct thing to do (exiting the loop seems arbitrary).=20

> We already have:
>=20
>     trace_lsi_execute_script_tc_illegal();
>     lsi_script_dma_interrupt(s, LSI_DSTAT_IID);
>=20
> Cc'ing Marcelo Tosatti since it is hard to understand the "Windows SCSI
> driver hack":

What this patch is, if an infinite loop is detected, to raise UDC
exception (Unexpected Disconnect). This would cause the driver to=20
restart processing, which would work around the infinite loop problem.

> $ git show ee4d919f30f
> commit ee4d919f30f1378cda697dd94d5a21b2a7f4d90d
> Author: aliguori <aliguori@c046a42c-6fe2-441c-8c8c-71466251a162>
> Date:   Mon Sep 22 16:04:16 2008 +0000
>=20
>     LSI SCSI: raise UDC on infinite loop (Marcelo Tosatti)
>=20
>     Raise UDC (Unexpected Disconnect) when a large enough number of
>     instructions has been executed by the SCRIPTS processor. This "solu=
tion"
>     is much simpler than temporarily interrupting execution.
>=20
>     This remedies the situation with Windows which downloads SCRIPTS co=
de
>     that busy loops on guest main memory. Their drivers _do_ handle UDC
>     appropriately (at least XP and 2003).
>=20
>     It would be nicer to actually detect infinite loops, but until then=
,
>     this bandaid seems acceptable.
>=20
>     Since the situation seems to be rare enough, raise the number
>     of instructions to 10000 (previously 1000).
>=20
>     Three people other than myself had success with this patch.
>=20
>     Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>     Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
>=20
> $ git show 64c68080da4
> commit 64c68080da429edf30a9857e3a698cb9ed335bd3
> Author: pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
> Date:   Mon Sep 22 16:30:29 2008 +0000
>=20
>     Add comment to windows SCSI hack.
>=20
> diff --git a/hw/lsi53c895a.c b/hw/lsi53c895a.c
> index e45eefaef7..53a2add0df 100644
> --- a/hw/lsi53c895a.c
> +++ b/hw/lsi53c895a.c
> @@ -1199,6 +1199,11 @@ again:
>          }
>      }
>      if (insn_processed > 10000 && !s->waiting) {
> +        /* Some windows drivers make the device spin waiting for a mem=
ory
> +           location to change.  If we have been executed a lot of code=
 then
> +           assume this is the case and force an unexpected device
> disconnect.
> +           This is apparently sufficient to beat the drivers into
> submission.
> +         */
>          if (!(s->sien0 & LSI_SIST0_UDC))
>              fprintf(stderr, "inf. loop with UDC masked\n");
>          lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
>=20
> >      insn =3D read_dword(s, s->dsp);
> >      if (!insn) {
> >          /* If we receive an empty opcode increment the DSP by 4 byte=
s
> > @@ -1569,7 +1575,8 @@ again:
> >              }
> >          }
> >      }
> > -    if (insn_processed > 10000 && s->waiting =3D=3D LSI_NOWAIT) {
> > +exitloop:
> > +    if (insn_processed > LSI_MAX_INSN && s->waiting =3D=3D LSI_NOWAI=
T) {
> >          /* Some windows drivers make the device spin waiting for a m=
emory
> >             location to change.  If we have been executed a lot of co=
de then
> >             assume this is the case and force an unexpected device di=
sconnect.
> >=20

