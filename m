Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F177CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD803206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwldioBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD803206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6Dj-0006jZ-TK
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ic6BM-000552-Vf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ic6BK-0000L6-PE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:17:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46675
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ic6BK-0000ET-JJ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575371844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E62q2fJikYuFO5aR+cEDhOCEL8dDkz36f1fy0GtrRjE=;
 b=fwldioBKtniysTsknfrHvqrHpTbE+PDAKty3nH4fKdZo8IIvZK1GMWBMVIiM8BB/ZB5EhP
 oW6q8dvB0Ayhgl2bhGk2o1/cZE885DJujgG9mQ2d3/qqNaX44I8aRg/mWLmiXh8jMBK31V
 PR22oZ4w7QTerKWA/41A8JFJ5ih1n9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-ZDULRSlBNIez6qQ1AoR_kQ-1; Tue, 03 Dec 2019 06:17:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 358DE8017DF;
 Tue,  3 Dec 2019 11:17:20 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E41619C69;
 Tue,  3 Dec 2019 11:17:13 +0000 (UTC)
Date: Tue, 3 Dec 2019 11:17:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191203111710.GC3078@work-vm>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
 <20191203105341.GB3078@work-vm>
 <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ZDULRSlBNIez6qQ1AoR_kQ-1
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
Cc: mszeredi@redhat.com, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Tue, 3 Dec 2019 at 10:53, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
> >
> > We seem to be coming to the conclusion something that:
> >
> >   a) It should live in the qemu tree
> >   b) It shouldn't live under contrib
> >   c) We'll create a new top level, i.e. 'daemons'
> >   d) virtiofsd will be daemons/virtiofsd
> >
> > Now, somethings I'm less clear on:
> >   e) What else would move into daemons?  It was suggested
> >     that if we've got virtiofsd in there, then we should move
> >     libvhost-user - which I understand, but then it's not a
> >     'daemons'.
> >     Are there any otehr daemons that should move?
>=20
> I like the idea of a new top level directory, but I think
> 'daemons' is a bit too specific -- for instance it seems to
> me that qemu-img would be sensible to move out of the root,
> and that's not a daemon.

What would your preference be?

Thomas was suggesting 'tools'.

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


