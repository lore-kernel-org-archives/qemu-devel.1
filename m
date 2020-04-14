Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC5C352BE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4112074D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgx0G2U1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4112074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORIg-0000qh-Vs
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 15:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jORHN-0000J1-Tf
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jORHM-00022L-FZ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:31:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jORHM-00021r-CG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586892686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bOPVNhGDeFsjF9GoaRwAGC50NrKj6vfJtUdo46MetY=;
 b=hgx0G2U1LwPNgatunI0DKQwNxDHeM1NPetceHkWqxMyXhepS8Ba4ihmtUGAVIaTo3Mu4pL
 yW0k+Dq6Obv9/7KAfW1jA3ng+DlASvZS4xImKd9zFcvW1utX3LQX9VOl0j1THRsqbr7PaA
 EACMvDYK4wy+gNVfgSqeSsWCDVzfx7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-f7Sn0nPLPUavuLFq4dVIcw-1; Tue, 14 Apr 2020 15:31:23 -0400
X-MC-Unique: f7Sn0nPLPUavuLFq4dVIcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6268813FC;
 Tue, 14 Apr 2020 19:31:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 300902718F;
 Tue, 14 Apr 2020 19:31:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A906511385C8; Tue, 14 Apr 2020 21:31:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Toe Dev <devtoe82@gmail.com>
Subject: Re: cscope redundant chars
References: <CAN+O=T+bk=hXjPF67R=YHKebcuMP2dGzT_qXPWMUp=RvWOPxOw@mail.gmail.com>
Date: Tue, 14 Apr 2020 21:31:20 +0200
In-Reply-To: <CAN+O=T+bk=hXjPF67R=YHKebcuMP2dGzT_qXPWMUp=RvWOPxOw@mail.gmail.com>
 (Toe Dev's message of "Tue, 14 Apr 2020 17:35:50 +0300")
Message-ID: <87ftd5oodz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Toe Dev <devtoe82@gmail.com> writes:

> add cscope phony(ctags have one) and remove redundancy
>
> diff --git a/Makefile b/Makefile
> index 84ef881600..9cf62532f9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1005,16 +1005,18 @@ ctags:
>         rm -f tags
>         find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
>
> +.PHONY: cscope
> +
> +cscope:
> +       rm -f cscope.*
> +       find $(SRC_PATH) -name "*.[chsS]" -print | sed 's,^\./,,' >
> "$(SRC_PATH)/cscope.files"
> +       cscope -b -q -k cscope.files
> +
>  .PHONY: TAGS
>  TAGS:
>         rm -f TAGS
>         find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
>
> -cscope:
> -       rm -f "$(SRC_PATH)"/cscope.*
> -       find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed 's,^\./,,' >
> "$(SRC_PATH)/cscope.files"
> -       cscope -b -i"$(SRC_PATH)/cscope.files"
> -

Can you explain why you drop $(SRC_PATH)/ before cscope.* and
cscope.files?

You also de-quote $(SRC_PATH).  Breaks when $(SRC_PATH) contains funny
characters like space.  I'm not having funny characters there is a good
idea, let alone that it works.  Still, I can't see why we should strip
quotes here.


