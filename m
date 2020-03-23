Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CB4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2501920719
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdGdHuKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2501920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRuO-0006uc-C4
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jGRs5-00058J-8L
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jGRrz-0003fG-It
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:32:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jGRry-0003Xc-VW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584988331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3VLfYrYi4+eEv6YrT9Kw1sTGu3L5q6pcu1tQjaU57Y=;
 b=OdGdHuKWVobs57be68hnYCnisO1GcUEmzHM7WGj9TF0oxaZHydSreCrPM81RJiErD6vP/g
 lXf+AV1tO4uK8iDs7RtjdllU2BTpSQ82FYDOAmt5Mdv1vwGO81E/nv7PGgsSp351WQBm3+
 omPeIx2hls/ySdvOUB1wilI9YZf9LYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-RKWEGZJgM_Sahwe-AyXwIA-1; Mon, 23 Mar 2020 14:32:09 -0400
X-MC-Unique: RKWEGZJgM_Sahwe-AyXwIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19FDB800D50;
 Mon, 23 Mar 2020 18:32:08 +0000 (UTC)
Received: from localhost (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADA731001B09;
 Mon, 23 Mar 2020 18:32:07 +0000 (UTC)
Date: Mon, 23 Mar 2020 14:32:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v2] target/i386: set the CPUID level to 0x14 on old
 machine-type
Message-ID: <20200323183206.GA9322@habkost.net>
References: <1584031686-16444-1-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584031686-16444-1-git-send-email-luwei.kang@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Fri, Mar 13, 2020 at 12:48:06AM +0800, Luwei Kang wrote:
> The CPUID level need to be set to 0x14 manually on old
> machine-type if Intel PT is enabled in guest. E.g. the
> CPUID[0].EAX(level)=3D7 and CPUID[7].EBX[25](intel-pt)=3D1 when the
> Qemu with "-machine pc-i440fx-3.1 -cpu qemu64,+intel-pt" parameter.
>=20
> Some Intel PT capabilities are exposed by leaf 0x14 and the
> missing capabilities will cause some MSRs access failed.
> This patch add a warning message to inform the user to extend
> the CPUID level.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>

Queued, thanks.

--=20
Eduardo


