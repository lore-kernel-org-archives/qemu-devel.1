Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB860C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7885F20CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQFmr/i+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7885F20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84nh-0005Qt-HF
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i84au-0001EB-Gr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i84ap-0003Yc-9Q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:31:41 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:36056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i84ah-0003Qt-BW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:31:34 -0400
Received: by mail-qt1-x841.google.com with SMTP id o12so25801970qtf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VMk6TwobBGD5B5jUxww1b7vvmXt6KRpsjF8Danw67DE=;
 b=gQFmr/i+jVRDjiyvVPRjIoin2qqPFG0V5auYLq4t2v+aA34hlhLpQTy5AW3TG2WyE2
 Nnk5WKvIW0NOwsNWaDQAhg0LrJj2Az3SXMBV3uwlYh07CLdxTiXLuM7W3fnBwTU/08/A
 lm90opcj5V78f7zLY9Yf+WxZpiVUN0KBrcm68RoMAn1GMNJ3t/XLIo/XsA0RY0SRrqxz
 osbqzSecBRrHd9GwWaoVLhMzGt8YDLgCsHOjeZlu7AeBgkOdRCGzEFeqRa8fN+fPBuKu
 CbE2oX7cF+CWObb0216N6Cv0CsT0jLQm41nDxRUNX/ZkzqguTe1mUp4vllqa5IqO5Frb
 6sPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VMk6TwobBGD5B5jUxww1b7vvmXt6KRpsjF8Danw67DE=;
 b=BIkN5f6Cd1KVzNLMi4SsxLi1WTnicOtrLFDrjN2Sl39j/qnzxdlQZicil38F3I6zej
 i2ky9VRqXiPY1X4LRO4tS0lAEYoARIj4m3RTiSOBNSLQxtHKtDrIS0Hi9OKzi8SLDFvl
 7p3XlwsrRTB/RxIR68MnepGiZs4d2X1Nzm58lb0iPS5xRobli+kAMFwSqexbN6vU6tV/
 fOCm+Umj9y+r7euRstgHjngwtsQ0hEPqCFWhJdk3GGd/SK6dk2LD7p9vAxTg4mmMBKAm
 K10XWY+cZi9aGPs2aPPajXbwqXMn61T0vF6nscPlZEwvz0BJoaKciAa050fidNyYmlao
 p8qg==
X-Gm-Message-State: APjAAAU7Ixy0DwKtgcMJMdBXhW6rQfXQZrglcY68f/oqNdZRQvp8iQih
 9HKeIj7F7z0XPe03oGUqMku0hCZieWv1ONDF/Yg=
X-Google-Smtp-Source: APXvYqxOUVshlG9lZWulT+688KmnRYkD3ZwQuLRmSjwAkSuD3I50gf/ZAWpMmo/tBG8Db+o6Wa0mizqm4kEZwNsyXOM=
X-Received: by 2002:a05:6214:144f:: with SMTP id
 b15mr22849512qvy.171.1568215886516; 
 Wed, 11 Sep 2019 08:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
In-Reply-To: <20190902121233.13382-2-johannes@sipsolutions.net>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Sep 2019 17:31:15 +0200
Message-ID: <CAJSP0QXhOQg98FyLzcTnruG7B=b+uUqEd5HvevRKmuP3HhCSmw@mail.gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Johannes Berg <johannes.berg@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 2, 2019 at 2:13 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> For good reason, vhost-user is currently built asynchronously, that
> way better performance can be obtained. However, for certain use
> cases such as simulation, this is problematic.
>
> Consider an event-based simulation in which both the device and CPU
> have are scheduled according to a simulation "calendar". Now, for
> example, consider the CPU sending a command to the device, over a
> vring in the vhost-user protocol. In this case, the CPU must wait
> for the vring update to have been processed, so that the device has
> time to put an entry onto the simulation calendar to obtain time to
> handle the interrupt, before the CPU goes back to scheduling and
> thus updates the simulation calendar or even has the simulation
> move time forward.
>
> This cannot easily achieved with the eventfd based vring kick/call
> design.
>
> Extend the protocol slightly, so that a message can be used for kick
> and call instead, if the new VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS is
> negotiated. This in itself doesn't guarantee synchronisation, but both
> sides can also negotiate VHOST_USER_PROTOCOL_F_REPLY_ACK and thus get
> a reply to this message by setting the need_reply flag, and ensure
> synchronisation this way.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  docs/interop/vhost-user.rst | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 7827b710aa0a..1270885fecf2 100644
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
> @@ -785,6 +786,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
>    #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
>    #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
> +  #define VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS 13
>
>  Master message types
>  --------------------
> @@ -946,7 +948,9 @@ Master message types
>    Bits (0-7) of the payload contain the vring index. Bit 8 is the
>    invalid FD flag. This flag is set when there is no file descriptor
>    in the ancillary data. This signals that polling should be used
> -  instead of waiting for a kick.
> +  instead of waiting for the call. however, if the protocol feature
> +  ``VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS`` has been negotiated it instead
> +  means the updates should be done using the messages.
>
>  ``VHOST_USER_SET_VRING_CALL``
>    :id: 13
> @@ -959,7 +963,9 @@ Master message types
>    Bits (0-7) of the payload contain the vring index. Bit 8 is the
>    invalid FD flag. This flag is set when there is no file descriptor
>    in the ancillary data. This signals that polling will be used
> -  instead of waiting for the call.
> +  instead of waiting for the call; however, if the protocol feature
> +  ``VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS`` has been negotiated it instead
> +  means the updates should be done using the messages.
>
>  ``VHOST_USER_SET_VRING_ERR``
>    :id: 14
> @@ -1190,6 +1196,19 @@ Master message types
>    ancillary data. The GPU protocol is used to inform the master of
>    rendering state and updates. See vhost-user-gpu.rst for details.
>
> +``VHOST_USER_VQ_CALL``

"call" should be "kick".  "kick" is the driver->device request
submission notification and "call" is the device->driver request
completion notification.

> +  :id: 34
> +  :equivalent ioctl: N/A
> +  :slave payload: vring state description
> +  :master payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS`` protocol feature has
> +  been successfully negotiated, this message may be submitted by the master
> +  to indicate that a buffer was added to the vring instead of signalling it
> +  using the vring's event FD or having the slave rely on polling.
> +
> +  The state.num field is currently reserved and must be set to 0.

Please include an explanation of how this message is different from
the existing methods.  Maybe something like:

  Unlike eventfd or polling, this message allows the master to control
precisely when virtqueue processing happens.  When the master uses
``need_reply`` to receive a reply, it knows the device has become
aware of the virtqueue activity.

>  Slave message types
>  -------------------
>
> @@ -1246,6 +1265,19 @@ Slave message types
>    ``VHOST_USER_PROTOCOL_F_HOST_NOTIFIER`` protocol feature has been
>    successfully negotiated.
>
> +``VHOST_USER_VQ_KICK``

s/KICK/CALL/

