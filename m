Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2560DC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A9E24655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsLLpJr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A9E24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXuX-0005CA-LO
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iuXqN-0000Dg-0a
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iuXqM-0006xD-0w
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:28:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iuXqL-0006wt-U1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579768081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0pGTlu/qLAd1tPZ0Vp6WKFxgs274bN72X60GlWWxFI=;
 b=KsLLpJr4V3YoxNgVOedQuMXg+/gpXsz8bIC3i2y80Mwt4RJs/eogRrcOBCXRzLYks322YT
 lFGvrUHUy6eeRNZ5QE3Q4mzNjunqq+wDJWB5l/3l50AoBob6yChCeKjKoqAwzW3TEksee3
 Vv5EH7t8/hb5jwlRuuM+d6Acl2VHh58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-jPL44nrfOMWlNZPbX4xbkw-1; Thu, 23 Jan 2020 03:27:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13AF61005514;
 Thu, 23 Jan 2020 08:27:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4F0185743;
 Thu, 23 Jan 2020 08:27:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 66DEA1138600; Thu, 23 Jan 2020 09:27:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: Maintainers, please add Message-Id: when merging patches
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
 <87v9p3znas.fsf@linaro.org>
Date: Thu, 23 Jan 2020 09:27:54 +0100
In-Reply-To: <87v9p3znas.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 22 Jan 2020 12:30:03 +0000")
Message-ID: <871rrqbmr9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jPL44nrfOMWlNZPbX4xbkw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
>> Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag.  =
Hooray!
>>
>> Message-Id: references the patch email that a commit was merged from.
>> This information is helpful to anyone wishing to refer back to email
>> discussions and patch series.
>
> So I guess the ones that don't are maintainer originated patches unless
> you actively rebuild your trees from a posted series?

I recommend using the exact same workflow for constructing pull requests
whether you wrote the patches yourself or not.


