Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F663C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4BB2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4BB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heK6x-0005qC-07
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1heJuW-00015c-8v
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1heJuP-0003un-P2
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:48:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1heJuO-0003lW-K8
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:48:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id w196so4674051oie.7
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 06:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sC3eG7l+MCt5I2DCXWmX9NdfMkzx1erIq66FBfz1xmc=;
 b=OGmbqAVmuDyRPxurNoGGzHv0V7SOw9jwmkOupBOxIFJF35lusKRjWsLc0+SvamSyKC
 CPDEnFzVY+hMmCsSYYS0eklf+rNYv5pgSOGzJXowSPRwDcy3+oGNAMuE1xkPyrfInz7Q
 gKF/IBPpPBE2taZJfK9tKKoLsaMxfm2wbwAHJFRjRvQZBTFeGjRTvTSJj5gLrOtGAJ5M
 W6xWWkeYHOyvWp6dJ8v9SZ5MIB22YFKtUCVWMilybjLFH9cdVXPuzXE8Snc61D46veaJ
 +dfTCxMKk4hFN+uW4pIQe2a5PYbGOtegMQxdigtpZ7lh54Q8mGobkM4sw5geEr2uh0au
 k+eg==
X-Gm-Message-State: APjAAAUkrbKVqlecIlvXvcFCecVEpNWUB4+rR5hkhUXYtbzcDqQfm6at
 DiaMKgRVXvmFUOf8RAuHWYHi9zg65g+x/fCNmIsrvg==
X-Google-Smtp-Source: APXvYqy1HKwjxKRKvy3lETJiPT6QCeTpQhDyYyiuNymZwHquxegcUIMxB1Cusmertwglce2RkTjbjrzj+l/hv/efHQU=
X-Received: by 2002:aca:4255:: with SMTP id p82mr2973047oia.6.1561124922991;
 Fri, 21 Jun 2019 06:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190621094005.4134-1-stefanha@redhat.com>
 <20190621094005.4134-4-stefanha@redhat.com>
In-Reply-To: <20190621094005.4134-4-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 21 Jun 2019 15:48:32 +0200
Message-ID: <CAMxuvawcDa3f8Rysq2n+S50kb4dNVN1LTygQ4gKOTUHb45M7+Q@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.196
Subject: Re: [Qemu-devel] [PATCH 3/4] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_MQ
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
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 11:40 AM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>
> Existing vhost-user device backends, including vhost-user-scsi and
> vhost-user-blk, support multiqueue but libvhost-user currently does not
> advertise this.
>
> VHOST_USER_PROTOCOL_F_MQ enables the VHOST_USER_GET_QUEUE_NUM request
> needed for a vhost-user master to query the number of queues.  For
> example, QEMU's vhost-user-net master depends on
> VHOST_USER_PROTOCOL_F_MQ for multiqueue.
>
> If you're wondering how any device backend with more than one virtqueue
> functions today, it's because device types with a fixed number of
> virtqueues do not require querying the number of queues.  Therefore the
> vhost-user master for vhost-user-input with 2 virtqueues, for example,
> doesn't actually depend on VHOST_USER_PROTOCOL_F_MQ.  It just enables
> virtqueues 0 and 1 without asking.
>
> Let there be multiqueue!
>
> Suggested-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 0c88431e8f..312c54f260 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1160,7 +1160,8 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vms=
g)
>  static bool
>  vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> -    uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
> +    uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_MQ |
> +                        1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
>                          1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ |
>                          1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER |
>                          1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD;
> @@ -1200,8 +1201,8 @@ vu_set_protocol_features_exec(VuDev *dev, VhostUser=
Msg *vmsg)
>  static bool
>  vu_get_queue_num_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> -    DPRINT("Function %s() not implemented yet.\n", __func__);
> -    return false;
> +    vmsg_set_reply_u64(vmsg, dev->max_queues);
> +    return true;
>  }
>
>  static bool
> --
> 2.21.0
>

