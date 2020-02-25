Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F4C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E9421744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gviRT5Ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E9421744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c7y-0000gD-NG
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6c2A-0006vm-F6
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6c27-0005ax-Fa
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:22:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6c27-0005ai-AC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582644122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZwaoT8ln7N1pwdGZSi/M96OJjKYOXxCelBD0UpRWYU=;
 b=gviRT5Ct7Pg0iOApOAwIFI/3L7HcQvFtdrnWd70QRHqZ6vxbXjZnkT/p47IKdV+GPCBZc0
 KnGpWT6OQZecGyNrjFWYmQfT5ooEll1q73ttgAS1gfSAsgIYSnaK5ZE/7cL0Px5Vd3nFB+
 nDtPR5T6Aro1UiXQFWgMleOO5SDabD0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-yUJE0GXJO-eAZ6k9OwhudQ-1; Tue, 25 Feb 2020 10:21:59 -0500
X-MC-Unique: yUJE0GXJO-eAZ6k9OwhudQ-1
Received: by mail-qk1-f197.google.com with SMTP id d2so1517141qko.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XVBUwOrV9AJ3BOstgnwfQS2qsfQvMf0BYM163UrjERk=;
 b=uIcmAmyfv/gZcqcUGnHRbb9wEd5bzLVT32ln/Ox3/lwHiLUsEnzAq2feRfYa/STuhM
 WAt4jKOxIi2Tk1GBDCI7C2dCSxCGCD/vsT8vCrTAy0JgiAHvyom6gEgaHZcSlPHDP8+4
 HeTW6l1jwajyXGZpuRg9Yzea8EzIwF+a8z9ixsgGHJDWzQhgKPGIDw+Ie4nlXDOOcJy2
 2DafAnlSk+wKmqfXf+3iR/GwB6XoOt5kj8Nk52Mc3A824EIKTAn9UWE02WxNk12HaWG7
 swmxnFjZ4TAtzxOT7QvT2JtDxYjyMmaZ3jRK78azzQwhH/O77S9ltfBI8eJ8uM0RgacM
 t2bQ==
X-Gm-Message-State: APjAAAUIt0c6N7ua652bJ/uosdSLsBcsgkcMfkPzjV+r7rysIp164xpn
 rG4IGdTFW2DlB5/CfN2vV05stq8pCO09ibAZ9eCpQbRVWV7zjf7gc2u9MbUrvD2zjC7YZcH2/EG
 VzPKX3oVeg7MkWBw=
X-Received: by 2002:ac8:7309:: with SMTP id x9mr56748388qto.338.1582644118196; 
 Tue, 25 Feb 2020 07:21:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzv9zOrNnODNqpU43O6DNRONArzFzC6ICK2uuIBkMuzYv6piGuHdqp/EQ/cTHXLD1o3luy25A==
X-Received: by 2002:a05:620a:222d:: with SMTP id
 n13mr58434276qkh.268.1582643680224; 
 Tue, 25 Feb 2020 07:14:40 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 o4sm510222qki.26.2020.02.25.07.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:14:39 -0800 (PST)
Date: Tue, 25 Feb 2020 10:14:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/32] docs: vhost-user: add in-band kick/call messages
Message-ID: <20200225151210.647797-27-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Johannes Berg <johannes.berg@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

For good reason, vhost-user is currently built asynchronously, that
way better performance can be obtained. However, for certain use
cases such as simulation, this is problematic.

Consider an event-based simulation in which both the device and CPU
have scheduled according to a simulation "calendar". Now, consider
the CPU sending I/O to the device, over a vring in the vhost-user
protocol. In this case, the CPU must wait for the vring interrupt
to have been processed by the device, so that the device is able to
put an entry onto the simulation calendar to obtain time to handle
the interrupt. Note that this doesn't mean the I/O is actually done
at this time, it just means that the handling of it is scheduled
before the CPU can continue running.

This cannot be done with the asynchronous eventfd based vring kick
and call design.

