Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64042C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2083F21850
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqnMK/u9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2083F21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnXcE-0000Is-6O
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 20:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hnXc2-0008Li-Oa
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hnXc1-0007Vo-Ln
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:16:02 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:41766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hnXc1-0007U3-F4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:16:01 -0400
Received: by mail-qk1-x744.google.com with SMTP id v22so16077722qkj.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 17:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M5ckMOSIMZvSWWF/m5XgA5N+1zkIPe6mtKvJb+Wx4MQ=;
 b=lqnMK/u9gXOB7E9yqx7AvFynG2g3UNm5Zyl0T3MlMolIgDjHmlsRkNcK/+/HrScct4
 GsoSLOEQOEw/kVjXzEe4EPZ/AnLTMQUz+VjnkmdSC3WK4+21SuSobeVaEXZjr/ZSHOJY
 vDyvZAXeVAfre5af4SWyIRnnPgUWEKkErd2Pw95mbq5kTt6IVrR7wOzVBtt0PCYrs/0L
 X9T6wbnilzusQXES8iZBptOZ4unuQU7hn+HWEgfVMejjhvuxTrhYqxqLaaD7UYo69To6
 MvgNCFgQoxi5E9VzGEKK1egSAFcTvScn+Mn36CUbMMQsUxWdr8NrOPLFhO5G+j9Qc989
 oWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M5ckMOSIMZvSWWF/m5XgA5N+1zkIPe6mtKvJb+Wx4MQ=;
 b=Jcwuhfizh+CCE/UmMxauj38SE8UaZAcNEF3XuA5EliHeaVhunfG6/3iLG6tYzQjYO/
 FXfz/2lghi6eKWSq6Pf9+H7JjSDKv1ROhQZH8z5hV/iJakJS52m+vMPZJc79N29rNWXd
 tfyFHtq9T0w25B8gbeztDqB9fJ48Wv3MEPnp75TZJI/q9wOsoe1QHNNABHUmYYJJIc7l
 XIMMJm34lvAa+4qhKpozkDMFcFXWpd72tXEIDPTl+9en+NFGAsMVCoyJ/mNnCQxb88Nf
 oPnNFZohnk74Sa5fIH8V6MjWD48o/aiUf7N9CNAyXlNfFX76eaihHWrvruwc5cH9KuVS
 U9DQ==
X-Gm-Message-State: APjAAAXJLRWK4kiNI8kywK/PFRlaR+hUUv68R94dwf2qVm5qbDkLIPms
 jvKVZtycmcefbKmHPCYfSAovXDMHQs8GvWAFGkc=
X-Google-Smtp-Source: APXvYqx3dnLUseAdju0ATbRRk8LOKGNrGU6awtJXmxDxCLkulmN5iuzhKo/XinTFSkeVo98JBBdaNB7TTn/c43fAeG0=
X-Received: by 2002:ae9:c106:: with SMTP id z6mr25021615qki.285.1563322559826; 
 Tue, 16 Jul 2019 17:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190715102326.2805-1-xieyongji@baidu.com>
 <20190716144202.GB18691@stefanha-x1.localdomain>
In-Reply-To: <20190716144202.GB18691@stefanha-x1.localdomain>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 17 Jul 2019 08:15:48 +0800
Message-ID: <CAONzpcbx10OHQ7y=ZW7U1TbdOEhtfOG571ioq8q6naonuUNG1A@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost-scsi: Call
 virtio_scsi_common_unrealize() when device realize failed
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
Cc: fam@euphon.net, pbonzini@redhat.com, Xie Yongji <xieyongji@baidu.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 at 22:42, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Mon, Jul 15, 2019 at 06:23:25PM +0800, elohimes@gmail.com wrote:
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > This avoids memory leak when device hotplug is failed.
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > ---
> >  hw/scsi/vhost-scsi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> > index 4090f99ee4..db4a090576 100644
> > --- a/hw/scsi/vhost-scsi.c
> > +++ b/hw/scsi/vhost-scsi.c
> > @@ -210,7 +210,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
> >          if (err) {
> >              error_propagate(errp, err);
> >              error_free(vsc->migration_blocker);
> > -            goto close_fd;
> > +            goto free_virtio;
> >          }
> >      }
> >
> > @@ -240,6 +240,8 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
> >          migrate_del_blocker(vsc->migration_blocker);
> >      }
> >      g_free(vsc->dev.vqs);
> > + free_virtio:
> > +    virtio_scsi_common_unrealize(dev, errp);
>
> error_set*() requires that *errp == NULL:
>
>   static void error_setv(Error **errp, ...
>   ...
>       assert(*errp == NULL);
>
> Today virtio_scsi_common_unrealize() doesn't use the errp argument but
> if it ever uses it then QEMU will hit an assertion failure.
>
> Please do this instead:
>
>   virtio_scsi_common_unrealize(dev, &error_abort);
>
> If virtio_scsi_common_unrealize() ever produces an error there will be
> an message explaining that errors are unexpected.
>
> This also applies to Patch 2.
>
> Alternatively you could do this to handle all cases and propagate the
> error:
>
>   Error *local_err = NULL;
>   virtio_scsi_common_unrealize(dev, &local_err);
>   error_propagate(errp, local_err);

Will fix it in v2. Thank you.

Thanks,
Yongji

