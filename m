Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F53C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5884D2081B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5884D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83IN-00080t-HV
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i83He-0007Xe-CY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i83Hb-0002ja-Bz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i83Hb-0002jB-3S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:07:43 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E30B50F45
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:07:41 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id t26so25204627qkt.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dYhVxqcCbCcbyYZmt8TR2bRddaTTMVOZuzcBDIYyNGk=;
 b=oWECWI3QxN4G+A4n95hRDAzibzMZlyMTP+/vw3W+RT7FfjndrhGpIhYtM9CcJRAex7
 edffvu/OkM1EXQzp4E+MWXF5mKG/kRAXgVVqJTMjzykYJyLGiCmHJnmfjiclU3uaOFeq
 zkePtYlJn0Ilh0ONyOr0BYuRpnatrWGnxLesLDZ8Zf5ZyIEBWkzCJ89WxlCkJy0KuGX1
 mOGcyjX8VPLx4CZEi3Qzkhz18kxICoNEOQ+X1tCRzysE2AF1YYHJb8/9lY7mFyhrSfLj
 0sCkjNCgbo4RDlHR3YDnWXRG4G1/PZJzyzH43PCQaJXGaFQnvpnvE15TYGjRwrBYBuuy
 C0Zw==
X-Gm-Message-State: APjAAAXT8ogZ6evMvLngzbah3SC2IbNjV4qEfd3q874z2LnF57srlSit
 jMOGkd2FLF/Riam3iauWhjQjD4zoXaXxpbdFyx6uepfbnid6jbOT4uc+KUyjV/sKMjhZbU5rZxU
 u9q7Hv6Ind5VPe+M=
X-Received: by 2002:ac8:51d2:: with SMTP id d18mr36362251qtn.377.1568210860359; 
 Wed, 11 Sep 2019 07:07:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxm7o0rL7qrze78GGauL7QlcUTk6JnkD56x0syc/77o+AbMivb9/mzU+7xIHXts/gXVvy0vmg==
X-Received: by 2002:ac8:51d2:: with SMTP id d18mr36362225qtn.377.1568210860132; 
 Wed, 11 Sep 2019 07:07:40 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id k11sm9272415qtp.26.2019.09.11.07.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 07:07:39 -0700 (PDT)
