Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891A5C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3122076D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTeANqBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3122076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWSEL-0004Vm-Dj
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 18:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jWSDg-0003rd-Vc; Wed, 06 May 2020 18:08:49 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:42575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jWSDf-0002c8-M8; Wed, 06 May 2020 18:08:48 -0400
Received: by mail-il1-x143.google.com with SMTP id t12so1716735ile.9;
 Wed, 06 May 2020 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qesP6xxhEPogSCylPLjFVLV0s1EX26GFExOIn5WY4TE=;
 b=fTeANqBY/5G+Hh1Xge/9a2dnFddKYFPsxj0j4GN4kTe4xDjuyTbMo8vis9/bF6vVHG
 n0xUyMGvuXjY1hwO1sw+YJQBjKL4ohBu56aVzsHiExhMoGq+AlyqlaSD1zD69Q1qKu+Y
 IPg9aIvx7J0MYq9vGyEIBkMFm4j6v3yBf87jTg406Z+wCiswrzEJxzYQU4IFdx4AFmCN
 zowcZSA8nVayHNrx7cP602bsZsC1hEEToFTFfVkGbb70oyuJLwVchUjU7rOBvWD2m28F
 vDVEnwzVPv5T3SC0W7qcsY8WYfCqsoq5OtoJJNz1eIyj15RMX7/emvhiqJzhu4YLIfFc
 FuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qesP6xxhEPogSCylPLjFVLV0s1EX26GFExOIn5WY4TE=;
 b=nsnlvfajHlNgmyP1E7VqMz3q58lan/il2i+BpkDqe/MS8UOtXhp1W7W8c2A0U2fB7j
 aiw46KKrPScRGTJ/Nn+Z0jKD3HFwTOHpG02otNityYA+ALiL9FdlEBIWGzO7veXMmU5e
 P2BrvsWJKOTy0CWwoffSTO0DLkvBFGoYzVcXFHQw6gdpBZfjGPQoDXndtkAcU9HZvDDF
 Nh0sXHN1KDOQc0XHMCHr0uoQKpQDL0IcINxnHjcsTwk3tdgQaEERURsLSwLzA8ZuhZy4
 LwN1F/6sSun0HFWPenP0hHvbMKvzaAwozdLcj8gDR6VDmgau3HO+iqFwFI5Vzz3xK3SE
 Z0kA==
X-Gm-Message-State: AGi0PuY1E6hK7ByHzsCjzUtIXlt0Avne1MtAC3Z1N9Q6bnyu10pNkjDp
 IvjiKvcgZS5+EI0WMOQ0gsIMFy6fmMstros0Bd8=
X-Google-Smtp-Source: APiQypJE1siFEV5wM054ktIOBpfjURNsDj0oZxAQx/v1mrMd1X8XlV8UmYZRJN7BUJLc/UBEo1fTh4lOsGfX1nomnHE=
X-Received: by 2002:a92:d7c6:: with SMTP id g6mr11159279ilq.51.1588802925623; 
 Wed, 06 May 2020 15:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
In-Reply-To: <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Wed, 6 May 2020 18:08:34 -0400
Message-ID: <CAFubqFsvn+wNm-rAU1sLBic6J70-ZP_UT4xMDcvGeZ9TarYdjw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
To: Dima Stepanov <dimastep@yandex-team.ru>, mst@redhat.com, fengli@smartx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, raphael.norwitz@nutanix.com, arei.gonglei@huawei.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As you correctly point out, this code needs to be looked at more
carefully so that
if the device does disconnect in the background we can handle the migration=
 path
gracefully. In particular, we need to decide whether a migration
should be allowed
to continue if a device disconnects durning the migration stage.

mst, any thoughts?

Have you looked at the suggestion I gave Li Feng to move vhost_dev_cleanup(=
)
into the connection path in vhost-user-blk? I=E2=80=99m not sure if he=E2=
=80=99s
actively working on it,
but I would prefer if we can find a way to keep some state around
between reconnects
so we aren=E2=80=99t constantly checking dev->started. A device can be stop=
ped
for reasons
other than backend disconnect so I=E2=80=99d rather not reuse this field to
check for backend
disconnect failures.

On Thu, Apr 30, 2020 at 9:57 AM Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
>
> If vhost-user daemon is used as a backend for the vhost device, then we
> should consider a possibility of disconnect at any moment. If such
> disconnect happened in the vhost_migration_log() routine the vhost
> device structure will be clean up.
> At the start of the vhost_migration_log() function there is a check:
>   if (!dev->started) {
>       dev->log_enabled =3D enable;
>       return 0;
>   }
> To be consistent with this check add the same check after calling the
> vhost_dev_set_log() routine. This in general help not to break a

Could you point to the specific asserts which are being triggered?

> migration due the assert() message. But it looks like that this code
> should be revised to handle these errors more carefully.
>
> In case of vhost-user device backend the fail paths should consider the
> state of the device. In this case we should skip some function calls
> during rollback on the error paths, so not to get the NULL dereference
> errors.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 3ee50c4..d5ab96d 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev *=
dev,
>  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>  {
>      int r, i, idx;

A couple points here


(1) This will fail the live migration if the device is disconnected.
That my be the right thing
      to do, but if there are cases where migrations can proceed with
a disconnected device,
      this may not be desirable.

(2) This looks racy. As far as I can tell vhost_dev_set_log() is only
called by vhost_migration_log(),
      and as you say one of the first things vhost_migration_log does
is return if dev->started is not
      set. What=E2=80=99s to stop a disconnect from clearing the vdev right
after this check, just before
      vhost_dev_set_features() is called?

As stated above, I would prefer it if we could add some state which
would persist between
reconnects which could then be checked in the vhost-user code before
interacting with
the backend. I understand this will be a much more involved change and
will require a lot
of thought.

Also, regarding (1) above, if the original check in
vhost_migration_log() returns success if the
device is not started why return an error here? I imagine this could
lead to some inconsistent
behavior if the device disconnects before the first check verses
before the second.

> +
> +    if (!dev->started) {
> +        /*
> +         * If vhost-user daemon is used as a backend for the
> +         * device and the connection is broken, then the vhost_dev
> +         * structure will be reset all its values to 0.
> +         * Add additional check for the device state.
> +         */
> +        return -1;
> +    }
> +
>      r =3D vhost_dev_set_features(dev, enable_log);
>      if (r < 0) {
>          goto err_features;
> @@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev,=
 bool enable_log)
>      }

