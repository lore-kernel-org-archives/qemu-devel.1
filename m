Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C8FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB96620678
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3mdIMdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB96620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixAue-0004bE-S4
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixAtu-00045B-Oa
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixAtt-0004qw-K6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:34:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37706
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixAtt-0004qZ-GH
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580394873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPSUVb6MzaF6rprazc+hsrUDCKr9uya0+zR9zr3B0wk=;
 b=E3mdIMdg/YvyTvSU43KKEpLaQkhrimf7Oj4gO4bIns201dbhOpF2H7mmKF8qgvv0fkrO0R
 XYpcQBvxLt1fxki84lehZOQakQyT+Ie6ZWop1psM58KkAedSvPQ1C5KbR3VvbnEnFjDQfD
 UcnM7pCOQTV0l9c5N1FTKzaFYleUrmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-O69FqmQHMeSNV4gB8-ZL2g-1; Thu, 30 Jan 2020 09:34:31 -0500
X-MC-Unique: O69FqmQHMeSNV4gB8-ZL2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89489801E6C;
 Thu, 30 Jan 2020 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 039F460C85;
 Thu, 30 Jan 2020 14:34:03 +0000 (UTC)
Subject: Re: [PATCH 05/10] tests/acceptance: Remove shebang header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200129231402.23384-1-philmd@redhat.com>
 <20200129231402.23384-6-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <838bf1fc-d607-7d0f-6d7c-40c4ce0bdba2@redhat.com>
Date: Thu, 30 Jan 2020 12:34:01 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200129231402.23384-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/29/20 9:13 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Patch created mechanically by running:
>
>    $ chmod 644 $(git grep -lF '#!/usr/bin/env python' | xargs grep -L '=
if __name__.*__main__')
>    $ sed -i "/^#\!\/usr\/bin\/\(env\ \)\?python.\?$/d" $(git grep -lF '=
#!/usr/bin/env python' | xargs grep -L 'if __name__.*__main__')
>
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/virtio_seg_max_adjust.py  | 1 -
>   tests/acceptance/x86_cpu_model_versions.py | 1 -
>   2 files changed, 2 deletions(-)
>   mode change 100755 =3D> 100644 tests/acceptance/virtio_seg_max_adjust=
.py


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptan=
ce/virtio_seg_max_adjust.py
> old mode 100755
> new mode 100644
> index 5458573138..8d4f24da49
> --- a/tests/acceptance/virtio_seg_max_adjust.py
> +++ b/tests/acceptance/virtio_seg_max_adjust.py
> @@ -1,4 +1,3 @@
> -#!/usr/bin/env python
>   #
>   # Test virtio-scsi and virtio-blk queue settings for all machine type=
s
>   #
> diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/accepta=
nce/x86_cpu_model_versions.py
> index 90558d9a71..01ff614ec2 100644
> --- a/tests/acceptance/x86_cpu_model_versions.py
> +++ b/tests/acceptance/x86_cpu_model_versions.py
> @@ -1,4 +1,3 @@
> -#!/usr/bin/env python
>   #
>   # Basic validation of x86 versioned CPU models and CPU model aliases
>   #


