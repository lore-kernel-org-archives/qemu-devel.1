Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2CCC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A2F20756
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkXTpU81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A2F20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDfk-00065d-OX
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDeW-00053D-Ax
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:17:56 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:38165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDeT-0003LE-Ac
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:17:56 -0400
Received: by mail-oo1-xc42.google.com with SMTP id r10so902897oor.5
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3MTXJ7SzJXvGE3kYUOjtvav1mjYpr/RAXHlYl2K/e7o=;
 b=LkXTpU81evh/HbYZ+RrtXyK8+ywAVXSjQqLwci4KYAWP64j1j9EqMAMIrGG9oT0GHz
 7amp5twEs0rCwfyeZYynM8oPGNmBrdglfful12IwyaRc89X8GAUb5o6cXd2KUi+Gkpjp
 R4+4yy97mCZExAPmlgIFsQa9v+tbEZuWAzfDZSVk59ZOYMrOroFumlF+3eXGSI7+cGTV
 qYkU9zKIB0ISBxblAuC6bE85zJ+LUIuqOzu2vgVKesxW854ZXG9lJZSd00v5Df/nDaEt
 CN0m617zG7K7PYVSZS2eQZ8Ot473mh6qHFU7N6dZ6XAf2eTP0pKtniDL0r20XaelVWfN
 6JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3MTXJ7SzJXvGE3kYUOjtvav1mjYpr/RAXHlYl2K/e7o=;
 b=uT+WGuxNkzbhHryGqTyJo4eVr3btcCyl749trjlcNGSbnCv0c9kyNmFotWIBv9Tpvk
 a7PPuia345HQQpjgOw0+66w/qPskQR+CBeChgoNJ1w3C7s0bw2hqlmzgJy/Ra8WJEteu
 Dd4+WXlBgLmGcMUzFB8oJiaJNe3C9dlpt7RSrKhgqIxEZSv0yXCkB5UeusYJSaR6N/mN
 6V66D7/zr/2URf1JyKf2DpniZkWdCVCPtvaKX5gcvJppGcBNL1pUjVtA0ZeDPNIvwxRa
 ieYIQ3MmZmoESnilupFcticTrNwSuvP/ETmnn+VyUsoWCsEP/7EHgs7D59wk81sgRq6D
 8LUw==
X-Gm-Message-State: AOAM533mMnHgev9AAupb+V4AXkE5RfcjiAP4qGTrnQmmpIEKO3lfyNY8
 0FFwSTlFeae95E87SyXlxP1gSCOBkRr6c9XIihg=
X-Google-Smtp-Source: ABdhPJzgPA0dadybaQBWU50F7YRAZKUphu6IK96ziCE4NsGJqEaDjy29yB0Hpm01GUrZHVaZZrNRlCzA1RgFIbReRoo=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr12983271ooa.1.1600186672129; 
 Tue, 15 Sep 2020 09:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-3-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-3-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:17:15 +0800
Message-ID: <CAKXe6S+XpZuRXk0pR-QoMMevxqtJiHP9EcoxHM-JwHso0pv7tA@mail.gmail.com>
Subject: Re: [PATCH v9 02/12] migration/dirtyrate: add DirtyRateStatus to
 denote calculation status
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, yuxiating@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:34=E5=86=99=E9=81=93=EF=BC=9A
>
> add DirtyRateStatus to denote calculating status.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/dirtyrate.c | 26 ++++++++++++++++++++++++++
>  qapi/migration.json   | 17 +++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index bf7fd24..7bea8ff 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -22,6 +22,19 @@
>  #include "migration.h"
>  #include "dirtyrate.h"
>
> +static int CalculatingState =3D DIRTY_RATE_STATUS_UNSTARTED;
> +
> +static int dirtyrate_set_state(int *state, int old_state, int new_state)
> +{
> +    assert(new_state < DIRTY_RATE_STATUS__MAX);
> +    if (atomic_cmpxchg(state, old_state, new_state) =3D=3D old_state) {
> +        return 0;
> +    } else {
> +        return -1;
> +    }
> +}
> +
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> @@ -31,8 +44,21 @@ static void calculate_dirtyrate(struct DirtyRateConfig=
 config)
>  void *get_dirtyrate_thread(void *arg)
>  {
>      struct DirtyRateConfig config =3D *(struct DirtyRateConfig *)arg;
> +    int ret;
> +
> +    ret =3D dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_UNS=
TARTED,
> +                              DIRTY_RATE_STATUS_MEASURING);
> +    if (ret =3D=3D -1) {
> +        error_report("change dirtyrate state failed.");
> +        return NULL;
> +    }
>
>      calculate_dirtyrate(config);
>
> +    ret =3D dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_MEA=
SURING,
> +                              DIRTY_RATE_STATUS_MEASURED);
> +    if (ret =3D=3D -1) {
> +        error_report("change dirtyrate state failed.");
> +    }
>      return NULL;
>  }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5f6b061..061ff25 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1720,3 +1720,20 @@
>  ##
>  { 'event': 'UNPLUG_PRIMARY',
>    'data': { 'device-id': 'str' } }
> +
> +##
> +# @DirtyRateStatus:
> +#
> +# An enumeration of dirtyrate status.
> +#
> +# @unstarted: the dirtyrate thread has not been started.
> +#
> +# @measuring: the dirtyrate thread is measuring.
> +#
> +# @measured: the dirtyrate thread has measured and results are available=
.
> +#
> +# Since: 5.2
> +#
> +##
> +{ 'enum': 'DirtyRateStatus',
> +  'data': [ 'unstarted', 'measuring', 'measured'] }
> --
> 1.8.3.1
>

