Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F923C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47646206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoURglPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47646206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHowN-00036q-Ha
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 09:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHovo-0002iQ-66
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHovm-0001Rb-Gy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:21:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHovm-0001P3-DB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585315309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jskmgcEGZgw4NwlDApvAeHQMBMfbabxnEeGmi0PWzfs=;
 b=hoURglPJzo9JzkgaDEJq9/aa/gAM39dLanfjVqhk+nqXmUOtZeYtblQXq1QuHzLBMAtRqN
 i0KcZt4/O4CLoJikl2Fe3o5GopNQ6zsfkWZey+O2L4I8fbtjEP3dwtJUBMdpd2pshdNtlM
 SpCkGQevkXLLfjmpIny/6MkwB1Cjg1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-eXyqRb9lNtO0q4E-A7eelA-1; Fri, 27 Mar 2020 09:21:45 -0400
X-MC-Unique: eXyqRb9lNtO0q4E-A7eelA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CC791005509;
 Fri, 27 Mar 2020 13:21:39 +0000 (UTC)
Received: from work-vm (ovpn-113-149.ams2.redhat.com [10.36.113.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B9B7CDBD6;
 Fri, 27 Mar 2020 13:21:38 +0000 (UTC)
Date: Fri, 27 Mar 2020 13:21:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] monitor/hmp-cmds: add units for mirate_parameters.
Message-ID: <20200327132136.GH2786@work-vm>
References: <20200327073210.198080-1-maozhongyi@cmss.chinamobile.com>
 <20200327092951.bu4ju7rh53ig5t3l@steredhat>
 <20200327112814.GD2786@work-vm>
 <20200327131253.3axcri54an4pmuzf@steredhat>
MIME-Version: 1.0
In-Reply-To: <20200327131253.3axcri54an4pmuzf@steredhat>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefano Garzarella (sgarzare@redhat.com) wrote:
> On Fri, Mar 27, 2020 at 11:28:14AM +0000, Dr. David Alan Gilbert wrote:
> > * Stefano Garzarella (sgarzare@redhat.com) wrote:
> > > Hi Mao,
> > >=20
> > > On Fri, Mar 27, 2020 at 03:32:10PM +0800, Mao Zhongyi wrote:
> > > > When running:
> > > > (qemu) info migrate_parameters
> > > > announce-initial: 50 ms
> > > > announce-max: 550 ms
> > > > announce-step: 100 ms
> > > > compress-wait-thread: on
> > > > ...
> > > > max-bandwidth: 33554432 bytes/second
> > > > downtime-limit: 300 milliseconds
> > > > x-checkpoint-delay: 20000
> > > > ...
> > > > xbzrle-cache-size: 67108864
> > > >=20
> > > > add units for the parameters 'x-checkpoint-delay' and
> > > > 'xbzrle-cache-size', it's easier to read.
> > > >=20
> > > > Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> > > > ---
> > > >  monitor/hmp-cmds.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > > > index 2a900a528a..8d22f96e57 100644
> > > > --- a/monitor/hmp-cmds.c
> > > > +++ b/monitor/hmp-cmds.c
> > > > @@ -440,7 +440,7 @@ void hmp_info_migrate_parameters(Monitor *mon, =
const QDict *qdict)
> > > >              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LI=
MIT),
> > > >              params->downtime_limit);
> > > >          assert(params->has_x_checkpoint_delay);
> > > > -        monitor_printf(mon, "%s: %u\n",
> > > > +        monitor_printf(mon, "%s: %u" " milliseconds\n",
> > >                                        ^
> > > here we can remove the space and use a single string "%s: %u millisec=
onds\n"
> >=20
> > Yes.
> >=20
> > > I've noticed that we use both ms or milliseconds, if you want to clea=
n up in a
> > > separate patch, maybe we could use one of these everywhere. (I vote f=
or 'ms')
> >=20
> > I do prefer 'ms', however we do seem to just use milliseconds in
> > info migrate
>=20
> IIUC, currently with 'info migrate_parameters' we have:
> - announce-initial, announce-max, and announce-step with 'ms'
> - downtime-limit with 'milliseconds'

You're right, so we do - in that case I agree, lets just move them all
to 'ms'.

Dave

> Stefano
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


