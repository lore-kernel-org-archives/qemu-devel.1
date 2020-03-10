Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19491C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BA320727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2iUQO3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BA320727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjhH-0006BG-Vg
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBjg2-0004cp-JV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBjg0-0002zB-HS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:32:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBjg0-0002wI-DI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583865143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXuXw4DBaOzdg+q+VXm5E8SyfZQgxSIR7fPdakovdLE=;
 b=A2iUQO3vGjqGC50V6VTxCVDc7+EYL1noeAC7+BtwoYBVJIj59VfmTrxrOFI+VFxKaiBBke
 tX/JB8oWMqeLi5culSI4SCxDXoF6veckZXevpzvR3vGP7+NuMQ0OT3lQiWJh/qth91tuEk
 huEONhBW3oSIVvu7bafFgTg0GJCdo64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-x811HGBjPM69XTwHIAROvQ-1; Tue, 10 Mar 2020 14:32:21 -0400
X-MC-Unique: x811HGBjPM69XTwHIAROvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5587C100550E;
 Tue, 10 Mar 2020 18:32:20 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF2A87388D;
 Tue, 10 Mar 2020 18:32:18 +0000 (UTC)
Date: Tue, 10 Mar 2020 18:32:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: "Unknown option --exist" message when building qemu
Message-ID: <20200310183216.GE3304@work-vm>
References: <66841404-892f-edef-eb1a-37ed2e2e08ee@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <66841404-892f-edef-eb1a-37ed2e2e08ee@roeck-us.net>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Guenter Roeck (linux@roeck-us.net) wrote:
> Hi,
>=20
> when building qemu, I keep seeing the following message.
>=20
> Unknown option --exist
>=20
> This was introduced with commit 3a67848134d0 ("configure: Enable test and=
 libs for zstd").
> If I replace "--exist" with "--exists", on a system with libzstd-dev inst=
alled, I get
> a number of error messages.
>=20
> migration/multifd-zstd.c:125:9: error: unknown type name =E2=80=98ZSTD_En=
dDirective=E2=80=99; did you mean =E2=80=98ZSTD_DDict=E2=80=99?
> migration/multifd-zstd.c:125:35: error: =E2=80=98ZSTD_e_continue=E2=80=99=
 undeclared
> migration/multifd-zstd.c:128:21: error: =E2=80=98ZSTD_e_flush=E2=80=99 un=
declared
> migration/multifd-zstd.c:143:19: error: implicit declaration of function =
=E2=80=98ZSTD_compressStream2=E2=80=99
> migration/multifd-zstd.c:143:19: error: nested extern declaration of =E2=
=80=98ZSTD_compressStream2=E2=80=99
>=20
> Any idea, anyone, what might be wrong ?

Yep, Juan's just trying to fix it.

Dave

> Thanks,
> Guenter
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


