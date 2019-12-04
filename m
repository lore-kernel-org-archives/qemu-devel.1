Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB86AC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734A720661
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvNDibg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734A720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUKf-0007ZP-Fc
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icUJb-00074i-8b
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icUJW-0004tS-Ei
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:03:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icUJW-0004tH-Av
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575464609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBLytfrs8PSNkFRyY3LZCuEYsoSA9L4lieJwU4EdJZs=;
 b=bvNDibg9UTvMf4EcnVMkvQicNM6Ref5wQMeGgV7B21hE6X9iXWhJQK2lyQWs+HWBsqG8Rl
 +801+aDcOz7Fxhu+Xf152Xj58c9dOi4GPiYUOd6brTl95wlhV2q+yWSqQos33PcBYUOd3+
 uD2cKWBaFVfWR240rsj2kHtxWqG0yns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-07U671x0Otib-66FymN0Hg-1; Wed, 04 Dec 2019 08:03:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 379E5802B35;
 Wed,  4 Dec 2019 13:03:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE0F8101E811;
 Wed,  4 Dec 2019 13:03:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F0CC1138606; Wed,  4 Dec 2019 14:03:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] error: rename errp to errp_in where it is IN-argument
References: <20191127183704.14825-1-vsementsov@virtuozzo.com>
 <878so05bca.fsf@dusky.pond.sub.org>
 <f901e0db-61df-898f-ce18-096bfeadf525@virtuozzo.com>
 <87mucf218w.fsf@dusky.pond.sub.org>
 <80e563ee-31fb-da43-ddde-c8666e4b92c6@virtuozzo.com>
 <87eexqda3c.fsf@dusky.pond.sub.org>
 <41f32448-f2b8-1822-25df-f02c61df9bc4@virtuozzo.com>
 <878snybrf7.fsf@dusky.pond.sub.org>
Date: Wed, 04 Dec 2019 14:03:25 +0100
In-Reply-To: <878snybrf7.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 29 Nov 2019 17:03:56 +0100")
Message-ID: <87blsob5uq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 07U671x0Otib-66FymN0Hg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>
>> 29.11.2019 17:35, Markus Armbruster wrote:
[...]
>>> I pushed my fixups to git://repo.or.cz/qemu/armbru.git branch error-pre=
p
>>> for your convenience.  The commit messages of the fixed up commits need
>>> rephrasing, of course.
>>>=20
>>
>> Looked through fixups, looks OK for me, thanks! What next?
>
> Let me finish my fixing incorrect dereferences of errp, and then we
> figure out what to include in v7.

Your v6 with my fixups does not conflict with my "[PATCH v2 00/18] Error
handling fixes", except for "hw/core/loader-fit: fix freeing errp in
fit_load_fdt", which my "[PATCH v2 07/18] hw/core: Fix fit_load_fdt()
error handling violations" supersedes.

Suggest you work in the fixups and post as v7.  I'll merge that in my
tree, to give you a base for the remainder of your "auto propagated
local_err" work.  While you work on that, I'll work on getting the base
merged into master.  Sounds like a plan?


