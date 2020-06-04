Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810A8206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlxscARC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810A8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgp1w-0003Fp-Md
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jgp0G-0001ka-B2
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:29:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jgp0F-0007DY-6W
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591273785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s6zMEklvSraw6zjb6Wbefent434IoyEk2nOCGJvKIM0=;
 b=HlxscARCwgk9aEBRmq5oBBI+M3kSF8Xhq4GGim5QhGiLpFD5Zc6CvwnVkXbPotwe47+q8P
 fjMbCzecG6HIGrt2fb888iVkQDMC6qN09l7JSrH98e5luHHmOsRsM+juZqyStEkKWjNm+c
 IV3Sj3U5h1skqbjj0H21jT2ebc3cY2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-5cAX0A7MPc2ggWhn4eKxoQ-1; Thu, 04 Jun 2020 08:29:43 -0400
X-MC-Unique: 5cAX0A7MPc2ggWhn4eKxoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAE8F18A8229;
 Thu,  4 Jun 2020 12:29:41 +0000 (UTC)
Received: from gondolin (ovpn-112-76.ams2.redhat.com [10.36.112.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 249D3707B1;
 Thu,  4 Jun 2020 12:29:36 +0000 (UTC)
Date: Thu, 4 Jun 2020 14:29:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 0/7] exec/cpu: Cleanups around "exec/hwaddr.h"
 (reserved to system-mode)
Message-ID: <20200604142934.20925f34.cohuck@redhat.com>
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
References: <20200526172427.17460-1-f4bug@amsat.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 19:24:20 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> The 'hwaddr' type declared in "exec/hwaddr.h" is meant for
> system-mode emulation only.
> This series is a preparatory cleanup to allow later poisoning
> it in user-mode code.
>=20
> Missing review: patche 7
> - target/s390x: Restrict system-mode declarations
>=20
> Maybe PPC/S390X maintainers can take their patches and let
> the rest to Paolo, or he can take all the series. They are
> not dependents.

(...)

>   target/s390x: Only compile decode_basedisp() on system-mode
>   target/s390x/helper: Clean ifdef'ry
>   target/s390x: Restrict system-mode declarations

(...)

Ok, I went ahead and queued patches 5-7 to s390-next.


