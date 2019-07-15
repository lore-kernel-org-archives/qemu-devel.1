Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F0CC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26B520665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26B520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyCQ-0004do-5f
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35841)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hmyCF-0004FJ-Gi
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hmyCE-0001Uw-K4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hmyCE-0001TV-EQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:27:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9812E307D913
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 10:27:01 +0000 (UTC)
Received: from work-vm (ovpn-117-181.ams2.redhat.com [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FC574505;
 Mon, 15 Jul 2019 10:26:55 +0000 (UTC)
Date: Mon, 15 Jul 2019 11:26:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190715102653.GF2689@work-vm>
References: <20190625123905.25434-1-dinechin@redhat.com>
 <20190626164913.dn2vfv4rji7xsk5k@steredhat>
 <0458fb96-33d8-05eb-cb41-cf19086f986b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0458fb96-33d8-05eb-cb41-cf19086f986b@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 15 Jul 2019 10:27:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] Fix build error when VNC is configured
 out
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
Cc: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> On 6/26/19 6:49 PM, Stefano Garzarella wrote:
> > On Tue, Jun 25, 2019 at 02:39:05PM +0200, Christophe de Dinechin wrot=
e:
> >> In hmp_change(), the variable hmp_mon is only used
> >> by code under #ifdef CONFIG_VNC. This results in a build
> >> error when VNC is configured out with the default of
> >> treating warnings as errors:
> >>
> >> monitor/hmp-cmds.c: In function =E2=80=98hmp_change=E2=80=99:
> >> monitor/hmp-cmds.c:1946:17: error: unused variable =E2=80=98hmp_mon=E2=
=80=99 [-Werror=3Dunused-variable]
> >> 1946 |     MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, com=
mon);
> >>      |                 ^~~~~~~
> >>
> >> v2: Move variable down as suggested by Philippe Mathieu-Daud=C3=A9
> >=20
> > Should we move out this line from the commit message?
> > (Maybe Dave can remove it when apply)
>=20
> Yes please :) It was meant to go after the '---' separator.

Done.

Queued.

> >>
> >> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> >> ---
> >>  monitor/hmp-cmds.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >=20
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

