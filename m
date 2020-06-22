Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E87C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 04:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0383B204EA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 04:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUJQ0Hl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0383B204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnDrX-00007m-5m
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 00:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnDqt-0008AG-Fs
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 00:14:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40241
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnDqq-00064a-Mu
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 00:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592799270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDVujG5YIP5sR17VZnik7gSv5HFyvnNGcTVyllDvP3Q=;
 b=JUJQ0Hl2Vxnh6t3rfUaXbScXz3LMYYFcJ40IhNZqImRSI4o9SetUof0dafPaMMCX8U0w8D
 O0+X9RWwqkSpg0NY/zZs7/Rldd7WeZ8nwn+TYoveY/KTeGoymNfNepH6REO+3KRVn10icn
 CWDPCmyQYORzvv+QtCRqGgXH0vFu2FY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-dSZwS5rMPu-QQkpaXkm0zg-1; Mon, 22 Jun 2020 00:14:22 -0400
X-MC-Unique: dSZwS5rMPu-QQkpaXkm0zg-1
Received: by mail-wr1-f69.google.com with SMTP id i10so6338945wrn.21
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 21:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qDVujG5YIP5sR17VZnik7gSv5HFyvnNGcTVyllDvP3Q=;
 b=BwQrthEh8BMKum9nxspyx21LJjSVU5QZSEc4YztMKf6YyOoULRb3rpYl9AY+8bGsgL
 8ZLfI6LiQzsVGjQ3uYMjukQa/EqmLHBVLMx9VvWXlt1RavEJETONBFD9HHqlRmGmYwOM
 xp/+idN92NxIp205iUrof3WO09Z184P4mf2ju2IX+y2xRWj0+5mJkJUS7vJS+KebFJhN
 +NtjNrRAv6Tv0i61IP3V03pdIhOVSCskR0lUCevpqusbyU9bZqomBK7CgiFNmJi4+Mbi
 kf/97A770rSub3TxAVmBpNqvBRW5eX9z4JNvrs1chK/v3U9z0wkKfExo54BNmNLMXCaI
 Sc8A==
X-Gm-Message-State: AOAM533lxDDPai/6ySkbXZmfXrn5p9+KjUr/ETvzFw47+xtTMa0parOd
 WwnBM97919+vppR3zO+3mAv8bCUOGmtQWB35cxnrJXb6ZkXxJK33aSjgtHSxGCpv3lhimf+AfAa
 uLA638Q+Upq6/C/A=
X-Received: by 2002:a5d:4244:: with SMTP id s4mr14563387wrr.5.1592799261719;
 Sun, 21 Jun 2020 21:14:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaGw3UYAs7biqIrzzV5D3TfaJE3gJTjTXL76UHihQB/WLDkGBcvXkYiAZjo4ZQvicFemLieA==
X-Received: by 2002:a5d:4244:: with SMTP id s4mr14563324wrr.5.1592799260696;
 Sun, 21 Jun 2020 21:14:20 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id t5sm4455111wrp.84.2020.06.21.21.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 21:14:20 -0700 (PDT)
Date: Mon, 22 Jun 2020 00:14:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH 5/6] virtio-serial-bus: add terminal resize messages
Message-ID: <20200622001332-mutt-send-email-mst@kernel.org>
References: <20200621162132.62797-1-noh4hss@gmail.com>
 <20200621162132.62797-6-noh4hss@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200621162132.62797-6-noh4hss@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 00:14:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, pbonzini@redhat.com, amit@kernel.org,
 qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 21, 2020 at 06:21:31PM +0200, Szymon Lukasz wrote:
