Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B22CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FC9207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtGRL409"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FC9207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxgg-0004il-7s
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdxg0-0003Ch-05
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:09:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdxfz-0000lG-3U
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:09:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id r9so3391564wmh.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1VzRJ+bT8a6+NliSBlzPCv2ABZtjjyHTWX4lBM8F2ck=;
 b=MtGRL409tQM37UNeMv0Ft2HPaDHrTNKpTYDa78M+LR7z6CVt1yvJE88O9xV3GAGWN0
 9iMTSdd3czDKtpO7tUSQtkMiXmf6/6jFatqqFKUIaWeWvM8I+Q2W0t/r/pXiVU3WFlPK
 y4Z6wlRahTEdW20h9az6Ys4ShXFYgt0RAjxBkFjLMhYB3N7Wu8yPfq2l4McoIoEcVZHa
 sMTQ1/U2QYS7Zee+AjxwB5725bsJU4kjzKo2E+bXLLYbMjZEfh4qXmdgwqMvVkKAZO/7
 H82vQbPn517XDLtBXhYFrNlOqWuUd82ZGE+y7euYTaXs9HVOcXZ2DpDWgmY0kAS1MUNE
 4YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1VzRJ+bT8a6+NliSBlzPCv2ABZtjjyHTWX4lBM8F2ck=;
 b=kIlt1zafXlY1OLreKbArfNcyEmGV0ZxuKOonbkmDU21C91Azn58x7/cFr5o/PT5IWw
 QCUl0vEtez1qXk0NdAYVMrtGS/UAFusF9HOV5Nfd2E7dhxG9KiJRfTqPyeKXM/jVMuU6
 /5xwRdTxnosYikSViXFG7PGQ29XzZN1PbERasC8k8UWkbciD0kM4jFGls4kIeHXr1JT2
 x4KHZgH5s0gFZPZWlFZTJ1bVD/ljk0qCQTBMgNkyCxLESA4+1yvD4m5xkJg/8DCfRsib
 /Ihxepw+KdwJZ1fylgqVfNgnhg47z4igBW7InCk0B3jLPEArvS1BAOJvt59qRGqPRhd/
 lVCQ==
X-Gm-Message-State: AOAM5338DS44uvDr/AKvvJE5vAGCF3WwpzrcLiMAVVUyXVZHWVN+Bgde
 4r6ABhiiKZQyfD5G/amJszE=
X-Google-Smtp-Source: ABdhPJykkXR+a5bp49JKJB5wNiCGdL/CxPkICdmkJZgENkvcsdkWi0p/ruoiU0kiQoROpeLFIZ431Q==
X-Received: by 2002:a05:600c:297:: with SMTP id
 23mr4984130wmk.12.1590592141582; 
 Wed, 27 May 2020 08:09:01 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a81sm3023935wmd.25.2020.05.27.08.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 08:09:00 -0700 (PDT)
Date: Wed, 27 May 2020 16:08:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 5/7] virtio-scsi: don't touch scsi devices that are
 not yet realized or about to be un-realized
Message-ID: <20200527150858.GK29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-6-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="F55Y67F01HNW3AgB"
Content-Disposition: inline
In-Reply-To: <20200511160951.8733-6-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--F55Y67F01HNW3AgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 07:09:49PM +0300, Maxim Levitsky wrote:
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1812399
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--F55Y67F01HNW3AgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OgooACgkQnKSrs4Gr
c8gGkwf/devRDSsR3637/cvtW7UXmAIlGz1scpS9n4N4vZbAuZh5iz1hUrkkAXx7
njMo2IVFgOxmk0iRu49kNAfenPxZeYPwr1jKULhCRm7+DMpGZWf5nVQ/BZdnzJOv
foiR4vVj59+LIjIWRxtr4+9ii3+ywDMffpPwKGB9IZyCRWd8ozj5O/vrnOrBUFog
y9ft962d6zLwLR5Bx0lXalWhDv+eEljV5MmV36acATzrg27ErGzpKljUiBXSm+ci
8DaurzMtE+XmyEfMuLLUdA2X7vY2+o2AiVbFmuxhLSrWl3O2L+/4ovFmoY24EMJB
RWIYM+zjAn34mkDbnB/QzhnB8WCQPA==
=A1C6
-----END PGP SIGNATURE-----

--F55Y67F01HNW3AgB--

