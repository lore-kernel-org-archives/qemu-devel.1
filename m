Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328E5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 12:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC42C206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 12:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVyW1h/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC42C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUV08-0001Xt-0t
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 07:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUUz2-0000iE-G6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 07:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUUz1-0003uO-81
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 07:09:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40813
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUUz1-0003uK-4t
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 07:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573560558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gvYWhnobCrZkJKh7e8ugpGPy22zr78ITqyoRf2iztQ=;
 b=YVyW1h/DXlyh0lInooX0FYgqTxIN17zttZVbWZKfIKVjDAV0tAJ1186ms9aV63z32ZI5ul
 g6zqOjijtqIp6OXk2XrjFNgvN4ZlQqftJvZsbVfjvlZHyXSglAzvhmAG/gojnAvAZa/8ZN
 YcKRTaHnNW1chonWFfznyvpknXJMUpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-mT5U7TolNVqUO6E2RE-Hig-1; Tue, 12 Nov 2019 07:09:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CDCA1800D63;
 Tue, 12 Nov 2019 12:09:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D0E460A35;
 Tue, 12 Nov 2019 12:09:09 +0000 (UTC)
Subject: Re: [qemu-web PATCH v3] documentation: link to nightly documentation
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191108105435.403161-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3fa14fbe-32e1-9bed-2557-428343deedd1@redhat.com>
Date: Tue, 12 Nov 2019 13:09:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191108105435.403161-1-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: mT5U7TolNVqUO6E2RE-Hig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2019 11.54, Stefan Hajnoczi wrote:
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
>=20
> diff --git a/documentation.md b/documentation.md
> index f4ef9f4..5198e02 100644
> --- a/documentation.md
> +++ b/documentation.md
> @@ -3,6 +3,8 @@ title: QEMU documentation
>  permalink: /documentation/
>  ---
> =20
> +The latest development version documentation is available [here](https:/=
/qemu.org/docs/master/index.html).
> +
>  The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be re=
ad online, courtesy of Stefan Weil.

I assume your generated docs will also contain the qemu-doc.html for the
users? Should we then remove the link to weilnetz here?

>  More documentation is found in the <a href=3D"https://git.qemu.org/?p=3D=
qemu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
>  directory of the QEMU git tree.

Do we still need the link to the docs folder in the git repo after your
changes?

 Thomas


