Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B52C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E232206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2V/SovY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E232206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1szO-00047d-9t
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 09:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1syn-0003gL-Ph
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1sym-0002Vd-Kj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:27:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1sym-0002Uj-Gy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581517623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oVkqHpvhcsfaX0+Jr0TBdnaQJfWh3zPr2aHcpgzaTU=;
 b=P2V/SovY57etJbpY4DKU+EEq9SWHZr1k/s+O8uFYF0o6mDuqsTbWfNaYIGLibAh1ZMrd1P
 eWmtugyNUHa22WdxFqQdLeI6ukmDc5rRSKfMAh5mDpemCjWztZ4L/M13FHKizLRCJIBpiB
 lHUZ+ZUGkWIp163lRXipsfB1b1rfje4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-vfJiBuIPPFqDZ5F5LSwIjA-1; Wed, 12 Feb 2020 09:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DB13A0CC3;
 Wed, 12 Feb 2020 14:26:56 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B6FB38E;
 Wed, 12 Feb 2020 14:26:52 +0000 (UTC)
Date: Wed, 12 Feb 2020 14:26:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] docs: Fix virtiofsd.1 location
Message-ID: <20200212142649.GC3258@work-vm>
References: <1908428819.7192207.1581512184275.JavaMail.zimbra@redhat.com>
 <1608747495.7195569.1581513386780.JavaMail.zimbra@redhat.com>
 <CAFEAcA-F-F1C4si7OXNkMnzE+9DHXtNnvCYv1eTx-nEpb4_OZw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-F-F1C4si7OXNkMnzE+9DHXtNnvCYv1eTx-nEpb4_OZw@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: vfJiBuIPPFqDZ5F5LSwIjA-1
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
Cc: Miroslav Rezanina <mrezanin@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Wed, 12 Feb 2020 at 13:16, Miroslav Rezanina <mrezanin@redhat.com> wro=
te:
> >
> > Patch 6a7e2bbee5 docs: add virtiofsd(1) man page introduced new man
> > page virtiofsd.1. Unfortunately, wrong file location is used as
> > source for install command. This cause installation of docs fail.
> >
> > Fixing wrong location so installation is successful.
> >
> > Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> I noticed this in review of v1 of the patch
> https://patchew.org/QEMU/20200127162514.56784-1-stefanha@redhat.com/
> but missed that it hadn't been fixed in v2/v3.

Oops thanks!

Does someone want to take this via build or trivial - I've not got
any more virtiofsd stuff currently queued.

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