Date: Wed, 11 Sep 2019 10:07:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190911095650-mutt-send-email-mst@kernel.org>
References: <20190911134539.25650-1-johannes@sipsolutions.net>
 <20190911134539.25650-2-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911134539.25650-2-johannes@sipsolutions.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v2 1/2] docs: vhost-user: add in-band
 kick/call messages
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
Cc: qemu-devel@nongnu.org, Johannes Berg <johannes.berg@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 03:45:38PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> For good reason, vhost-user is currently built asynchronously, that
> way better performance can be obtained. However, for certain use
> cases such as simulation, this is problematic.
> 
> Consider an event-based simulation in which both the device and CPU
> have scheduled according to a simulation "calendar". Now, consider
> the CPU sending I/O to the device, over a vring in the vhost-user
> protocol. In this case, the CPU must wait for the vring interrupt
> to have been processed by the device, so that the device is able to
> put an entry onto the simulation calendar to obtain time to handle
> the interrupt. Note that this doesn't mean the I/O is actually done
> at this time, it just means that the handling of it is scheduled
> before the CPU can continue running.
> 
> This cannot be done with the asynchronous eventfd based vring kick
> and call design.
> 
> Extend the protocol slightly, so that a message can be used for kick
> and call instead, if VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS is
> negotiated. This in itself doesn't guarantee synchronisation, but both
> sides can also negotiate VHOST_USER_PROTOCOL_F_REPLY_ACK and thus get
> a reply to this message by setting the need_reply flag, and ensure
> synchronisation this way.
> 
> To really use it in both directions, VHOST_USER_PROTOCOL_F_SLAVE_REQ
> is also needed.
> 
> Since it is used for simulation purposes and too many messages on
> the socket can lock up the virtual machine, document that this should
> only be used together with the mentioned features.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  docs/interop/vhost-user.rst | 113 ++++++++++++++++++++++++++++++------
>  1 file changed, 96 insertions(+), 17 deletions(-)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 7827b710aa0a..c4396eabf9e9 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -2,6 +2,7 @@
>  Vhost-user Protocol
>  ===================
>  :Copyright: 2014 Virtual Open Systems Sarl.
> +:Copyright: 2019 Intel Corporation
>  :Licence: This work is licensed under the terms of the GNU GPL,
>            version 2 or later. See the COPYING file in the top-level
>            directory.
> @@ -279,6 +280,9 @@ If *master* is unable to send the full message or receives a wrong
>  reply it will close the connection. An optional reconnection mechanism
>  can be implemented.
>  
> +If *slave* detects some error such as incompatible features, it may also
> +close the connection. This should only happen in exceptional circumstances.
> +
>  Any protocol extensions are gated by protocol feature bits, which
>  allows full backwards compatibility on both master and slave.  As
>  older slaves don't support negotiating protocol features, a feature
> @@ -315,7 +319,8 @@ it until ring is started, or after it has been stopped.
>  
>  Client must start ring upon receiving a kick (that is, detecting that
>  file descriptor is readable) on the descriptor specified by
> -``VHOST_USER_SET_VRING_KICK``, and stop ring upon receiving
> +``VHOST_USER_SET_VRING_KICK`` (or receiving the in-band message
> +``VHOST_USER_VRING_KICK`` if negotiated) and stop ring upon receiving
>  ``VHOST_USER_GET_VRING_BASE``.
>  
>  While processing the rings (whether they are enabled or not), client
> @@ -767,24 +772,48 @@ When reconnecting:
>  #. Resubmit inflight ``DescStatePacked`` entries in order of their
>     counter value
>  
> +In-band notifications
> +---------------------
> +
> +In some limited situations (e.g. for simulation) it is desirable to
> +have the kick, call and error (if used) signals done via in-band
> +messages instead of asynchronous eventfd notifications. This can be
> +done by negotiating the ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS``
> +protocol feature.
> +
> +Note that due to the fact that too many messages on the sockets can
> +cause the sending application(s) to block, it is not advised to use
> +this feature unless absolutely necessary. It is also considered an
> +error to negotiate this feature without also negotiating
> +``VHOST_USER_PROTOCOL_F_SLAVE_REQ`` and ``VHOST_USER_PROTOCOL_F_REPLY_ACK``,
> +the former is necessary for getting a message channel from the slave
> +to the master, while the latter needs to be used with the in-band
> +notification messages to block until they are processed, both to avoid
> +blocking later and for proper processing (at least in the simulation
> +use case.) As it has no other way of signalling this error, the slave
> +should close the connection as a response to a
> +``VHOST_USER_SET_PROTOCOL_FEATURES`` message that sets the in-band
> +notifications feature flag without the other two.
> +
>  Protocol features
>  -----------------
>  
>  .. code:: c
>  
> -  #define VHOST_USER_PROTOCOL_F_MQ             0
> -  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD      1
> -  #define VHOST_USER_PROTOCOL_F_RARP           2
> -  #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
> -  #define VHOST_USER_PROTOCOL_F_MTU            4
> -  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
> -  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
> -  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
> -  #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
> -  #define VHOST_USER_PROTOCOL_F_CONFIG         9
> -  #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
> -  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
> -  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
> +  #define VHOST_USER_PROTOCOL_F_MQ                     0
> +  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD              1
> +  #define VHOST_USER_PROTOCOL_F_RARP                   2
> +  #define VHOST_USER_PROTOCOL_F_REPLY_ACK              3
> +  #define VHOST_USER_PROTOCOL_F_MTU                    4
> +  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ              5
> +  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN           6
> +  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION         7
> +  #define VHOST_USER_PROTOCOL_F_PAGEFAULT              8
> +  #define VHOST_USER_PROTOCOL_F_CONFIG                 9
> +  #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD         10
> +  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER         11
> +  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD        12
> +  #define VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS 13

