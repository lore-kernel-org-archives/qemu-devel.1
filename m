Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29530C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 10:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8116214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 10:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI5cI8Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8116214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iez1u-0005QP-1F
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 05:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iez17-0004pp-Ga
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 05:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iez14-0003kr-4H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 05:14:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24040
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iez13-0003i6-Pg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 05:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576059284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PcH4zaLeFVP3cfvDJFIqNKlgKlxFX5AQRC83a0Os7TQ=;
 b=dI5cI8AvBc/j5E8Zzm6g89xuCE2JWpUQAc5oGI5mlkKp5smwt0vbAj3U48KZiQu4q7qCm/
 AXaOpnw1ZHOwXaCEBIUi3Fh+QywvezKukhJGSHplHphLPAvUr3rS79SVBuTV+dhkE9CGOh
 NrnBoHP3JvyvV72FYgD7FFDTu1wkqEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-XreCmvYiNsePBRsfD-pP8g-1; Wed, 11 Dec 2019 05:14:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6939F8CDA13;
 Wed, 11 Dec 2019 10:14:42 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D93D1001902;
 Wed, 11 Dec 2019 10:14:40 +0000 (UTC)
Date: Wed, 11 Dec 2019 11:14:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: Insufficiently documented deprecated command arguments
Message-ID: <20191211101439.GA6505@linux.fritz.box>
References: <87tv67wa9y.fsf@dusky.pond.sub.org>
 <20191211093317.GB2441258@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20191211093317.GB2441258@angien.pipo.sk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: XreCmvYiNsePBRsfD-pP8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.12.2019 um 10:33 hat Peter Krempa geschrieben:
> On Wed, Dec 11, 2019 at 09:12:41 +0100, Markus Armbruster wrote:
> >     Commit 7a9877a026 "block: Accept device model name for
> >     block_set_io_throttle" (v2.8.0) deprecated block_set_io_throttle
> >     argument @device.
>=20
> This one is more complex. The command is used both in 'blockdev' and in
> 'drive' mode:
>=20
> In 'drive' mode we pass the alias of the 'drive' as the @device
> argument.
>=20
> In 'blockdev' mode we pass the qom name as @id

Any reason you couldn't use the QOM name even in 'drive' mode for any
QEMU version that has the @id option?

> >     Commit c42e8742f5 "block: Use JSON null instead of "" to disable
> >     backing file" (v2.10.0) deprecated blockdev-add empty string
> >     argument @backing.
>=20
> This is used in 'blockdev' mode only and we always pass the JSON null or
> a node name string.

Here the thing to consider might be that JSON null isn't easy to use on
the command line for manual users.

> >     These were missed in commit eb22aeca65 "docs: document deprecation
> >     policy & deprecated features in appendix" (v2.10.0).
> >=20
> >     Commit 3c605f4074 "commit: Add top-node/base-node options" (v3.1.0)
> >     deprecated block-commit arguments @base and @top.
>=20
> This command also has two modes:
>=20
> In 'drive' mode we pass in path strings as @base and @ top.
>=20
> In 'blockdev' mode we pass in nodenames as @base-node and @top-node.
>=20
> Starting from qemu-4.2 libvirt uses 'blockdev' mode for VMs unless an SD
> card is configured as we didn't convert to the '-device' approach for
> those as AFAIK not everything is possible to be converted.

Hm... I guess in 'drive' mode, you stil don't assign node names, so you
actually have to rely on paths?

Kevin


