Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D70C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93F72074A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxJ5AcNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93F72074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwOY-0001Bn-Sd
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 12:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kMwMo-0008K3-Ft
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:51:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kMwMm-0002oD-Gd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:51:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so1842077wmj.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yFxbEr9bSlLl+yVJrW7RjTVSlWLw44mYCnVns5wz3ms=;
 b=kxJ5AcNmS5aURtxNxI/0s/bjeh1SXLCF1QDPSB8KwoHpgAHq05zFnCWflkkDbhgPlk
 kFdA2gn6+FhdZyIowIFqPlGV4XA8b+Sam3tSvgJ9NooxLVTnTJghh4IwDkgIzO2dV9wR
 SPIGxFICHttxByA3NTqcJXYLdKs3toLKEh+da8v7eKXYk3TD6FaTw6MEZJHmENjym+f+
 3BQb0IFc9V8jEE3NF4CZgBSn8QYFjz1ncPHFPVxmpspHMIkp+2sZNmvluYHLMqA720qb
 oB3gy5TWe+i8gBmRPUJy7L7pRwPaeVv/7jO6tX/gBe3EFSpJXm/NfN66YxqBV4X2W2s+
 nxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yFxbEr9bSlLl+yVJrW7RjTVSlWLw44mYCnVns5wz3ms=;
 b=QVbD0tNHI2nG0EIKHgo7udynL1xIOxnWXkP9R7w3Cnm5mqyZFysvT4I1JN25HuxCWL
 tP9164H88zPF67A2UwvmHvd6cNyFwb60YiiWxzOvU34PpgD8RnSROqO0ZT3pm+ikTtB0
 CNsSpoOlh5OhcIYTFpeWVIUcnEwtuMPFAqqqZ0JpSYh8b7R1f1ImNcgN/Xf1LGb/sLDM
 sUTHR+EzlKwQslwzWVjuADb4R/5XQ8M9ioqSTf6wG7YzcL68ZTS2axMQzXfPgcxWY9rY
 Jo5hwNXvjWOK2hasZLYxqNrBC8xaFgujz8FJoz0AKTNDaSxpbUJCGoYWY+eQO7byyglX
 nA5g==
X-Gm-Message-State: AOAM532CxwAi90kaLTn2BF2I1HpDZBS3sO/qPtWi7KZKIsklqUq2YeA6
 4la7XVAhBVnx+bQRalqrFEw=
X-Google-Smtp-Source: ABdhPJzNzx6FSdbSIMTSO2ZVdJxQztF9HPQvJdUjKJ8dw/VI87h+25aPCuJ2fYTDv8OpqU210KrxHQ==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr132207wmb.70.1601311866287;
 Mon, 28 Sep 2020 09:51:06 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l19sm1732171wmi.8.2020.09.28.09.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 09:51:04 -0700 (PDT)
Date: Mon, 28 Sep 2020 17:51:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v24 1/8] vfio: UAPI for migration interface for
 device state
Message-ID: <20200928165103.GA176159@stefanha-x1.localdomain>
References: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
 <1590697854-21364-2-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1590697854-21364-2-git-send-email-kwankhede@nvidia.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com,
 eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, cohuck@redhat.com, zhi.a.wang@intel.com,
 jonathan.davies@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 02:00:47AM +0530, Kirti Wankhede wrote:
> + * The sequence to be followed while in pre-copy state and stop-and-copy state
> + * is as follows:
> + * a. Read pending_bytes, indicating the start of a new iteration to get device
> + *    data. Repeated read on pending_bytes at this stage should have no side
> + *    effects.
> + *    If pending_bytes == 0, the user application should not iterate to get data
> + *    for that device.

What if the device doesn't have any data yet but might have some later?
This seems to say that if pending_bytes reads 0 the first time then this
device doesn't support pre-copy at all.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9yFHcACgkQnKSrs4Gr
c8gPzgf7B5GyzroX7Zn7RxtarkQx1r7bP/riDrgK/46FdBVBGr7mgVNC0n/hxi0+
jFfxozuaeGb2OGploZNOW195PgDW4NZVQYezcs8bbf0/vaYp9pUYVkYHVY8fxc3M
mstpszqlB501+OngR1IbmZJw8bi6bg/tjHhDoTikKa+US6GBSlRA9KoZtXsCogaU
qoqAanorit1HHRJX1G9gpkbnwXAWCKj+/UevG/9RTj0K4osVmo4SHT+9HwuecKJO
9+2yt+MOkgxwH33xo8dPFlQJccLe+ufXz9lEQUtsHd+ePuyk69N7c+YaLmpmuyae
ERgwQbqjmUz67S37RTrOMJ76zzm9OQ==
=8ZXc
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

