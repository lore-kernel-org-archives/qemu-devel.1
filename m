Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C34C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7322075F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSmoTxao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7322075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZUPU-00043U-Ox
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZUOO-0002of-1e
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:04:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZUOL-0004qZ-S0
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589526260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=lVBEGrx8X0JvmeMjd+Vcs80o2RNVnmpMSFzTbcM5x/0=;
 b=FSmoTxaoodJhQ+HuCBpOKLXff18Vvv0PjSTxJzuL8xXNHTZYvJllYqmfOOn7ySb7/QsY8u
 0FQ3amzPfRhW4rTc3b9YQ21KERp8fvCfocUYYtnZ+VMxbcWaajuZBM6aUjMvjMLCNCwSpz
 LNpFbrGGIAnNI7+JaJiQ32f3Bulvnyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-G7TEu3MINnu4hig9R8I2QQ-1; Fri, 15 May 2020 03:04:18 -0400
X-MC-Unique: G7TEu3MINnu4hig9R8I2QQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0704D8015D2;
 Fri, 15 May 2020 07:04:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-42.ams2.redhat.com [10.36.113.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFC1B7D970;
 Fri, 15 May 2020 07:04:16 +0000 (UTC)
Subject: Re: [PATCH 1/3] docs/s390x: document the virtual css
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
References: <20200505135025.14614-1-cohuck@redhat.com>
 <20200505135025.14614-2-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7876d0f3-7bb9-38b9-6675-94ba6bd47a1a@redhat.com>
Date: Fri, 15 May 2020 09:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200505135025.14614-2-cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/2020 15.50, Cornelia Huck wrote:
> Add some hints about "devno" rules.

Thanks a lot for doing this, some documentation in this area is
extremely useful!

> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  docs/system/s390x/css.rst    | 64 ++++++++++++++++++++++++++++++++++++
>  docs/system/target-s390x.rst |  1 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 docs/system/s390x/css.rst
> 
> diff --git a/docs/system/s390x/css.rst b/docs/system/s390x/css.rst
> new file mode 100644
> index 000000000000..8e18194a2f0a
> --- /dev/null
> +++ b/docs/system/s390x/css.rst
> @@ -0,0 +1,64 @@
> +The virtual channel subsystem
> +=============================
> +
> +QEMU implements a virtual channel subsystem with subchannels, (mostly
> +functionless) channel paths, and channel devices (virtio-ccw, 3270, and
> +devices passed via vfio-ccw). It supports multiple subchannel sets (MSS) and
> +multiple channel subsystems extended (MCSS-E).
> +
> +All channel devices support the ``devno`` property, which takes a parameter
> +in the form ``<cssid>.<ssid>.<device number>``.
> +
> +The default channel subsystem image id (``<cssid>``) is ``0xfe``. Devices in
> +there will show up in channel subsystem image ``0`` to guests that do not
> +enable MCSS-E. Note that devices with a different cssid will not be visible
> +if the guest OS does not enable MCSS-E (which is true of all supported guest
> +operating systems today).
> +
> +Supported values for the subchannel set id (``<ssid>``) range from ``0-3``.
> +Devices with a ssid that is not ``0`` will not be visible if the guest OS
> +does not enable MSS (any Linux version that supports virtio also enables MSS).
> +Any device may be put into any subchannel set, there is no restriction by
> +device type.
> +
> +The device number can range from ``0-0xffff``.
> +
> +If the ``devno`` property is not specified for a device, QEMU will choose the
> +next free device number in subchannel set 0, skipping to the next subchannel
> +set if no more device numbers are free.
> +
> +QEMU places a device at the first free subchannel in the specified subchannel
> +set. If a device is hotunplugged and later replugged, it may appear at a
> +different subchannel. (This is similar to how z/VM works.)
> +
> +
> +Examples
> +--------
> +
> +* a virtio-net device, cssid/ssid/devno automatically assigned::
> +
> +    -device virtio-net-ccw
> +
> +  In a Linux guest (without default devices and no other devices specified
> +  prior to this one), this will show up as ``0.0.0000`` under subchannel
> +  ``0.0.0000``.

Maybe mention the QEMU side again, e.g. that when you run "info qtree"
in the HMP monitor, you see the device with dev_id = "fe.0.0000".

> +* a virtio-rng device in subchannel set ``0``::
> +
> +    -device virtio-rng-ccw,devno=fe.0.0042
> +
> +  If added to the same Linux guest as above, it would show up as ``0.0.0042``
> +  under subchannel ``0.0.0001``.

Does "same" matter here? Otherwise, maybe just say "to a Linux guest" ?

> +* a virtio-gpu device in subchannel set ``2``::
> +
> +    -device virtio-gpu-ccw,devno=fe.2.1111
> +
> +  If added to the same Linux guest as above, it would show up as ``0.2.1111``
> +  under subchannel ``0.2.0000``.

Dito.

> +* a virtio-mouse device in a non-standard channel subsystem::
> +
> +    -device virtio-mouse-ccw,devno=2.0.2222
> +
> +  This would not show up in a standard Linux guest.

Ok ... and what happens if you use devno=0.0.1234 ? Will that then show
up under fe.0.1234 in the guest??

 Thomas


