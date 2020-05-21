Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D22C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C802070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2Ww6kFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C802070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkWH-0000dD-S4
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 08:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbkV5-0007yM-5P
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:40:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbkV4-0003wc-7y
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:40:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id h4so5446857wmb.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Hvt6RTJwycdAI9QOA3z60jUzhhWLiWgiROjYhBDE4m4=;
 b=i2Ww6kFvEkPqK8rC/FZYkrE0Gw7QtkY6Oa/jHjypaNG3mh4x4SvBtilpwJulWT/+6v
 R0BODbE7SQA5Ij5Hs7ZpBd/z8TlczEiYgI5k8Dy8PCx+0mrz4yQQj/zU4lwcrQQr8blK
 UA3XEQhSJqWSKCg8OWjB20C66qoyDqKybdHmL7feDxTeM93v3cL++P2NJ3rYgxp8QLNp
 vJSJEQLMG6HTHuOXi/iTjOgZfd3UlpgodhrkGyPr16xLJEgf6f2b3PSHJLr5EOe5JKKr
 7/kOit/WY5sc6JkYJnEGo4cUqa53aPY5d5YdHIwQAiX3J6OPscvOJ7J/BeBuopR4oZLQ
 RoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Hvt6RTJwycdAI9QOA3z60jUzhhWLiWgiROjYhBDE4m4=;
 b=QqJVjIsY39CiBU63Sa/u3GIpcSd3yaxyGmX/qjSj27zFdGJxHjHSelLmsbX4N1j7De
 s7zshoeEL5ufDxuGE/uUmaNIcED49cc+0vQEm2gwQ7TEawoAv5MLMTBq2drjH812Lg+0
 hsZ24H04KQOy61P59KhQrmY8mAiJeg/8E1ylxlm97pAz2sUerIS8EA0IxVSqVvF1+EIX
 tSW+eWuMRvbqq6NMs5ZAWEaaAtRoNetsNJe61Ie+fRrEVdUHvc77MjIHiNwUafVGbvOK
 6CfXZ8HN+7vnlmqG+UTYHXx6KMY4uxKHirMv9kfGlcCwl1pT1raVQp/icb7ieE/b/0wS
 NgwQ==
X-Gm-Message-State: AOAM531+plwVgvCfewGE1sguriujWCtbpVFC2+n3dEpdR92LlLULEopG
 ifOnA9oc4f1tbp1L1npEPls=
X-Google-Smtp-Source: ABdhPJyordx60K/PcwjmRMf2Z2ocOTc05AKjFirDBIKKIs2w9FNcHR423gCFXYxtD1gXrgn7aS7zqA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr8638009wmk.168.1590064835367; 
 Thu, 21 May 2020 05:40:35 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a21sm6258163wmm.7.2020.05.21.05.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 05:40:34 -0700 (PDT)
Date: Thu, 21 May 2020 13:40:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC v2 5/9] vhost-vdpa: implement vhost-vdpa backend
Message-ID: <20200521124032.GH251811@stefanha-x1.localdomain>
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-6-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Content-Disposition: inline
In-Reply-To: <20200508163218.22592-6-lulu@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: rdunlap@infradead.org, mst@redhat.com, mhabets@solarflare.com,
 qemu-devel@nongnu.org, rob.miller@broadcom.com, saugatm@xilinx.com,
 armbru@redhat.com, hch@infradead.org, eperezma@redhat.com, jgg@mellanox.com,
 jasowang@redhat.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, maxime.coquelin@redhat.com,
 Tiwei Bie <tiwei.bie@intel.com>, aadam@redhat.com, cohuck@redhat.com,
 hanand@xilinx.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2020 at 12:32:14AM +0800, Cindy Lu wrote:
> From: Tiwei Bie <tiwei.bie@intel.com>
>=20
> Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> vhost-user. The above patch provides a generic device for vDPA purpose,
> this vDPA device exposes to user space a non-vendor-specific configuration
> interface for setting up a vhost HW accelerator, this patch set introduces
> a third vhost backend called vhost-vdpa based on the vDPA interface.
>=20
> Vhost-vdpa usage:
>=20
>   qemu-system-x86_64 -cpu host -enable-kvm \
>     ......
>   -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost-vdpa=
0 \
>   -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \

I haven't looked at vDPA in depth. What is different here compared to
the existing vhost-backend.c kernel backend?

It seems to be making the same ioctls calls so I wonder if it makes
sense to share the vhost-backend.c kernel code?

Stefan

--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GdsAACgkQnKSrs4Gr
c8jcBwf9GAzuGtYjtsoN0bsUmhqqVAE3se29unITj71yhW2TD22rVlAXxi+3rs9i
ZSq+FIhaxh6FqzYQONFAlgmBMhcfmyPDvmtkF1/IOkWDWi+iHLm7llF0yEMq3U7O
np63fQrF2JPTUrp6xzEFEcyHRwuRwoOFz0DylVcVpwjSAfj23gu+uq19JBs7HsLl
U2OvcTWD3mt0u/DMqY1tSDU+UQ31EGyskoPdLySImU8BhB7kCbFhVubkH9ECBxQ0
WF/nhZ1iPU/U++muk2t77rYL+J53ot+SCMCBT8ueYXOTyx0tJa0rokWiuMAZz00Z
DauAPVEG01dPgGpQnLruAqPyZgVSyA==
=0uyc
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--