INFLIGHT so INBAND?

>  
>  Master message types
>  --------------------
> @@ -946,7 +975,9 @@ Master message types
>    Bits (0-7) of the payload contain the vring index. Bit 8 is the
>    invalid FD flag. This flag is set when there is no file descriptor
>    in the ancillary data. This signals that polling should be used
> -  instead of waiting for a kick.
> +  instead of waiting for the call. however, if the protocol feature
> +  ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS`` has been negotiated
> +  it instead means the updates should be done using the messages.
>  
>  ``VHOST_USER_SET_VRING_CALL``
>    :id: 13
> @@ -959,7 +990,9 @@ Master message types
>    Bits (0-7) of the payload contain the vring index. Bit 8 is the
>    invalid FD flag. This flag is set when there is no file descriptor
>    in the ancillary data. This signals that polling will be used
> -  instead of waiting for the call.
> +  instead of waiting for the call; however, if the protocol feature
> +  ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS`` has been negotiated
> +  it instead means the updates should be done using the messages.

Hmm I don't like this. I propose that with VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS
we just don't allow VHOST_USER_SET_VRING_CALL (if you think it's
important to allow them, we can say that we do not require them).

But it's important for performance to be able to enable polling.


>  
>  ``VHOST_USER_SET_VRING_ERR``
>    :id: 14
> @@ -971,7 +1004,11 @@ Master message types
>  
>    Bits (0-7) of the payload contain the vring index. Bit 8 is the
>    invalid FD flag. This flag is set when there is no file descriptor
> -  in the ancillary data.
> +  in the ancillary data. If the protocol features
> +  ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS`` and
> +  ``VHOST_USER_PROTOCOL_F_SLAVE_REQ`` have been negotiated the invalid
> +  FD flag will be used to indicate that updates should be done using
> +  the ``VHOST_USER_SLAVE_ message.
>  
>  ``VHOST_USER_GET_QUEUE_NUM``
>    :id: 17
> @@ -1190,6 +1227,20 @@ Master message types
>    ancillary data. The GPU protocol is used to inform the master of
>    rendering state and updates. See vhost-user-gpu.rst for details.
>  
> +``VHOST_USER_VRING_KICK``
> +  :id: 34
> +  :equivalent ioctl: N/A
> +  :slave payload: vring state description
> +  :master payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS`` protocol
> +  feature has been successfully negotiated, this message may be
> +  submitted by the master to indicate that a buffer was added to
> +  the vring instead of signalling it using the vring's event FD or

event -> kick?
fd -> file descriptor

> +  having the slave rely on polling.

i think polling is a separate option and should be there with inband
kicks.

> +
> +  The state.num field is currently reserved and must be set to 0.
> +
>  Slave message types
>  -------------------
>  
> @@ -1246,6 +1297,34 @@ Slave message types
>    ``VHOST_USER_PROTOCOL_F_HOST_NOTIFIER`` protocol feature has been
>    successfully negotiated.
>  
> +``VHOST_USER_SLAVE_VRING_CALL``
> +  :id: 4
> +  :equivalent ioctl: N/A
> +  :slave payload: vring state description
> +  :master payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS`` protocol
> +  feature has been successfully negotiated, this message may be
> +  submitted by the slave to indicate that a buffer was used from
> +  the vring instead of signalling this using the vring's kick FD or
> +  having the master relying on polling.


call FD?

> +
> +  The state.num field is currently reserved and must be set to 0.
> +
> +``VHOST_USER_SLAVE_VRING_ERR``
> +  :id: 5
> +  :equivalent ioctl: N/A
> +  :slave payload: vring state description
> +  :master payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS`` protocol
> +  feature has been successfully negotiated, this message may be
> +  submitted by the slave to indicate that an error occurred on the
> +  specific vring, instead of signalling the error FD set by the
> +  master via ``VHOST_USER_SET_VRING_ERR``.
> +
> +  The state.num field is currently reserved and must be set to 0.
> +
>  .. _reply_ack:
>  
>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> -- 
> 2.20.1