Extend the protocol slightly, so that a message can be used for kick
and call instead, if VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS is
negotiated. This in itself doesn't guarantee synchronisation, but both
sides can also negotiate VHOST_USER_PROTOCOL_F_REPLY_ACK and thus get
a reply to this message by setting the need_reply flag, and ensure
synchronisation this way.

To really use it in both directions, VHOST_USER_PROTOCOL_F_SLAVE_REQ
is also needed.

Since it is used for simulation purposes and too many messages on
the socket can lock up the virtual machine, document that this should
only be used together with the mentioned features.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20200123081708.7817-6-johannes@sipsolutions.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.rst | 122 ++++++++++++++++++++++++++++++------
 1 file changed, 104 insertions(+), 18 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5f8b3a456b..401652397c 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -2,6 +2,7 @@
 Vhost-user Protocol
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 :Copyright: 2014 Virtual Open Systems Sarl.
+:Copyright: 2019 Intel Corporation
 :Licence: This work is licensed under the terms of the GNU GPL,
           version 2 or later. See the COPYING file in the top-level
           directory.
@@ -279,6 +280,9 @@ If *master* is unable to send the full message or recei=
ves a wrong
 reply it will close the connection. An optional reconnection mechanism
 can be implemented.
=20
+If *slave* detects some error such as incompatible features, it may also
+close the connection. This should only happen in exceptional circumstances=
.
+
 Any protocol extensions are gated by protocol feature bits, which
 allows full backwards compatibility on both master and slave.  As
 older slaves don't support negotiating protocol features, a feature
@@ -315,7 +319,8 @@ it until ring is started, or after it has been stopped.
=20
 Client must start ring upon receiving a kick (that is, detecting that
 file descriptor is readable) on the descriptor specified by
-``VHOST_USER_SET_VRING_KICK``, and stop ring upon receiving
+``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
+``VHOST_USER_VRING_KICK`` if negotiated, and stop ring upon receiving
 ``VHOST_USER_GET_VRING_BASE``.
=20
 While processing the rings (whether they are enabled or not), client
@@ -767,25 +772,49 @@ When reconnecting:
 #. Resubmit inflight ``DescStatePacked`` entries in order of their
    counter value
=20
+In-band notifications
+---------------------
+
+In some limited situations (e.g. for simulation) it is desirable to
+have the kick, call and error (if used) signals done via in-band
+messages instead of asynchronous eventfd notifications. This can be
+done by negotiating the ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS``
+protocol feature.
+
+Note that due to the fact that too many messages on the sockets can
+cause the sending application(s) to block, it is not advised to use
+this feature unless absolutely necessary. It is also considered an
+error to negotiate this feature without also negotiating
+``VHOST_USER_PROTOCOL_F_SLAVE_REQ`` and ``VHOST_USER_PROTOCOL_F_REPLY_ACK`=
`,
+the former is necessary for getting a message channel from the slave
+to the master, while the latter needs to be used with the in-band
+notification messages to block until they are processed, both to avoid
+blocking later and for proper processing (at least in the simulation
+use case.) As it has no other way of signalling this error, the slave
+should close the connection as a response to a
+``VHOST_USER_SET_PROTOCOL_FEATURES`` message that sets the in-band
+notifications feature flag without the other two.
+
 Protocol features
 -----------------
=20
 .. code:: c
=20
-  #define VHOST_USER_PROTOCOL_F_MQ             0
-  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD      1
-  #define VHOST_USER_PROTOCOL_F_RARP           2
-  #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
-  #define VHOST_USER_PROTOCOL_F_MTU            4
-  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
-  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
-  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
-  #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
-  #define VHOST_USER_PROTOCOL_F_CONFIG         9
-  #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
-  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
-  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
-  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE   13
+  #define VHOST_USER_PROTOCOL_F_MQ                    0
+  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD             1
+  #define VHOST_USER_PROTOCOL_F_RARP                  2
+  #define VHOST_USER_PROTOCOL_F_REPLY_ACK             3
+  #define VHOST_USER_PROTOCOL_F_MTU                   4
+  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ             5
+  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN          6
+  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION        7
+  #define VHOST_USER_PROTOCOL_F_PAGEFAULT             8
+  #define VHOST_USER_PROTOCOL_F_CONFIG                9
+  #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD        10
+  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER        11
+  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
+  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
+  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
=20
 Master message types
 --------------------
