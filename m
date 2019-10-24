Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F228DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB99520679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eg9rLttA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB99520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeIg-0001iy-Dd
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iNdvS-0002Uf-IS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iNdvQ-0004XU-7a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:17:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iNdvN-0004Vq-3z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571926631;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXSdXd9/UhlDotVVCFbY/e/EQyZci5kL4xWgA9QkOW4=;
 b=eg9rLttAriFy7OA4JkpjAmZc+Mfd9EnrYv7+H3MSqTu+TyyMu/3sla5xFPchlqbMU/aCwG
 +rUlFyrL22rsQWpNDm5t++Oin2z9FAnvpz+ldKHmleTrrEW9O9KRheBRpFto8U//UAfBYL
 vli2ohJ4D6U6YipKiY0yT95vMtOAuOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-C5cEJIRCOTelcSkyYfSZrA-1; Thu, 24 Oct 2019 10:17:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2EAE801E5C
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:17:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89A06600CC;
 Thu, 24 Oct 2019 14:17:00 +0000 (UTC)
Date: Thu, 24 Oct 2019 15:16:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [libvirt] [RFC PATCH 19/19] qapi: Implement -compat
 deprecated-output=hide for events
Message-ID: <20191024141658.GD8381@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
 <20191024123458.13505-20-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191024123458.13505-20-armbru@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: C5cEJIRCOTelcSkyYfSZrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 02:34:58PM +0200, Markus Armbruster wrote:
> This policy suppresses deprecated events, and thus permits "testing
> the future".

One thing that occurs to me is that this is a fairly passive impact
on libvirt. eg it may well be not at all obvious if libvirt is behaving
in a broken way due to an event not being emitted, as the code in
question simply won't be triggered.

With the current QMP this situation is unavoidable since QEMU doesn't
know which events the client (libvirt) is actually using. QEMU just
unconditionally emits all events.

I've often wondered if we should have the client explicitly tell
QEMU which events it wants to receive as part of the QMP greeting
handshake.

ie, libvirt knows which events it can handle. QEMU knows which
events it can emit, and reports this via capabilities which
libvirt probes.

So on connecting libvirt can tell QEMU exactly which evnets it
wants to get back. QEMU is now able to explicitly tell libvirt
it has asked for a deprecated event, and so the logic from the
"deprecated-input" option can take effect.

We'd not need "deprecated-output" at that point.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


