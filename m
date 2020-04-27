Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBDAC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD992075B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQCDKdA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD992075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzYm-00014T-EY
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1jSzWf-0007Ez-DM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1jSzWe-0007tB-Iw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:54:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27832
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1jSzWe-0007oA-5H
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587977641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HymUgiJKDcxOukVG6M+qPC/nrztehYUbXk5QgV5gmM=;
 b=AQCDKdA47YUlyDdhB60PYAW7KHfUz0ydpLx4uB0THE3w0uiSjirYTcGCoqbq+ihHqmC8YP
 hwgwJVjZVHmI78UA/ftpFANcBC56E+V2Y3gcHtrZQlsxyv3mxETpzThCdNVLfnc/YamsKC
 4j16QYkff4p6juAse4hvrJ3ktxRXoXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-YcQq59p2MxWksx9t01zoJA-1; Mon, 27 Apr 2020 04:52:09 -0400
X-MC-Unique: YcQq59p2MxWksx9t01zoJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B55C468;
 Mon, 27 Apr 2020 08:52:08 +0000 (UTC)
Received: from kinshicho.usersys.redhat.com (unknown [10.40.195.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0402C1001281;
 Mon, 27 Apr 2020 08:51:57 +0000 (UTC)
Message-ID: <9a32ea035b5d327c3e31ec34a9e2a1079d88910e.camel@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
From: Andrea Bolognani <abologna@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Erik Skultety <eskultet@redhat.com>
Date: Mon, 27 Apr 2020 10:51:55 +0200
In-Reply-To: <20200427012404.4ecf7b71@redhat.com>
References: <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <69e77a6e-8db8-f617-bfe6-1c8f39ec81b4@redhat.com>
 <20200424065746.GB372397@sturgeon.usersys.redhat.com>
 <20200427012404.4ecf7b71@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-04-27 at 01:24 -0400, Cleber Rosa wrote:
> On Fri, 24 Apr 2020 08:57:46 +0200
> Erik Skultety <eskultet@redhat.com> wrote:
> > On Thu, Apr 23, 2020 at 11:28:21PM +0200, Philippe Mathieu-Daud=C3=A9
> > wrote:
> > > Thanks to insist with that point Daniel. I'd rather see every
> > > configuration reproducible, so if we loose a hardware sponsor, we
> > > can find another one and start another runner.
> > > Also note, if it is not easy to reproduce a runner, it will be very
> > > hard to debug a reported build/test error.
> >=20
> > (Thanks for bringing ^this point up Philippe)
> >=20
> > ...However, what we've been actively working on in libvirt is to
> > extend the lcitool we have (which can spawn local test VMs) to the
> > point where we're able to generate machines that would be the
> > reproducible. Right now I'm playing with cloud-init integration with
> > lcitool (patches coming soon) that would allow us to use the same
> > machines locally as we'd want to have in, say, OpenStack and share
> > them as compressed images, so even when updated/managed by lcitool
> > locally, you'd get the same environment.
>=20
> This is great, and it aligns with my previous point that reproducibility
> it's not *just* about the hardware, but about diligently documenting
> and automating the environments, be them mundane or super specialized.
> And IMO that should score some points when it comes to being
> promoted/demoted as a Gating machine/job.

I think there's room to extend and rework lcitool so that it can be
used for QEMU CI as well, and we should definitely look into that.

Right now it only really covers VMs and containers, but there's
already one situation (FreeBSD) where the expectation is that you'd
import an existing VM image and then apply CI-related customizations
on top, so it's not too much of a stretch to imagine doing the same
for a bare metal machine. We use Ansible, so as long as we can
connect to the machine via ssh we're pretty much good to go.

Installation of VMs we already perform in an unattended fashion using
preseed/kickstart, and it should be relatively straighforward to
adapt those configurations to also work on real hardware. This way
we'd both be able to rely on having a sane OS as the base, and
relieve the administrator from the duty of manually installing the
machines.

--=20
Andrea Bolognani / Red Hat / Virtualization


