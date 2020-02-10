Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ED6C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFAA20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIRywcYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFAA20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17jn-0000K8-EK
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 07:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j17iz-0008LS-KU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j17iy-0005rz-GD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:59:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j17iy-0005qR-CU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581335975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5a/hnYd35wz6o75CUFeMJD3NK0GhUvRQaIoWv0nHzw=;
 b=QIRywcYJwvvf0IeA6/E7ZU3ORGAcfqnKZloCZCX3vWKwHErHzs3lJqJcw21Lxnwb7wVol4
 EAi12OJNYVp4txmLhG+DagWqUzizKpR+3n3Ew+ASobfVlbcqJ6MVZeFG1/YLWy8cMWY8SK
 7rXULEOBCbLr6rRgp/ZeOmlcwb5gYzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-hvwBogITOPycFnbXPNVN0Q-1; Mon, 10 Feb 2020 06:59:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CD3010509A1;
 Mon, 10 Feb 2020 11:59:30 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E52E5DA82;
 Mon, 10 Feb 2020 11:59:20 +0000 (UTC)
Date: Mon, 10 Feb 2020 12:59:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy?
Message-ID: <20200210115918.GA5955@linux.fritz.box>
References: <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
 <20200206142143.GA4926@linux.fritz.box>
 <e0c6b15c-5411-6112-0327-ef9d51424153@redhat.com>
 <87zhdtlev1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87zhdtlev1.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: hvwBogITOPycFnbXPNVN0Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.02.2020 um 08:25 hat Markus Armbruster geschrieben:
> John Snow <jsnow@redhat.com> writes:
>=20
> > On 2/6/20 9:21 AM, Kevin Wolf wrote:
> [...]
> >> 2. Rewriting qmp-shell to use a better syntax for nested data
> >>    structures. This would have to be defined before the project starts=
.
> >>=20
> >
> > ... Can't start until we define the proper interface, because then we
> > have to support it. Right now, qmp-shell is a developer toy because it'=
s
> > hidden in the tree.
> >
> > Promoting it to prime-time will be fruitless unless we come up with a
> > convincing TUI for it.
>=20
> Oh, it'll bear fruit alright!  And that will be the problem.
>=20
> Back to serious: I also object to the idea to expose end users to
> qmp-shell in its current state.  Do not ship.

I don't think anyone suggested making the existing qmp-shell available
by default or shipping it in distro packages or anything. Being able to
configure qemu so that it does offer qmp-shell on a chardev seems like a
reasonable intermediate milestone to me, though. Users won't see this
unless they are actively trying to experiment with it.

Kevin


