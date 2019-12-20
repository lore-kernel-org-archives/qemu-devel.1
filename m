Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454EFC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFF420866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htlECdRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFF420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiOem-0000sQ-7b
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 15:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iiOeA-0000TQ-2M
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iiOe7-0007tG-BV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:13:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iiOe7-0007p8-2C
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576872789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uR8Nn/Hdvn1AEG+SUFf4VmXd0caPr/VE15JoTRXMV/U=;
 b=htlECdRmdGExDfaNJvREPcYr31SeiRrDsfRufRooQlROd1aY3iyTgMuW67T4bC/lD2bIPS
 8XG+HSAYaxtjn5RZU/mH1PAbCwNI+gLjg4peHWZr8lhGWj9hR4zwgLsCOnxhJDNazaGk2c
 JW8JXfdbIi0k+L0JTxw0/T0Ynly+GKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-11qowwLDMyqOZEbIzNb2uQ-1; Fri, 20 Dec 2019 15:13:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B3B2800D4E;
 Fri, 20 Dec 2019 20:13:06 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C687A19C68;
 Fri, 20 Dec 2019 20:13:00 +0000 (UTC)
Date: Fri, 20 Dec 2019 17:12:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PULL 2/2] configure: Require Python >= 3.5
Message-ID: <20191220201258.GA498046@habkost.net>
References: <20191220165141.2207058-1-ehabkost@redhat.com>
 <20191220165141.2207058-3-ehabkost@redhat.com>
 <8736deakmn.fsf@trasno.org>
MIME-Version: 1.0
In-Reply-To: <8736deakmn.fsf@trasno.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 11qowwLDMyqOZEbIzNb2uQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 07:59:28PM +0100, Juan Quintela wrote:
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Python 3.5 is the oldest Python version available on our
> > supported build platforms, and Python 2 end of life will be 3
> > weeks after the planned release date of QEMU 4.2.0.  Drop Python
> > 2 support from configure completely, and require Python 3.5 or
> > newer.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > Message-Id: <20191016224237.26180-1-ehabkost@redhat.com>
> > Reviewed-by: John Snow <jsnow@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks!

>=20
> But once here, a comment telling why we want 3.5, not 3.4 or 3.6 will
> have been helpful.

Is "Python 3.5 is the oldest Python version available on our
supported build platforms" a good explanation why we want 3.5?

--=20
Eduardo


