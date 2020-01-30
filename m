Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA58C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A361B206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6GX7tjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A361B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxic-0003HZ-Sy
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iwxhz-0002mw-T5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 19:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iwxhz-0001sf-11
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 19:29:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iwxhy-0001r8-Sq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 19:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580344162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fi2eDBSuxdfIYsIUjnM3VSpiM/8r9DeoW3vd4lBXuCM=;
 b=W6GX7tjR0NYe2nqD3/7otLt+ye90XIErnSGEhCWS8g8BdliUEycmHb6hcNNngJI9CG73N4
 LPBcZ9K9V5T+oyy8b1GOYlPSkxdzylW7K8BpPm10jJF2xU88ZfZlvRzCXDwbkXiSqBi/de
 8ZR4BDTz//YMaDK1f+3G3LZSh17wdaE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-4rV7XawXMzi33VJ-N9GAkw-1; Wed, 29 Jan 2020 19:29:20 -0500
X-MC-Unique: 4rV7XawXMzi33VJ-N9GAkw-1
Received: by mail-wr1-f71.google.com with SMTP id k18so868896wrw.9
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 16:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=WqI9SN3td3Cv+WjzpuVh/6ZvIzoOlE8LHcFFSgADh+I=;
 b=ivP9mCo7eMG9f7dN/zKDyoU+UlQkK/FN8y+On9ecf4VIDClLR4cnJq9mwXyOsO7p1W
 YxK2AMCu+AaQoUKgYLugClFtNqbCkBrrmlZwra52G5nxX/PGR7xuAatFn9LjXDYg083C
 68/UUcdxkmKhO7gxplvC2GamOqnHLamPuFibURg1e/7R0k8eYwsHmaNf7W2aaUNSUfQO
 T3T/tePWHgKPuEUiW9URZsLzNDE4nCElGAjsa1DP10kF6VvduvFEMsHQMnuTfHN9nlk0
 Emfdec0fE2fGi1piPOlQ+ztILLbec0fwZxCXKumws26jBFnAyWUntrsQVM2IviOmAGb1
 3m1A==
X-Gm-Message-State: APjAAAXYm0wYq3TGI2cHYzyXFDNZxUUK4hQlYlly5Xc4k/HchDxcpDbg
 jBZak8PyGG7SNOTCKJo3JJUNqAFdbK2hL1ExUYsXNcFlnpk/+qPwERsx9tPoC/Ae0RGjcVOBU+w
 odeMVw3lnJcx+wnk=
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr1834065wmc.165.1580344159261; 
 Wed, 29 Jan 2020 16:29:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwievO+Xtx0RKuN7b/MhfFAdXCuaMPmrDIUvWlTMOTsWjPAwPNn4QwR/X5LpMgzGoce9uDz/A==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr1834026wmc.165.1580344158895; 
 Wed, 29 Jan 2020 16:29:18 -0800 (PST)
Received: from [10.1.251.141] ([80.188.125.198])
 by smtp.gmail.com with ESMTPSA id q124sm12536514wme.2.2020.01.29.16.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 16:29:18 -0800 (PST)
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
To: Stefan Hajnoczi <stefanha@gmail.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
Date: Thu, 30 Jan 2020 01:29:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200129154438.GC157595@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V9PgSakstXKJuYDCPCMItsOcM66U7cGuz"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V9PgSakstXKJuYDCPCMItsOcM66U7cGuz
Content-Type: multipart/mixed; boundary="reFCw68PV0ynBGseQj8l6NlmLjOkbFk9N"

--reFCw68PV0ynBGseQj8l6NlmLjOkbFk9N
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29/01/20 16:44, Stefan Hajnoczi wrote:
> On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote:
>> On Fri, 24 Jan 2020 10:01:57 +0000
>> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *=
vpci_dev, Error **errp)
>>>  {
>>>      VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
>>>      DeviceState *vdev =3D DEVICE(&dev->vdev);
>>> -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
>>> +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.conf;
>>> +
>>> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
>>> +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
>>> +        conf->num_queues =3D current_machine->smp.cpus;
>> This now maps the request vqs 1:1 to the vcpus. What about the fixed
>> vqs? If they don't really matter, amend the comment to explain that?
> The fixed vqs don't matter.  They are typically not involved in the data
> path, only the control path where performance doesn't matter.

Should we put a limit on the number of vCPUs?  For anything above ~128
the guest is probably not going to be disk or network bound.

Paolo


--reFCw68PV0ynBGseQj8l6NlmLjOkbFk9N--

--V9PgSakstXKJuYDCPCMItsOcM66U7cGuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl4yI1wACgkQv/vSX3jH
roNPfAf/ek8nDpe6SK47JUTwdBH6Ww0REcPD47plQEJnEkb3+KACWHOGFmBlms3+
QNTUvKR8R75ApOJ4HJy0Cvnjt/FhUkVe7isZaorY5J3AuBWOm25xIefVDDfpQnQi
T8CPoN9ZwxD96ZOkPhROq4IVY9V8D0EbdWSay8LJKhysegJxRgwXQRO3NI0Bf6MO
jDNWHK3wMH8c+Q6qvAu853K1K1UJnLnUisiZm3zwLHiFPoxAkiAMtP3HvhTejldF
I0PP5HAOHtz2R4+/fCDPZGCeGU31FhaWuKlWBLfl6eIze3+Vwhfst54G9sP/Z4Eu
g0RLfsg5tumnHEK+RLaC4mCrwE3qrw==
=W0+E
-----END PGP SIGNATURE-----

--V9PgSakstXKJuYDCPCMItsOcM66U7cGuz--


