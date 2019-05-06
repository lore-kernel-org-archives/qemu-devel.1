Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9E3C04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D95E20830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D95E20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53079 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNZQA-0006kh-KF
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:56:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNZPH-000634-Tn
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNZPG-0002FD-IY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hNZPC-000284-Gd; Mon, 06 May 2019 04:55:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25AA730917AF;
	Mon,  6 May 2019 08:55:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A3CB319C4F;
	Mon,  6 May 2019 08:55:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0D0981132B35; Mon,  6 May 2019 10:55:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190505230140.5661-1-philmd@redhat.com>
Date: Mon, 06 May 2019 10:55:20 +0200
In-Reply-To: <20190505230140.5661-1-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 6 May 2019 01:01:40
	+0200")
Message-ID: <87sgtsrmh3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 06 May 2019 08:55:22 +0000 (UTC)
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
	qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>,
	Philippe =?utf-8?Q?M?= =?utf-8?Q?athieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> We already define SDCardModes/SDCardStates as enums. Declare
> the mode/state as enums too, this make gdb debugging sessions
> friendlier: instead of numbers, the mode/state name is displayed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/sd/sd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f3868..a66b3d5b45e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -96,8 +96,8 @@ struct SDState {
>      BlockBackend *blk;
>      bool spi;
>=20=20
> -    uint32_t mode;    /* current card mode, one of SDCardModes */
> -    int32_t state;    /* current card state, one of SDCardStates */
> +    enum SDCardModes mode;
> +    enum SDCardStates state;
>      uint32_t vhs;
>      bool wp_switch;
>      unsigned long *wp_groups;
> @@ -1640,7 +1640,7 @@ static int cmd_valid_while_locked(SDState *sd, SDRe=
quest *req)
>=20=20
>  int sd_do_command(SDState *sd, SDRequest *req,
>                    uint8_t *response) {
> -    int last_state;
> +    enum SDCardStates last_state;
>      sd_rsp_type_t rtype;
>      int rsplen;

These guys are part of the migration state:

   static const VMStateDescription sd_vmstate =3D {
       .name =3D "sd-card",
       .version_id =3D 1,
       .minimum_version_id =3D 1,
       .pre_load =3D sd_vmstate_pre_load,
       .fields =3D (VMStateField[]) {
           VMSTATE_UINT32(mode, SDState),
           VMSTATE_INT32(state, SDState),
   [...]

Juan, David, are VMSTATE_UINT32() and VMSTATE_INT32() safe to use with
enums?

