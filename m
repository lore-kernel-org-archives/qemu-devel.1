Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB242C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB46321D7B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAk2+BQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB46321D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT206-0004EA-Vh
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iT1xE-0001Pi-CU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iT1x8-0001nY-NJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:57:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37252
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iT1wq-0001fm-Hk
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573210620;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkBLH3nEOBS2VigPxe5xSX04LZYJbsJLTzWcJrNHoZk=;
 b=YAk2+BQ94Nc2HkouGRCbtlF0d0koMlPeLE2/tjOo8T1KZRofz8abI/UoY6oPVLM/By1ivN
 pKvI/7qRpqIFukKZK15JRujVKChVqGSbMKj2T6xp9LLPDZVh0puwhfLe06juQcGIbteCT+
 OtA8HmVSuA3sX2r3dRNnZW803+W2nk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-33fUGljMMTmWp9vDzIywtg-1; Fri, 08 Nov 2019 05:56:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6DF08017DD
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 10:56:57 +0000 (UTC)
Received: from redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A34C75D70E;
 Fri,  8 Nov 2019 10:56:51 +0000 (UTC)
Date: Fri, 8 Nov 2019 10:56:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [qemu-web PATCH v3] documentation: link to nightly documentation
Message-ID: <20191108105648.GE182396@redhat.com>
References: <20191108105435.403161-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191108105435.403161-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 33fUGljMMTmWp9vDzIywtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 11:54:35AM +0100, Stefan Hajnoczi wrote:
> Link to the documentation built from qemu.git/master once a day.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
>  * Use a qemu.org URL, not a wiki.qemu.org URL [danpb]
> v2:
>  * This revision was broken - please ignore! :)
> ---
>  documentation.md | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

(depends on the corresponding patch to qemu.git to generate the main
 index.html to be merged before this can be pushed I presume)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


