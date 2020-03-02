Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276DDC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96062187F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kr+L39WQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96062187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8lMS-00089e-1l
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j8lHW-0004us-3q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j8lHU-0005s2-6o
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:38:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j8lHU-0005rn-0w
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583156327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6IfrV0fwPOVAM+oI3Q9V81E8iVPj3rB/Z76ia4Elec8=;
 b=Kr+L39WQ/KIjx2LrVasoX+yKrnOYzMdmpxNH2nBt93mO0ZeHOocPW5VZujdWeOh80hkhRG
 VQrFmSn+8lO6E0DwNSNuEXrMSTaaLwafbXapEkAIVjijpZk/NTzpWGUOe2O4G8s3p/6gA7
 BDQbNi9Ftuf1uBdi1uKYjOs8zgCG/hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-EsPWYz_5NqSZBtvH6XO9qg-1; Mon, 02 Mar 2020 08:38:42 -0500
X-MC-Unique: EsPWYz_5NqSZBtvH6XO9qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14923DB62;
 Mon,  2 Mar 2020 13:38:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-7.ams2.redhat.com [10.36.117.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05C3D90F5B;
 Mon,  2 Mar 2020 13:38:38 +0000 (UTC)
Date: Mon, 2 Mar 2020 14:38:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 0/2] allow to set 'drive' property on a realized block
 device
Message-ID: <20200302133837.GC4965@linux.fritz.box>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: vsementsov@virtuozzo.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.11.2019 um 20:03 hat Denis Plotnikov geschrieben:
> This allows to replace the file on a block device and is useful
> to workaround the cases (migration) when the VM image is placed on
> some shared storage with exclusive file opening model but the image
> should be open form more than one app.
>=20
> The previous version of approaching the workaround was based on the
> "blockdev-change-medium" command modification but had some flaws:
>   * semantics: blockdev-change-medium is aimed to be used with removable =
devices
>     only
>   * interface: it can't accept all possible combination of parameters for
>     the "drive" replacement (creation).
>=20
> More details here: http://patchwork.ozlabs.org/patch/1179329/
>=20
> The current series suggests another approach:
> 1. blockdev-add
> 2. qom-set disk.drive =3D the blockdev added (this is what the series add=
s)

Are you still planning to send another version?

Kevin


