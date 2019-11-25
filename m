Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23767C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B432068F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpYuTBHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B432068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGvC-0001Z1-2k
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iZGuQ-00012q-1O
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iZGuL-0005MG-58
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:08:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iZGuL-0005Lu-1g
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574698092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcHeLggm8U7AYCAldPEeSkssio2+cVbhEQ7E6UFFZSw=;
 b=HpYuTBHeMOpAaDrmz4xHBBPbxrAO+EaNZsEpqXdN2CEKfcqCyUV4qvqWzluQIJiPGGkKNn
 VTVuajRSX4Q2n1FrkPSCx2urc2GdpW9RqOQMrMZy1XyaRDG1AsNXWWPMOtuA2zcfX0F4hC
 qaOYurq3IhwmbgFghh6ozLWbjyIT+AM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-h6HRNuK2O5WpKUlo0UMCDw-1; Mon, 25 Nov 2019 11:08:11 -0500
Received: by mail-wm1-f69.google.com with SMTP id m68so6749727wme.7
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 08:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xA6WjjsQ87LlpBSLAXxhKC1Zx0zh01ORh4rckhmP5C4=;
 b=VVbeVfl0XLxhsSIV7qQqHpwMgNHFICZg91cSdcHea7hSjHir7lINooxdOQQr+9eBj1
 qXIcDfbqc/oFrWpJ4C4as7pbbC0N/96cXGyURHdtVAT/AE2DZypUXgbF3uKvGzyh+SO6
 vBwGGipQpRl24vGnGHWoOPe/jE85CERMWnXJ+1JGNvinyDvEWntVjDFTLl6aFcgXldxy
 0U+Ss4AKvIJebNWq7c2ANDB9jezN25+r7FBy44n9lML8h0i+yD6onXA7sGN7KDgDjYjS
 NbQQV2b3ZQmAkkeNm2N42BlQfXPfhNOOJdq3sjaQbQNB5amjNkuFpl2MM/lIsWGnP+6s
 vYOw==
X-Gm-Message-State: APjAAAVYT3TNKhEE/xVYwjvZobRBJS+BdtqqQhVFTQCK8sHoaRdSIbc/
 6NHc+nGVn6Xtyv3Dny4O6Ghja/QX6K3+hQ5Zk2USMWEMjQ5a3og7IURY64t20ycUgzP2tVB943i
 /wctWEyj0gGhmfN0=
X-Received: by 2002:a5d:5284:: with SMTP id c4mr31132072wrv.376.1574698089543; 
 Mon, 25 Nov 2019 08:08:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFBZkFJRWlTUJ0LW8liXXvnp83EvNPDRc7oUzQHeoYWM9euGaVpD7J1g29lszyuMvS3k9qzg==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr31132047wrv.376.1574698089301; 
 Mon, 25 Nov 2019 08:08:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5454:a592:5a0a:75c?
 ([2001:b07:6468:f312:5454:a592:5a0a:75c])
 by smtp.gmail.com with ESMTPSA id j11sm10879632wrq.26.2019.11.25.08.08.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 08:08:08 -0800 (PST)
Subject: Re: [PULL 4/4] net/virtio: return error when device_opts arg is NULL
To: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org
References: <1574696407-4188-1-git-send-email-jasowang@redhat.com>
 <1574696407-4188-5-git-send-email-jasowang@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f5310f3-52fa-2cf6-9850-0224c8e093d0@redhat.com>
Date: Mon, 25 Nov 2019 17:08:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1574696407-4188-5-git-send-email-jasowang@redhat.com>
Content-Language: en-US
X-MC-Unique: h6HRNuK2O5WpKUlo0UMCDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/11/19 16:40, Jason Wang wrote:
> From: Jens Freimann <jfreimann@redhat.com>
>=20
> This fixes CID 1407222.
>=20
> Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/virtio-net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 565dea0..3c31471 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2880,9 +2880,12 @@ static int virtio_net_primary_should_be_hidden(Dev=
iceListener *listener,
>              QemuOpts *device_opts)
>  {
>      VirtIONet *n =3D container_of(listener, VirtIONet, primary_listener)=
;
> -    bool match_found;
> -    bool hide;
> +    bool match_found =3D false;
> +    bool hide =3D false;
> =20
> +    if (!device_opts) {
> +        return -1;
> +    }
>      n->primary_device_dict =3D qemu_opts_to_qdict(device_opts,
>              n->primary_device_dict);
>      if (n->primary_device_dict) {
> @@ -2890,7 +2893,7 @@ static int virtio_net_primary_should_be_hidden(Devi=
ceListener *listener,
>          n->standby_id =3D g_strdup(qdict_get_try_str(n->primary_device_d=
ict,
>                      "failover_pair_id"));
>      }
> -    if (device_opts && g_strcmp0(n->standby_id, n->netclient_name) =3D=
=3D 0) {
> +    if (g_strcmp0(n->standby_id, n->netclient_name) =3D=3D 0) {
>          match_found =3D true;
>      } else {
>          match_found =3D false;
>=20

It can't be NULL though, can it?  It is called from a qemu_foreach_opt
callback on device_opts itself.  This can be "re-fixed" in 5.0 though,
no hurry.

Paolo


