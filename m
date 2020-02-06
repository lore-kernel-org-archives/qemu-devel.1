Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331C0C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B5B24671
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMkFeVO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B5B24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izj4C-0007c7-60
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izj2y-00076X-9K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izj2x-000743-6K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:26:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51128
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izj2x-00070I-1l
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581002786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbenE6pHFv0pF4w3S8F6W9oy2mNK68+5zpziYzu70DU=;
 b=DMkFeVO+ZDqsSep3BnwgdaoMIODJODwx+DUVYT1AmWa3WrjGy+JG0DeJiG3IV9y1po8+Uq
 iAWp2x4Y5vKcrksp2u/kQicYNLVwCkKK8JLgcCYMReagEp4zKjEtPwz0zVINZUWP8FdZHN
 BjTxlt2FEyjOpxzc+0JzdMz6qvYrNe4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-humTld3XMImy2KMcfwFYdA-1; Thu, 06 Feb 2020 10:26:09 -0500
Received: by mail-wr1-f69.google.com with SMTP id p8so3580339wrw.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 07:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DloW4Zqc0R1JqTalCyF7RGK73tFLuZh9WUOKZX9hxpc=;
 b=XZjoeOEXvaGdqnI8BPtFba64JALZK83kCUcDG3rpHEgZnDq8qhuddWKC4cwl1zHo6M
 4tSRwNfsAPfFrCzl98tiSzL0pBdxB3PTnEfaACIGChNLr3ri9QjWxL8pg/toJ49VBenX
 s+Je94BmgoE2DPFO8SXa6X8DvmN+r/iRHbVY8FQa2wugmkJXFSMlu/AI1YAxMHpijwOF
 NNk8afwkkp/SK8pa7peUeoAgYvzbS1/6U5cJZXS+t9JwAHhUzveX2yzhuQ6InQ2bRAaK
 /CNz7XxyqQUK/v/IF3BU4DEfF/xI/eFQNDZs5nFma6aVuTnlQ0jQR3jTL8QOX1G/Zjcu
 uyQQ==
X-Gm-Message-State: APjAAAVUEV+KJhbmy955iK00MWp8AUcRiqLUShF9nlJcQfPJc+7o9ok7
 jpotcWboy7qemkiZNmDFJahVqxgsctU0ZPWYQa03Xs+pfIl0GlU66fGDpG4WZPLJRoa8cLKRhvH
 xbJ6VUBvNZMHchic=
X-Received: by 2002:a5d:4702:: with SMTP id y2mr4162820wrq.37.1581002765695;
 Thu, 06 Feb 2020 07:26:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzI4OJtfXF4EJQIYQPi5IvVOOfpU3m7/U8Dji0LzuQkTZdJxaZcP9EBg7ZIsD8ceyzdzTyeow==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr4162804wrq.37.1581002765517;
 Thu, 06 Feb 2020 07:26:05 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v22sm3961226wml.11.2020.02.06.07.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 07:26:05 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance/migration: Add the 'migration' tag
To: qemu-devel@nongnu.org, Oksana Vohchana <ovoshcha@redhat.com>
References: <20200204163304.14616-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0fc64b23-9eba-f2ee-3c45-e0c3c1a90171@redhat.com>
Date: Thu, 6 Feb 2020 16:26:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204163304.14616-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: humTld3XMImy2KMcfwFYdA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Cleber Rosa <crosa@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 5:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> By using an Avocado tag, we can run all tests described by that
> tag as once:
>=20
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
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <20200203111631.18796-1-ovoshcha@redhat.com>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg676230.html
> ---
>   tests/acceptance/migration.py | 3 +++
>   1 file changed, 3 insertions(+)
>=20
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
>=20

Patch applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


