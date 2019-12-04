Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB0AC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC552077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TO8uOoew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC552077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUiM-0007r2-FP
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1icUhh-0007Ke-3R
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1icUhf-0006Df-KP
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:28:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52908
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1icUhf-0006DY-Go
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575466106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZhH+3TpxcEDgCHzEzoyHzPp2D+CWOeAeZ7w0XgcrpY=;
 b=TO8uOoewK6F9T0GiHKp7R4GULgOmLa+XQsIQjo/QmKVMxe4gKASqZNJOL9+BpJBGSxbs0A
 X6iY+EldSrBHLiQpED9LKpRwZgEIL9RY3BDAxJkC9Y3wZ/ZIRwtGWEmjgr7KCs0nwX0f1w
 MsTynhVQZ+XClF3c8anIr7aJQV35hSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-Toxq1eOKPEWil_21CtKWEQ-1; Wed, 04 Dec 2019 08:28:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E953800D5C;
 Wed,  4 Dec 2019 13:28:22 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFCA019C6A;
 Wed,  4 Dec 2019 13:28:11 +0000 (UTC)
Date: Wed, 4 Dec 2019 14:28:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191204132810.GB20250@dhcp-200-226.str.redhat.com>
References: <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
 <20191203105341.GB3078@work-vm>
 <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
 <20191203111949.GB267814@redhat.com>
 <87o8wofsda.fsf@dusky.pond.sub.org>
 <20191204081726.md3qakjtszftnuag@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20191204081726.md3qakjtszftnuag@sirius.home.kraxel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Toxq1eOKPEWil_21CtKWEQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, mszeredi@redhat.com, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 vgoyal@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.12.2019 um 09:17 hat Gerd Hoffmann geschrieben:
>   Hi,
>=20
> > >     |   ...
> > >     +- qemu-edid
> >=20
> > Has its own MAINTAINERS section, together with hw/display/edit* and
> > include/hw/display/edid.h.  I'm not sure moving it hw/display/ is a goo=
d
> > idea.  Gerd?
>=20
> Sort-of makes sense.  My personal preference would be a tools/ directory
> for all those small utilities though.

I think I would like that better than throwing tools into block/ where
currently mostly just block drivers live.

Or, if we want to move the tools there, we'd need another directory
level inside block/ to keep things reasonably organised.

Kevin


