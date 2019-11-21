Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C773C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0446A2068E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya+om96+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0446A2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnDQ-0008Tb-6v
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iXnCY-0007QW-RK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iXnCX-0006aI-5R
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:12:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43226
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iXnCX-0006ZP-1g
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574345572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oM/sXvwC9qPiMtWAEOtZAimoSktsA2OiVRMMjTaLz7I=;
 b=Ya+om96+K6cMDyYx2o3V2410dE5oQ0qkfVi28IAV6UPaeQuLI385YlcqQB2Rltlp2JtyVP
 a+WdjZVYh/lvtIqXciAYLiAGMa+D0+czFefJUbrKvyLjMp/xAxUD0P6E2yarpi0wgi27WV
 n3WiDzK31lK7fYd/mV3Q1w/f3RQczSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-tQQMjHPiP9u3PL86V4LKpw-1; Thu, 21 Nov 2019 09:12:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0858D8D60D6;
 Thu, 21 Nov 2019 14:12:49 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C306C60C23;
 Thu, 21 Nov 2019 14:12:48 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id DC2A63E0527; Thu, 21 Nov 2019 15:12:45 +0100 (CET)
Date: Thu, 21 Nov 2019 15:12:45 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH for-4.2 2/2] i386: Add -noTSX aliases for hle=off, rtm=off
 CPU models
Message-ID: <20191121141245.GR7032@paraplu>
References: <20191120164912.32384-1-ehabkost@redhat.com>
 <20191120164912.32384-3-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120164912.32384-3-ehabkost@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: tQQMjHPiP9u3PL86V4LKpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 01:49:12PM -0300, Eduardo Habkost wrote:
> We have been trying to avoid adding new aliases for CPU model
> versions, but in the case of changes in defaults introduced by
> the TAA mitigation patches, the aliases might help avoid user
> confusion when applying host software updates.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

    https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg03501.html

            - - -

Should we (can do it, if you already don't have a patch WIP for it)
also update this file to reflect this?
https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/qemu-cpu-models.texi

While at it ... I wonder if it's worth making a separte doc
(versioned-cpu-models.rst) explaining the versioned CPU models, usage,
etc.

There was a very useful discussion between you and Dan Berrang=E9 on this
list (Message-Id: <20190625050008.12789-5-ehabkost@redhat.com>, the
first version of the thread: "[PATCH 4/6] i386: Infrastructure for
versioned CPU models").  Could potentially incorporate some of that
content.

> ---
>  target/i386/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)

[...]

--=20
/kashyap


