Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F30C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01782075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01782075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heK87-00073M-10
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57920)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1heJuW-00015b-9H
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1heJuQ-0003vH-20
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:48:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1heJuP-0003u5-Sr
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:48:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so6326531otn.9
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 06:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fZRJhkyPs8QaDQFGILUFDlL1B//32xk1Po8cLgRKWM4=;
 b=dNzFD8DfFJ9SXCVol/mLVn1w38RN64V32iIbX39SROAC2iwgptv1Yak7R/oEYxqBNX
 uGtB/Z2VnaTDRtteYGY1QD5yho6cFAqYypV8u3/Mz7k3fNcRnTlVdLuD3eqrz/oJKdcM
 Jco7DOEzLCqMgPFAPW72wpzVULlMB1p3bj3xHsuQEDDwfeOiFKeXiynhvt0GQrDTfUyy
 8vJcEbyxFlKQCIG9f7wgmRGZdZyDouf6pDpLAWDrBO2f0wAzTuxFDL8W+lEwl0/dveGe
 BDmetkq+wCHUs00JcMWBuQYTUFQi2AcrEC5B6U24mKGmiw/M2+E2hU0/L0KztKVNs0vL
 ARYw==
X-Gm-Message-State: APjAAAXQMl/ZtU2HFPosxxtZ0yVS3wttz4GZsS5JS4Ue28irUs11GuiH
 KtiIsmFnaCJcj+fA8ueuXrXpcB4wORKulu4kZw18Ow==
X-Google-Smtp-Source: APXvYqyG29Ac1b2cY7C/78kPze1cHf+EEOcz72e2HQh6gHVL2UJNTWRyvR+dmNHd2JFDjSGMAu0+a9mKzVbMdaIQMN0=
X-Received: by 2002:a05:6830:1009:: with SMTP id
 a9mr13083771otp.331.1561124932653; 
 Fri, 21 Jun 2019 06:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190621094005.4134-1-stefanha@redhat.com>
 <20190621094005.4134-2-stefanha@redhat.com>
In-Reply-To: <20190621094005.4134-2-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 21 Jun 2019 15:48:41 +0200
Message-ID: <CAMxuvayxbioSOGbH8HV+SKk6PjOXU01HOmf1otu_pB85MQtEAA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [PATCH 1/4] libvhost-user: add
 vmsg_set_reply_u64() helper
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
> The VhostUserMsg request is reused as the reply by message processing
> functions.  This is risky since request fields may corrupt the reply if
> the vhost-user message handler function forgets to re-initialize them.
>
> Changing this practice would be very invasive but we can introduce a
> helper function to make u64 payload replies safe.  This also eliminates
> code duplication in message processing functions.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 443b7e08c3..a8657c7af2 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -216,6 +216,15 @@ vmsg_close_fds(VhostUserMsg *vmsg)
>      }
>  }
>
> +/* Set reply payload.u64 and clear request flags and fd_num */
> +static void vmsg_set_reply_u64(VhostUserMsg *vmsg, uint64_t val)
> +{
> +    vmsg->flags =3D 0; /* defaults will be set by vu_send_reply() */
> +    vmsg->size =3D sizeof(vmsg->payload.u64);
> +    vmsg->payload.u64 =3D val;
> +    vmsg->fd_num =3D 0;
> +}
> +
>  /* A test to see if we have userfault available */
>  static bool
>  have_userfault(void)
> @@ -1168,10 +1177,7 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUse=
rMsg *vmsg)
>          features |=3D dev->iface->get_protocol_features(dev);
>      }
>
> -    vmsg->payload.u64 =3D features;
> -    vmsg->size =3D sizeof(vmsg->payload.u64);
> -    vmsg->fd_num =3D 0;
> -
> +    vmsg_set_reply_u64(vmsg, features);
>      return true;
>  }
>
> @@ -1307,17 +1313,14 @@ out:
>  static bool
>  vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
>  {
> -    vmsg->payload.u64 =3D -1;
> -    vmsg->size =3D sizeof(vmsg->payload.u64);
> -
>      if (dev->nregions) {
>          vu_panic(dev, "Regions already registered at postcopy-listen");
> +        vmsg_set_reply_u64(vmsg, -1);
>          return true;
>      }
>      dev->postcopy_listening =3D true;
>
> -    vmsg->flags =3D VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
> -    vmsg->payload.u64 =3D 0; /* Success */
> +    vmsg_set_reply_u64(vmsg, 0);
>      return true;
>  }
>
> @@ -1332,10 +1335,7 @@ vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg=
)
>          DPRINT("%s: Done close\n", __func__);
>      }
>
> -    vmsg->fd_num =3D 0;
> -    vmsg->payload.u64 =3D 0;
> -    vmsg->size =3D sizeof(vmsg->payload.u64);
> -    vmsg->flags =3D VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
> +    vmsg_set_reply_u64(vmsg, 0);
>      DPRINT("%s: exit\n", __func__);
>      return true;
>  }
> --
> 2.21.0
>

