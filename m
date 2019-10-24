Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC1ACA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABF220679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzdL2ePP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABF220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTFS-000212-Nw
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 22:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNTEe-000087-BN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNTEd-000163-8t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:52:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNTEd-00015n-51
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571885542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bIzpyLGY8xnSMN3KwrjDDoFaPJ7oLdF+BcPEHvJEKg=;
 b=WzdL2ePPFfFCkn6uinEKGyo9F3I6tgcPo2J9SKoDTPwveFvo9kACISJzZT+p5VFrgsCBag
 Hg5En+8pfad158Po6sm5ihya2N8BnL4b/FUsPP/JiEXZhNXBPxnVBtcE6wRO0/772Pc0wh
 5mWMtui7KyOmKPefj9UfKuSr+GMjdik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-UYX83volOeGm_MGGmADTjg-1; Wed, 23 Oct 2019 22:52:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5410B107AD31;
 Thu, 24 Oct 2019 02:52:20 +0000 (UTC)
Received: from localhost (ovpn-116-56.gru2.redhat.com [10.97.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E437E100164D;
 Thu, 24 Oct 2019 02:52:19 +0000 (UTC)
Date: Wed, 23 Oct 2019 23:52:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cathy Zhang <cathy.zhang@intel.com>
Subject: Re: [Resend PATCH 0/3] Add CPU model for intel processor Cooper Lake
Message-ID: <20191024025218.GL6744@habkost.net>
References: <1571729728-23284-1-git-send-email-cathy.zhang@intel.com>
MIME-Version: 1.0
In-Reply-To: <1571729728-23284-1-git-send-email-cathy.zhang@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: UYX83volOeGm_MGGmADTjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 22, 2019 at 03:35:25PM +0800, Cathy Zhang wrote:
> This patchset is to add CPU model for intel processor Cooper Lake. It
> will inherit features from the existing CPU model Cascadelake-Server,
> meanwhile, add the platform associated new instruction and feature
> for speculative execution which the host supports. There are associated
> feature bit and macro defined here as needed.

Queued, thanks.

>=20
> Cathy Zhang (3):
>   i386: Add MSR feature bit for MDS-NO
>   i386: Add macro for stibp
>   i386: Add new CPU model Cooperlake
>=20
>  target/i386/cpu.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/i386/cpu.h |  3 +++
>  2 files changed, 63 insertions(+)
>=20
> --=20
> 1.8.3.1
>=20

--=20
Eduardo