> Implement the part of the virtio spec that allows to notify the virtio
> driver about terminal resizes. The virtio spec contains two methods to
> achieve that:
> 
> For legacy drivers, we have only one port and we put the terminal size
> in the config space and inject the config changed interrupt.
> 
> For multiport devices, we use the control virtqueue to send a packet
> containing the terminal size. Note that the Linux kernel expects
> the fields indicating the number of rows and columns in a packet to be
> in a different order than the one specified in the current version of
> the virtio spec. We follow the Linux implementation, so hopefully there
> is no implementation of this functionality conforming to the spec.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> ---
>  hw/char/trace-events              |  1 +
>  hw/char/virtio-serial-bus.c       | 41 +++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio-serial.h |  5 ++++
>  3 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index d20eafd56f..be40df47ea 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -10,6 +10,7 @@ serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
>  
>  # virtio-serial-bus.c
>  virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
> +virtio_serial_send_console_resize(unsigned int port, uint16_t cols, uint16_t rows) "port %u, cols %u, rows %u"
>  virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
>  virtio_serial_handle_control_message(uint16_t event, uint16_t value) "event %u, value %u"
>  virtio_serial_handle_control_message_port(unsigned int port) "port %u"
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 262089c0c9..9d99161e13 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -261,6 +261,42 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
>      return send_control_msg(vser, &cpkt, sizeof(cpkt));
>  }
>  
> +/*
> + * This struct should be added to the Linux kernel uapi headers
> + * and later imported to standard-headers/linux/virtio_console.h
> + */
> +struct virtio_console_resize {
> +    __virtio16 rows;
> +    __virtio16 cols;
> +};
> +
> +void virtio_serial_send_console_resize(VirtIOSerialPort *port,
> +                                       uint16_t cols, uint16_t rows)
> +{
> +    VirtIOSerial *vser = port->vser;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
> +        struct {
> +            struct virtio_console_control control;
> +            struct virtio_console_resize resize;
> +        } buffer;
> +
> +        virtio_stl_p(vdev, &buffer.control.id, port->id);
> +        virtio_stw_p(vdev, &buffer.control.event, VIRTIO_CONSOLE_RESIZE);
> +        virtio_stw_p(vdev, &buffer.resize.cols, cols);
> +        virtio_stw_p(vdev, &buffer.resize.rows, rows);
> +
> +        trace_virtio_serial_send_console_resize(port->id, cols, rows);
> +        send_control_msg(vser, &buffer, sizeof(buffer));
> +
> +    } else if (virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
> +        vser->port0_cols = cols;
> +        vser->port0_rows = rows;
> +        virtio_notify_config(vdev);
> +    }
> +}
> +
>  /* Functions for use inside qemu to open and read from/write to ports */
>  int virtio_serial_open(VirtIOSerialPort *port)
>  {
> @@ -559,6 +595,7 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
>      vser = VIRTIO_SERIAL(vdev);
>  
>      features |= vser->host_features;
> +    virtio_add_feature(&features, VIRTIO_CONSOLE_F_SIZE);
>      if (vser->bus.max_nr_ports > 1) {
>          virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
>      }

Unconditonally adding a feature bit like that will break cross-version
migration. You need to add it through a bit property and
the disable for existing machine types.


> @@ -572,8 +609,8 @@ static void get_config(VirtIODevice *vdev, uint8_t *config_data)
>      struct virtio_console_config *config =
>          (struct virtio_console_config *)config_data;
>  
> -    config->cols = 0;
> -    config->rows = 0;
> +    config->cols = virtio_tswap16(vdev, vser->port0_cols);
> +    config->rows = virtio_tswap16(vdev, vser->port0_rows);
>      config->max_nr_ports = virtio_tswap32(vdev,
>                                            vser->serial.max_virtserial_ports);
>  }
> diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
> index ed3e916b68..1d6436c0b1 100644
> --- a/include/hw/virtio/virtio-serial.h
> +++ b/include/hw/virtio/virtio-serial.h
> @@ -188,6 +188,8 @@ struct VirtIOSerial {
>      virtio_serial_conf serial;
>  
>      uint64_t host_features;
> +
> +    uint16_t port0_cols, port0_rows;
>  };
>  
>  /* Interface to the virtio-serial bus */
> @@ -222,6 +224,9 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
>   */
>  void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
>  
> +void virtio_serial_send_console_resize(VirtIOSerialPort *port,
> +                                       uint16_t cols, uint16_t rows);
> +
>  #define TYPE_VIRTIO_SERIAL "virtio-serial-device"
>  #define VIRTIO_SERIAL(obj) \
>          OBJECT_CHECK(VirtIOSerial, (obj), TYPE_VIRTIO_SERIAL)
> -- 
> 2.27.0


