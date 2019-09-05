Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC13DC41514
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68CB22CF6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68CB22CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5pBD-00070E-08
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5p7q-0002wD-1Z
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5p7o-0007VH-LD
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5p7o-0007UV-Es
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B6BEE3CA16
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 10:36:23 +0000 (UTC)
Received: from work-vm (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB441001281;
 Thu,  5 Sep 2019 10:36:16 +0000 (UTC)
Date: Thu, 5 Sep 2019 11:36:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190905103613.GK2700@work-vm>
References: <20190905082947.6633-1-stefanha@redhat.com>
 <6e9ff4f7-2906-3c11-8191-05cff3e60f53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6e9ff4f7-2906-3c11-8191-05cff3e60f53@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 05 Sep 2019 10:36:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH RESEND 0/2] virtiofsd: use
 "fuse_log.h" APIs instead of <err.h>
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> Hi Stefan,
>=20
> On 9/5/19 10:29 AM, Stefan Hajnoczi wrote:
> > warn(3), warnx(3), err(3), and errx(3) print to stderr even when the =
--syslog
> > option was given.  In this case messages to stderr are likely to be l=
ost and
> > this makes troubleshooting hard.  Use "fuse_log.h" APIs instead of <e=
rr.h>.
> >=20
> > Stefan Hajnoczi (2):
> >   virtiofsd: replace warn(3) and warnx(3) with fuse_warning()
> >   virtiofsd: replace err(3) and errx(3) with fuse_err()
>=20
> Is this a straight RESEND or are there any changes in this series?
>=20
> I'm asking because IIRC your first series had:
> - Reviewed-by: Jun Piao <piaojun@huawei.com>
> - Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> If this isn't a RESEND then I'll review it again.

I'll pick those reviews up.

Dave

> Thanks,
>=20
> Phil.
>=20
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

