Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B7C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18102072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ofe7jMsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18102072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLZK-0002XO-Q5
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irLYQ-0001b5-RX
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irLYN-00072q-7Q
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:44:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irLYN-00072V-3L
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579005854;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdycyemKwuH60As/BZ3RJPBSOGIqFFa69ljALC/tr/A=;
 b=Ofe7jMsEucmkSFgl6H/u3gESZwiEXRzW8VQ22p8mQLIqRBSj0Yf7l1Mc3DCDTWTYCeV2x3
 NOzIkOSsUV3OxIDKZD8yRg00sMOMjGpM3f2Rovi/Kx3dHTzDt6kseYn8bTX2mKdlq49nXl
 Db+080EeeJaP15dSFunUyzT9WFWREO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-32jOC6NJML2zDGTryCy32g-1; Tue, 14 Jan 2020 07:44:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31D9219057A6;
 Tue, 14 Jan 2020 12:44:11 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E5E19C5B;
 Tue, 14 Jan 2020 12:44:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 00/30] Migration pull patches (3rd try)
In-Reply-To: <20200114113926.3556-1-quintela@redhat.com> (Juan Quintela's
 message of "Tue, 14 Jan 2020 12:38:56 +0100")
References: <20200114113926.3556-1-quintela@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 14 Jan 2020 13:44:03 +0100
Message-ID: <87a76qdx7w.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 32jOC6NJML2zDGTryCy32g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> wrote:
> The following changes since commit 3c8a6575985b1652b45bfa670b5e1907d642cf=
a0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200113-pull-req=
uest' into staging (2020-01-13 14:19:57 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-pull-reque=
st
>
> for you to fetch changes up to c3ff7ba64b1bb484a0b6339165627a196045a8c1:
>
>   multifd: Allocate uint64_t instead of ram_addr_t (2020-01-14 12:28:07 +=
0100)
>
> ----------------------------------------------------------------
> Migration pull request (take 3)
>
> Fix (yet more) places where ram_addr_t is not 64 bits.
>
> ----------------------------------------------------------------

Nack

Reordering to make git bisect happy


