Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4F6C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE7920692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qw/GRz/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE7920692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCyf-0007tS-C3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipCtR-0007oS-LJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipCtP-0002fT-VM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:05:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32934
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipCtP-0002eA-Ql
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578495906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgNtyG8Nqi26+mYuM4xlztX/cgmqYJiNFtyxz70len4=;
 b=Qw/GRz/jCy1fk5zL4rPLApy06/Ab5gRYawsy/Gu5GXFqLcRjryHQm02qqC7xikUOnU7Lty
 pHNMFOYYRObZDFFAD2EKP1GKXvTpDPYOsQrDLYfUSAZl40iEO3GG+HRNtaBg1eaMUu3ETy
 R+/hLxUl/u+O6iTGzpJhmXwivnPW/Sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-4CfZ7XoIPdWMZEX7UqZAnA-1; Wed, 08 Jan 2020 10:05:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAE6018543A3;
 Wed,  8 Jan 2020 15:05:01 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FAEF60BE2;
 Wed,  8 Jan 2020 15:05:00 +0000 (UTC)
Date: Wed, 8 Jan 2020 15:04:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Lieven <pl@kamp.de>
Subject: Re: qemu-4.0.1: vhost_region_add_section:Section rounded to 0 prior
 to previous a0000
Message-ID: <20200108150458.GC3184@work-vm>
References: <985fea06-ede6-dcb7-8829-a48a9416bc09@kamp.de>
MIME-Version: 1.0
In-Reply-To: <985fea06-ede6-dcb7-8829-a48a9416bc09@kamp.de>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4CfZ7XoIPdWMZEX7UqZAnA-1
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Lieven (pl@kamp.de) wrote:
> Hi,
>=20
>=20
> I have a Qemu 4.0.1 machine with vhost-net network adapter, thats polluti=
ng the log with the above message.
>=20
> Is this something known? Googling revealed the following patch in Nemu (w=
ith seems to be a Qemu fork from Intel):
>=20
> https://github.com/intel/nemu/commit/03940ded7f5370ce7492c619dccced114ef7=
f56e
>=20
>=20
> The network stopped functioning. After a live-migration the vServer is re=
achable again.
>=20
>=20
> Any ideas?

What guest are you running and what does your qemu commandline look
like?

I've just posted a fix for a similar case that only affected windows
guests with hyperv synic; but the 'previous a0000' looks different.

Dave

>=20
> Thanks,
>=20
> Peter
>=20
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


