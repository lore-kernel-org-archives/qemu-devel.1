Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB00AC5ED31
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E4C20801
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7jLVdcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E4C20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7K1E-0003VF-Nx
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j7K0T-0002eH-0n
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j7K0Q-0002Gh-Jo
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:19:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j7K0Q-0002Gb-Fs
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582813153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ge4lU0s5fhNYDhDc+JFi2xJk8Vb45u9e2w65S2P+bYo=;
 b=Y7jLVdcQG7RV1I4jwCPO+Fz3rAioOB0n99j6Gp1wXUXizeedMgYkYyKT8p+nsUogD6sQ90
 oyuwFhQmjHqv0LXHzc0Nm814aO9WJ+j0t+krBCw9RXT+JNQSPP/QXZJRtjoQapm7IU4tKd
 hhmL+U1UN1StF8D51+c0q4YUuDwaj20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-CJBML6jTN1eSg9y1mQfjng-1; Thu, 27 Feb 2020 09:19:11 -0500
X-MC-Unique: CJBML6jTN1eSg9y1mQfjng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80F3F800D5F;
 Thu, 27 Feb 2020 14:19:10 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-150.ams2.redhat.com
 [10.36.117.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 323DA90CD0;
 Thu, 27 Feb 2020 14:19:10 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 1FCC03E04B9; Thu, 27 Feb 2020 15:19:08 +0100 (CET)
Date: Thu, 27 Feb 2020 15:19:08 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 14/18] docs/system: Convert qemu-cpu-models.texi to rST
Message-ID: <20200227141908.GO24572@paraplu>
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-15-pbonzini@redhat.com>
 <CAFEAcA-ps7dmo_7Lgf2kTsy0nvFgU6qopS8HvZMu3DY81VvE_g@mail.gmail.com>
 <20200227123722.GN24572@paraplu>
MIME-Version: 1.0
In-Reply-To: <20200227123722.GN24572@paraplu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 01:37:22PM +0100, Kashyap Chamarthy wrote:

(Just keeping the list in sync.)

[...]
=20
> In summary, to-do for v5:
>=20
>   - Fix the things you pointed out in this patch here.
>=20
>   - Don't mix unrelated changes with .texi --> rst conversion (undo the
>     copyright year and the capitalization changes; make them separate
>     patches).
>=20
>   - Do the split of x86 | MIPS in a separate patch, including the change
>     of moving the macros to 'defs.rst.inc'.

On IRC (#qemu, OFTC), Peter offerred to take Paolo's series and roll out
a v2 with the changes he suggested; so I can skip doing a v5.

Thanks, Peter.

--=20
/kashyap