@@ -947,7 +976,12 @@ Master message types
   Bits (0-7) of the payload contain the vring index. Bit 8 is the
   invalid FD flag. This flag is set when there is no file descriptor
   in the ancillary data. This signals that polling should be used
-  instead of waiting for a kick.
+  instead of waiting for the kick. Note that if the protocol feature
+  ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` has been negotiated
+  this message isn't necessary as the ring is also started on the
+  ``VHOST_USER_VRING_KICK`` message, it may however still be used to
+  set an event file descriptor (which will be preferred over the
+  message) or to enable polling.
=20
 ``VHOST_USER_SET_VRING_CALL``
   :id: 13
@@ -960,7 +994,12 @@ Master message types
   Bits (0-7) of the payload contain the vring index. Bit 8 is the
   invalid FD flag. This flag is set when there is no file descriptor
   in the ancillary data. This signals that polling will be used
-  instead of waiting for the call.
+  instead of waiting for the call. Note that if the protocol features
+  ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` and
+  ``VHOST_USER_PROTOCOL_F_SLAVE_REQ`` have been negotiated this message
+  isn't necessary as the ``VHOST_USER_SLAVE_VRING_CALL`` message can be
+  used, it may however still be used to set an event file descriptor
+  or to enable polling.
=20
 ``VHOST_USER_SET_VRING_ERR``
   :id: 14
@@ -972,7 +1011,12 @@ Master message types
=20
   Bits (0-7) of the payload contain the vring index. Bit 8 is the
   invalid FD flag. This flag is set when there is no file descriptor
-  in the ancillary data.
+  in the ancillary data. Note that if the protocol features
+  ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` and
+  ``VHOST_USER_PROTOCOL_F_SLAVE_REQ`` have been negotiated this message
+  isn't necessary as the ``VHOST_USER_SLAVE_VRING_ERR`` message can be
+  used, it may however still be used to set an event file descriptor
+  (which will be preferred over the message).
=20
 ``VHOST_USER_GET_QUEUE_NUM``
   :id: 17
@@ -1205,6 +1249,20 @@ Master message types
   Only valid if the ``VHOST_USER_PROTOCOL_F_RESET_DEVICE`` protocol
   feature is set by the backend.
=20
+``VHOST_USER_VRING_KICK``
+  :id: 35
+  :equivalent ioctl: N/A
+  :slave payload: vring state description
+  :master payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` protocol
+  feature has been successfully negotiated, this message may be
+  submitted by the master to indicate that a buffer was added to
+  the vring instead of signalling it using the vring's kick file
+  descriptor or having the slave rely on polling.
+
+  The state.num field is currently reserved and must be set to 0.
+
 Slave message types
 -------------------
=20
@@ -1261,6 +1319,34 @@ Slave message types
   ``VHOST_USER_PROTOCOL_F_HOST_NOTIFIER`` protocol feature has been
   successfully negotiated.
=20
+``VHOST_USER_SLAVE_VRING_CALL``
+  :id: 4
+  :equivalent ioctl: N/A
+  :slave payload: vring state description
+  :master payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` protocol
+  feature has been successfully negotiated, this message may be
+  submitted by the slave to indicate that a buffer was used from
+  the vring instead of signalling this using the vring's call file
+  descriptor or having the master relying on polling.
+
+  The state.num field is currently reserved and must be set to 0.
+
+``VHOST_USER_SLAVE_VRING_ERR``
+  :id: 5
+  :equivalent ioctl: N/A
+  :slave payload: vring state description
+  :master payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` protocol
+  feature has been successfully negotiated, this message may be
+  submitted by the slave to indicate that an error occurred on the
+  specific vring, instead of signalling the error file descriptor
+  set by the master via ``VHOST_USER_SET_VRING_ERR``.
+
+  The state.num field is currently reserved and must be set to 0.
+
 .. _reply_ack:
=20
 VHOST_USER_PROTOCOL_F_REPLY_ACK
--=20
MST


