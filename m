Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41983C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A38D20663
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A38D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfivX-00027f-EP
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hfiu4-0001DD-H6
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hfiu2-0008S5-Jk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:42:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hfiu0-00086F-QQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:42:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 950423087944
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 10:41:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BA07600C7;
 Tue, 25 Jun 2019 10:41:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DEC8611386A0; Tue, 25 Jun 2019 12:41:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
References: <4C5F8F98-D058-46A4-81E7-D9A5D4FEE2EC@redhat.com>
Date: Tue, 25 Jun 2019 12:41:48 +0200
In-Reply-To: <4C5F8F98-D058-46A4-81E7-D9A5D4FEE2EC@redhat.com> (Christophe de
 Dinechin's message of "Tue, 25 Jun 2019 11:24:05 +0200")
Message-ID: <87sgryeykz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 25 Jun 2019 10:41:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Fix build error when VNC is configured out
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 David Alan Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: David Gilbert

Christophe de Dinechin <dinechin@redhat.com> writes:

> In hmp_change(), the variable hmp_mon is only used
> by code under #ifdef CONFIG_VNC. This results in a build
> error when VNC is configured out with the default of
> treating warnings as errors:
>
> monitor/hmp-cmds.c: In function =E2=80=98hmp_change=E2=80=99:
> monitor/hmp-cmds.c:1946:17: error: unused variable =E2=80=98hmp_mon=E2=80=
=99 [-Werror=3Dunused-variable]
> 1946 |     MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
>      |                 ^~~~~~~
>
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  monitor/hmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index c283dde0e9..038614da8e 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1943,7 +1943,6 @@ static void hmp_change_read_arg(void *opaque, const=
 char *password,
>=20=20
>  void hmp_change(Monitor *mon, const QDict *qdict)
>  {
> -    MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
>      const char *device =3D qdict_get_str(qdict, "device");
>      const char *target =3D qdict_get_str(qdict, "target");
>      const char *arg =3D qdict_get_try_str(qdict, "arg");
> @@ -1952,6 +1951,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>      Error *err =3D NULL;
>=20=20
>  #ifdef CONFIG_VNC
> +    MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
>      if (strcmp(device, "vnc") =3D=3D 0) {
>          if (read_only) {
>              monitor_printf(mon,

