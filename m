Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1822DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA764206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYqd6OXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA764206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiNWQ-0007fC-Ui
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iiNUz-0006eT-Jh
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iiNUy-00036r-AI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:59:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iiNUy-000354-75
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576868379;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4AqWqefP0JwjVnCwFXCfweJnNCPq7aXkakT2Ovekpw=;
 b=HYqd6OXGlJ1YaQkpRvwRPX8wL7Zzy+IArgNpm0xkPy6hKtRhhpK1kVt0/6ZtYS2DKWxspj
 0pKRYPcVp97GTQoLcy+AaDsZtgx/H74sQCgGG6PzasbWRmQzoXvmr5Aqg3M+qXStqgDTo7
 llyu4S549llAPnm2cg5+7sxhUajbaz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51--oFvazA4Nz6xlLWaFqWktA-1; Fri, 20 Dec 2019 13:59:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E30E2275;
 Fri, 20 Dec 2019 18:59:36 +0000 (UTC)
Received: from redhat.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96B245D72B;
 Fri, 20 Dec 2019 18:59:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PULL 2/2] configure: Require Python >= 3.5
In-Reply-To: <20191220165141.2207058-3-ehabkost@redhat.com> (Eduardo Habkost's
 message of "Fri, 20 Dec 2019 13:51:41 -0300")
References: <20191220165141.2207058-1-ehabkost@redhat.com>
 <20191220165141.2207058-3-ehabkost@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 20 Dec 2019 19:59:28 +0100
Message-ID: <8736deakmn.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: -oFvazA4Nz6xlLWaFqWktA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Reply-To: quintela@redhat.com
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> wrote:
> Python 3.5 is the oldest Python version available on our
> supported build platforms, and Python 2 end of life will be 3
> weeks after the planned release date of QEMU 4.2.0.  Drop Python
> 2 support from configure completely, and require Python 3.5 or
> newer.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Message-Id: <20191016224237.26180-1-ehabkost@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

But once here, a comment telling why we want 3.5, not 3.4 or 3.6 will
have been helpful.

Later, Juan.


