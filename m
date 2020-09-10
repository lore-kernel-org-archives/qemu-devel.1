Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7466C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C900F2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qn6YV/Uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C900F2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIOj-0003zL-Hw
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 04:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxime.coquelin@redhat.com>)
 id 1kGIOA-0003Z0-8f
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:57:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <maxime.coquelin@redhat.com>)
 id 1kGIO6-0000UE-Ki
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599728221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JjRrKYcaDycoy/FoZTa25it6Q19Y35T52byryqz7A4c=;
 b=Qn6YV/UolppYoYl+qH0CCU44SXPlf6m+MX0ebhxma+f2tKRFzGOCCbfRZI7yB7PxrdIRGo
 bx2meK8/KD9vRV0D408qMXGbqpajVHK6f+LAzTYYgFooPFIaTjLPViJn13NCVa5ze9LCq2
 zF1OK4wZpgxCQmow2BnIQT5EvtS9hOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-5kmlPwg2ORiKMYbjcM8UHg-1; Thu, 10 Sep 2020 04:55:19 -0400
X-MC-Unique: 5kmlPwg2ORiKMYbjcM8UHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69929801AB9;
 Thu, 10 Sep 2020 08:55:11 +0000 (UTC)
Received: from [10.36.110.16] (unknown [10.36.110.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AFA960BF1;
 Thu, 10 Sep 2020 08:55:08 +0000 (UTC)
Subject: Re: VHOST_USER_PROTOCOL_F_VDPA
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200821110822.GA205318@stefanha-x1.localdomain>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
Message-ID: <ea150955-fc89-147f-0fdc-1ff60b35a6e6@redhat.com>
Date: Thu, 10 Sep 2020 10:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821110822.GA205318@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=maxime.coquelin@redhat.com
X-Mimecast-Spam-Score: 0.326
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9HUv2wN3GCvIAPg2lMY8RjaJtAVT7IFbV"
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=maxime.coquelin@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Chenbo Xia <chenbo.xia@intel.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 kraxel@redhat.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Changpeng Liu <changpeng.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9HUv2wN3GCvIAPg2lMY8RjaJtAVT7IFbV
Content-Type: multipart/mixed; boundary="bpL1qVBHI2ZbOkeBHl3G9X6Bq8VUyLK6j";
 protected-headers="v1"
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Chenbo Xia <chenbo.xia@intel.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 kraxel@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>
Message-ID: <ea150955-fc89-147f-0fdc-1ff60b35a6e6@redhat.com>
Subject: Re: VHOST_USER_PROTOCOL_F_VDPA
References: <20200821110822.GA205318@stefanha-x1.localdomain>
In-Reply-To: <20200821110822.GA205318@stefanha-x1.localdomain>

--bpL1qVBHI2ZbOkeBHl3G9X6Bq8VUyLK6j
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On 8/21/20 1:08 PM, Stefan Hajnoczi wrote:
> The first vDPA ioctls have been added to the vhost-user protocol and I
> wonder if it's time to fully change the vhost-user protocol's focus to
> providing a full VIRTIO device model like vDPA does.
>=20
> Initially vhost-user was just used for vhost-net. As a result it didn't
> need the full VIRTIO device model including the configuration space and
> device status register.
>=20
> Over the years device-specific messages were added to extend vhost-user
> to cover more of the VIRTIO device model. vhost-user-blk needed
> configuration space support, for example.
>=20
> The problem for VMMs and device backend implementors is that the
> protocol is currently positioned halfway between the original vhost-net
> approach and the full VIRTIO device model. Even if a VMM implements
> VHOST_USER_GET_CONFIG, it can only expect it to work with
> vhost-user-blk, not vhost-user-net. Similarly, a vhost-user-net device
> backend cannot implement VHOST_USER_GET_CONFIG and expect all VMMs to
> allow it to participate in configuration space emulation because
> existing VMMs won't send that message.
>=20
> The current approach where each device type uses a undocumented subset
> of vhost-user messages is really messy. VMM and device backend
> implementors have to look at existing implementations to know what is
> expected for a given device type. It would be nice to switch to the
> VIRTIO device model so that the VIRTIO specification can be used as the
> reference for how device types work.
>=20
> Now that vDPA is here and extends the kernel vhost ioctls with a full
> VIRTIO device model, it might be a good time to revise the vhost-user
> protocol.
>=20
> A vdpa-user protocol (or vhost-user 2.0) would replace the current mess
> with a full VIRTIO device model. Both VMMs and device backends would
> require changes to support this, but it would be a cleaner path forward
> for the vhost-user protocol.
>=20
> One way of doing this would be a new VHOST_USER_PROTOCOL_F_VDPA feature
> bit that indicates all the currently existing Linux vDPA ioctl messages
> are available. Legacy vhost-user messages with overlapping functionality
> must not be used when this bit is set. Most importantly, device backends
> need to implement the full VIRTIO device model, regardless of device
> type (net, blk, scsi, etc).
>=20
> The device type most affected by this change would be virtio-net. The
> other device types are already closer to the full VIRTIO device model.
>=20
> I wanted to share this idea in case someone is currently trying to
> figure out how to add more VIRTIO device model functionality to
> vhost-user.
>=20
> Stefan
>=20

I understand the need and like the idea.

Maxime


--bpL1qVBHI2ZbOkeBHl3G9X6Bq8VUyLK6j--

--9HUv2wN3GCvIAPg2lMY8RjaJtAVT7IFbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEE3P4B0hLzOlwaL+KyjiNKEaHD4kFAl9Z6eoACgkQyjiNKEaH
D4lPwRAAkqeHcgVoj9qZ34KWw8UhRoOfkPhNO9B5cqFI0J2lqeKzgnOvkm5aTa8C
luQg+tag3Sz9IMEGTtONOoGhu5B+2uuEyS22ibYjmWZK386rzBkRk31r192BbSHe
bXlAXiRGcfZC0sNTtWfn18pAL+wdDYRllLbNEztPJA+fkHlo3Dl8sv0Jc6HwJXUh
dtsJ1JB1kz6cUdzNziHk9pu3d9Ul8BvTPfvgL2WiDPEhGwga6vsHmWF7ZKQ++pRn
VA9NY8tcmIbfWR6uxQWQiEMoRsW4yTYWrAlOmz+8lVQj5ia6QwQhfnt25jYs+Atp
FibHjWeAAxj/4akoRGagkqSEjwA143jOoSkOjJqWL8VIJUTxphS+HCHkgB+As6/q
vYFd3qtuzAIGmHUWiPWXeuoV9QEE0KAokwyBU3uLl28xoBhfoaQI404GYHuS8uGx
rfpXQWK5VO7muHGbgkCxxnk/mRj7XsP5IUP2SVB5VLuCtzD9UaEEKMhPjDBgTIbR
8jKEmkKRqhb6XIiQPGFMvVwb+6VUchfqJB4Fezks83/Oic0I2FFNa8txMCqnC7Zz
lL1lS7TTvR6pguu+3D/oliYMl8dDF3SJ+/NqWo+StiYvWwBbsT+Utf2373nl86uX
VRmPSRc3dmIzxgqN3YAAklSq2/z89KPzU5W2bXMfkrq/dgJ+APw=
=srOi
-----END PGP SIGNATURE-----

--9HUv2wN3GCvIAPg2lMY8RjaJtAVT7IFbV--


