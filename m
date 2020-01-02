Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F25C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C01A206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQgZwygH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C01A206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in28F-0006IS-Ld
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1in279-000599-TA
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1in278-00064A-RF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:10:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60592
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1in278-00063o-Nf
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577977818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUZwnTKzZ65Vdk0WTwjrJA/q6gnn0g9W4W+6aekfeZw=;
 b=BQgZwygHDkP78YixYAnxBZGo2XLs4RNc4Z+GHfzM4tiW5N23kxT1BPLHCrm//WuKdGpOV7
 p0e+TMMlbtbPhnSBTXiJreIKKu3gstH1UfXJLWcFx6pOvgynH6md9ABmimrKJBpcQ2WEg4
 MC+r2MHaL0C4kKcxkpTnSEkKtjZfaKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-WUEgSGdHPEujRbE6AhJURg-1; Thu, 02 Jan 2020 10:10:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96A61992F9;
 Thu,  2 Jan 2020 15:10:15 +0000 (UTC)
Received: from work-vm (ovpn-117-17.ams2.redhat.com [10.36.117.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0D5B610E2;
 Thu,  2 Jan 2020 15:10:08 +0000 (UTC)
Date: Thu, 2 Jan 2020 15:10:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200102151006.GB2973@work-vm>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: WUEgSGdHPEujRbE6AhJURg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@gmail.com) wrote:

> 5. A jailer is needed to isolate the QEMU process and vhost-user
> device backends using seccomp, Linux namespaces, and maybe
> SELinux/AppArmor.  We used to be able to rely on libvirt for QEMU
> security, but it's becoming a common task for any device backend and
> IMO should be its own launcher tool.

It feels like there's two parts to this:
  a) The sandboxing at startup
  b) Then whatever comms is needed to allow things like hotplugging
    afterwards, passing fd's etc

you'd think (a) would be some code that would be shared between logs of
projects.

Dave

> 6. A configuration file format is sorely needed so that guest
> configuration can be persisted and easily launched.  Today you have to
> create a shell script that executes a QEMU command-line, but this is
> suboptimal because sharing executable scripts is dangerous from a
> security perspective and is hard to parse or modify programmatically.
>=20
> In many of these areas we already have a partial solution.  It just
> needs more work.  I think it would be worth the effort and the mental
> shift to really providing APIs that are easy to use by applications.
>=20
> What do you think?
>=20
> Have I missed things that are needed?
>=20
> Have I included things that are unnecessary?
>=20
> Stefan
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


