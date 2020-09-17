Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4CCC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF866206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdxPQ5pN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF866206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwbB-0006at-Hm
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIwRb-0004il-OA
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:07:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33535
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIwRY-0005PX-Ry
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600358850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=583Sphf240XXswK6/Dx0U3zYzKResmLZ18k71zP1X/M=;
 b=TdxPQ5pNqHA4GHeD5q+rBC94iiS7d42wzjQ64/fe5J5q4FvOHJJm3NobyEcEM3YUeLd+aa
 qpg/IYIzpapOi8urXYsuX2apixIhFLz6NlNfSRpyyB5CArvHfnygpso+2n/6s0vQOGD91H
 IL8hfWgOfzRyKsknL8i3lD7zQgVDupI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-efHzKWRYPy-6vRzXIo0SiQ-1; Thu, 17 Sep 2020 12:07:12 -0400
X-MC-Unique: efHzKWRYPy-6vRzXIo0SiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A80991009464;
 Thu, 17 Sep 2020 16:07:09 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7894A55762;
 Thu, 17 Sep 2020 16:07:03 +0000 (UTC)
Message-ID: <b679e646f4dd8ebea753892c0cec27e54ba8f407.camel@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
From: Andrea Bolognani <abologna@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Sep 2020 18:07:00 +0200
In-Reply-To: <871rj0o1yk.fsf@dusky.pond.sub.org>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
 <9d4363e8-7bb8-8255-9914-6d9bc36cec79@redhat.com>
 <871rj0o1yk.fsf@dusky.pond.sub.org>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-09-17 at 17:30 +0200, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> > Sorry, I forgot to check Debian. If I got that right, Debian 9 still
> > uses Python 3.5 by default. So I guess that means we can not deprecate
> > Python 3.5 yet?
> 
> Discussed before:
> 
>     Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
>     Date: Sat, 18 Jan 2020 07:54:18 +0100
>     Message-ID: <87lfq5s19h.fsf@dusky.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg03855.html
> 
> Short version: Debian != Debian LTS.  We support Debian until EOL, not
> LTS.  Debian 9 reached EOL in July.

FWIW, this is the same policy the libvirt project follows, and we
have formalized it at

  https://libvirt.org/platforms.html

with Debian LTS being called out explicitly as not supported.

It would be *fantastic* if we could keep the platform support policy
used by QEMU and libvirt as aligned as reasonably possible.

-- 
Andrea Bolognani / Red Hat / Virtualization


