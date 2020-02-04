Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A76CC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B22820730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCRrJAcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B22820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1RB-0005bt-8j
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iz1QJ-0004RB-KE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iz1QH-0001Fh-B8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:51:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iz1QG-00017S-V9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580835095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hU46xAy8KR/D9WZae8pL7aYCQceYvO/qTNr1MfSOh68=;
 b=ZCRrJAcR7PREwegTBkxc/tn+ZC6guxUIzG06tz1g5xsIaJIzljYUgGanDcgOWI3GjdvqJh
 yNJJ3WITqsdLD+EddW/ySSS0DcKz3ynXDwlVqg2bRRGp/g6XkQ9oj7A4qpREsyLWEwE1LD
 KxELIxyddtQvl2kukFfgPZdDTZd+GMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-XClJPt5DO2asTuLdTfbZBg-1; Tue, 04 Feb 2020 11:51:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 284368C3422
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2BBF87EFF;
 Tue,  4 Feb 2020 16:51:26 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance/migration: Add the 'migration' tag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Oksana Vohchana <ovoshcha@redhat.com>
References: <20200204163304.14616-1-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <e27f3d4c-3824-7a9d-9435-ccade172bc32@redhat.com>
Date: Tue, 4 Feb 2020 14:51:23 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200204163304.14616-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: XClJPt5DO2asTuLdTfbZBg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Cleber Rosa <crosa@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/4/20 2:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> By using an Avocado tag, we can run all tests described by that
> tag as once:
>
>    $ avocado --show=3Dapp run -t migration tests/acceptance/
>    JOB ID     : 165477737509503fcfa6d7108057a0a18f2a6559
>    JOB LOG    : avocado/job-results/job-2020-02-04T17.29-1654777/job.log
>     (1/3) tests/acceptance/migration.py:Migration.test_migration_with_tcp=
_localhost: PASS (0.38 s)
>     (2/3) tests/acceptance/migration.py:Migration.test_migration_with_uni=
x: PASS (0.33 s)
>     (3/3) tests/acceptance/migration.py:Migration.test_migration_with_exe=
c: PASS (0.07 s)
>    RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <20200203111631.18796-1-ovoshcha@redhat.com>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg676230.html
> ---
>   tests/acceptance/migration.py | 3 +++
>   1 file changed, 3 insertions(+)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index 41b13b9e0d..b342cabe07 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -20,6 +20,9 @@ from avocado.utils.path import find_command
>  =20
>  =20
>   class Migration(Test):
> +    """
> +    :avocado: tags=3Dmigration
> +    """
>  =20
>       timeout =3D 10
>  =20


