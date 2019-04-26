Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D85C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03B520656
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03B520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJv2O-0004sV-2Z
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 03:12:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJv1c-0004WF-Sk
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJv1b-0000MR-U8
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:12:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJv1b-0000I2-OE
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:11:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CAFD30ADBC3
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:11:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96A0D600C0;
	Fri, 26 Apr 2019 07:11:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id BB67411AAA; Fri, 26 Apr 2019 09:11:52 +0200 (CEST)
Date: Fri, 26 Apr 2019 09:11:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190426071152.fxsicstylxa3bk3e@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423132004.13725-3-marcandre.lureau@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 26 Apr 2019 07:11:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 02/11] Add vhost-user-input-pci
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426071152.1jccZwc20FDqmKU2eQzeVQY3Odrs0xyfT7NUFH9K-bg@z>

> +static void vhost_input_get_config(VirtIODevice *vdev, uint8_t *config_data)
> +{
> +    VirtIOInput *vinput = VIRTIO_INPUT(vdev);
> +    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
> +    int ret;
> +
> +    memset(config_data, 0, vinput->cfg_size);
> +
> +    ret = vhost_dev_get_config(&vhi->vhost->dev, config_data, vinput->cfg_size);
> +    if (ret) {
> +        error_report("vhost-user-input: get device config space failed");
> +        return;
> +    }
> +}
> +
> +static void vhost_input_set_config(VirtIODevice *vdev,
> +                                   const uint8_t *config_data)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
> +    int ret;
> +
> +    ret = vhost_dev_set_config(&vhi->vhost->dev, config_data,
> +                               0, sizeof(virtio_input_config),
> +                               VHOST_SET_CONFIG_TYPE_MASTER);
> +    if (ret) {
> +        error_report("vhost-user-input: set device config space failed");
> +        return;
> +    }
> +
> +    virtio_notify_config(vdev);
> +}

These two look rather generic, the only virtio-input specific thing is
the config space size.  Can we store the size somewhere, then move the
functions to common vhost-user code?

cheers,
  Gerd


