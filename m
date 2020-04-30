Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BE4C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6E120838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxZMQl/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6E120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU47p-0007Fd-In
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU473-0006f9-NX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU473-0001IK-4v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:00:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jU472-0001ID-N3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588233603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vto5OXL63uz/ONg0KMGXZsV9o7cG+W2gMq0zVSb9uQM=;
 b=JxZMQl/WJLj3OLhR9t2JCun5e2JpTW3KfNbOSgpLlLkUovUuSp1UoU+aFI1oDglHm2eD12
 KPZiXzOkmXVnea6Sgenm+Jf8sONT9+Ln2RWgzmS8tu74Z1LG48g7mZ6xzZBZyav6+Qn8ij
 J4iXQVL4JI7nvXCAH7O84Zruz6KyRjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-LDW6e1blNXu3JcZtzD2SnQ-1; Thu, 30 Apr 2020 03:59:58 -0400
X-MC-Unique: LDW6e1blNXu3JcZtzD2SnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D45107B798;
 Thu, 30 Apr 2020 07:59:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48FEC5EDE8;
 Thu, 30 Apr 2020 07:59:52 +0000 (UTC)
Date: Thu, 30 Apr 2020 09:59:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: Cover the GDB Python scripts in the
 gdbstub section
Message-ID: <20200430075950.GA6578@linux.fritz.box>
References: <20200430065720.10763-1-f4bug@amsat.org>
 <20200430065720.10763-2-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200430065720.10763-2-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.04.2020 um 08:57 hat Philippe Mathieu-Daud=E9 geschrieben:
> Keep an eye on these "same same, but different" files.
>=20
> Acked-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cbc1fac2b..7a7f2b9c31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2083,6 +2083,7 @@ R: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>  S: Maintained
>  F: gdbstub*
>  F: gdb-xml/
> +F: scripts/qemugdb/

Wouldn't it make sense to add scripts/qemu-gdb.py as well?

Kevin


