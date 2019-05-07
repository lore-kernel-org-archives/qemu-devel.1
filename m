Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2907C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D7420578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D7420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44001 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNxJ9-0008Gs-S3
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 06:26:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hNxHs-00076N-3p
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hNxHq-0002MO-Nl
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:25:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>)
	id 1hNxHm-0002E7-LU; Tue, 07 May 2019 06:25:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27B4281F19;
	Tue,  7 May 2019 10:25:17 +0000 (UTC)
Received: from work-vm (ovpn-116-183.ams2.redhat.com [10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AEDC2854E;
	Tue,  7 May 2019 10:25:13 +0000 (UTC)
Date: Tue, 7 May 2019 11:25:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190507102510.GA2752@work-vm>
References: <20190505230140.5661-1-philmd@redhat.com>
	<87sgtsrmh3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87sgtsrmh3.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 07 May 2019 10:25:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/sd/sdcard: Use the available enums
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
Cc: qemu-trivial@nongnu.org, Juan Quintela <quintela@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>=20
> > We already define SDCardModes/SDCardStates as enums. Declare
> > the mode/state as enums too, this make gdb debugging sessions
> > friendlier: instead of numbers, the mode/state name is displayed.
> >
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >  hw/sd/sd.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index aaab15f3868..a66b3d5b45e 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -96,8 +96,8 @@ struct SDState {
> >      BlockBackend *blk;
> >      bool spi;
> > =20
> > -    uint32_t mode;    /* current card mode, one of SDCardModes */
> > -    int32_t state;    /* current card state, one of SDCardStates */
> > +    enum SDCardModes mode;
> > +    enum SDCardStates state;
> >      uint32_t vhs;
> >      bool wp_switch;
> >      unsigned long *wp_groups;
> > @@ -1640,7 +1640,7 @@ static int cmd_valid_while_locked(SDState *sd, =
SDRequest *req)
> > =20
> >  int sd_do_command(SDState *sd, SDRequest *req,
> >                    uint8_t *response) {
> > -    int last_state;
> > +    enum SDCardStates last_state;
> >      sd_rsp_type_t rtype;
> >      int rsplen;
>=20
> These guys are part of the migration state:
>=20
>    static const VMStateDescription sd_vmstate =3D {
>        .name =3D "sd-card",
>        .version_id =3D 1,
>        .minimum_version_id =3D 1,
>        .pre_load =3D sd_vmstate_pre_load,
>        .fields =3D (VMStateField[]) {
>            VMSTATE_UINT32(mode, SDState),
>            VMSTATE_INT32(state, SDState),
>    [...]
>=20
> Juan, David, are VMSTATE_UINT32() and VMSTATE_INT32() safe to use with
> enums?

I think that is compiler dependent, so no.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

