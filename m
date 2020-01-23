Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF7CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E1A214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5hy5Mxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E1A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufiF-0000V3-8f
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iucxE-0005kV-Pz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iucxD-0003yV-CJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:55:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29455
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iucxD-0003yO-8y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Eol70sSh0AGb3La8He7y4mmd1rINOc8lYOm2TYWyYA=;
 b=K5hy5Mxg7OzcvXWbM76WIIdS5aPQco3yqwv4UbvL6KWvqrvo4qPiVErBw8EO6DoQwqI07a
 a3F6DCYLDIOiDZyIsNgp4QYXIwozlHLXHFl0/v73xzOMVtbZJPjeNcW3nJ+FLz9UVDsW5g
 G1b+bRYGRvdeAQUla6EuYn6oUikqITc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-RcD4rjskMmSJ2C8d1ILMVQ-1; Thu, 23 Jan 2020 08:55:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5906B107B270;
 Thu, 23 Jan 2020 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B06E85DA85;
 Thu, 23 Jan 2020 13:55:12 +0000 (UTC)
Subject: Re: [PATCH 1/6] tests/acceptance/virtio_seg_max_adjust: Only remove
 listed machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200122223247.30419-1-philmd@redhat.com>
 <20200122223247.30419-2-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <d9cc6a71-867d-c613-ba13-f5bc04670db0@redhat.com>
Date: Thu, 23 Jan 2020 11:55:10 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200122223247.30419-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: RcD4rjskMmSJ2C8d1ILMVQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

That fixes one of the problems I mention in another email thread. I was=20
working on a fix, so putting my hands off it. :)

Anyway, see some comments below.

On 1/22/20 8:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Do not remove unavailable machines, this fixes:
>
>    VirtioMaxSegSettingsCheck.test_machine_types: ERROR: list.remove(x): x=
 not in list (0.12 s)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/virtio_seg_max_adjust.py | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_seg_max_adjust.py
> index 5458573138..4a417b8ef5 100755
> --- a/tests/acceptance/virtio_seg_max_adjust.py
> +++ b/tests/acceptance/virtio_seg_max_adjust.py
> @@ -109,14 +109,15 @@ class VirtioMaxSegSettingsCheck(Test):
>           return False
>  =20
>       def test_machine_types(self):
> -        # collect all machine types except 'none', 'isapc', 'microvm'
> +        EXCLUDED_MACHINES =3D ['none', 'isapc', 'microvm']

I was going to suggest moving this constant declaration alongside the=20
others (VIRTIO_SCSI_PROPS, VIRTIO_BLK_PROPS...). But I saw on patch 04=20
that this variable can get updated, i.e. no longer it is a constant, so=20
I think it could be an object attribute instead. My reasoning is: it is=20
easier to figure out what to change (eventually) if it is an object=20
attribute or module constant.

Also if you want to make it further flexible, you can use Avocado's=20
parameters. Example:

excluded_machines =3D self.params.get('exclude_machines', default=3D['none'=
,=20
'isapc', 'microvm'])

I hope this helps.

- Wainer

> +        # collect all machine types except the ones in EXCLUDED_MACHINES
>           with QEMUMachine(self.qemu_bin) as vm:
>               vm.launch()
>               machines =3D [m['name'] for m in vm.command('query-machines=
')]
>               vm.shutdown()
> -        machines.remove('none')
> -        machines.remove('isapc')
> -        machines.remove('microvm')
> +        for m in EXCLUDED_MACHINES:
> +            if m in machines:
> +                machines.remove(m)
>  =20
>           for dev_type in DEV_TYPES:
>               # create the list of machine types and their parameters.


