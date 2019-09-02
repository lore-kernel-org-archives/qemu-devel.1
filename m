Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C12C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924E3215EA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmg0c2OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924E3215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4ilK-0004OJ-RN
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i4ika-0003ze-UC
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i4ika-0007g8-0U
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:35:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i4ikZ-0007ea-Qp
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:35:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id k1so13772637wmi.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=j7yUdsiL9R94H/WnG/No7GpHaUSLXOvLcNX4FvvXduY=;
 b=gmg0c2OUdJO40I0eTrbQaWWpejQQHSqb9r5XuI2Zl6pH3a5RQfbk4QxtLZP64Cla4Y
 5qZyjyVvvHjKPOhHJfslWbs8uzmQ7xKrTeyfbV909/FSuhuq7hciwSVINjvHOE5liAoQ
 wxE4LRlqTzWosWDigjzS0SfOVdWuqEB9GRZuLkkq0+zHdDmpkiEloB6uYEStpLrSTjF7
 0JXiaXjkhhoU+D6PfExJfxfyohgeLVWGrjgQVjcgj6TeD5wkItDy7/Q5+L8YvxeY/2mJ
 X9qVJ0Jx431+5R9fxkACFC3TCjJrN4wokPD32pwl9am39PS2Olf2+j69Le5qBci0S4RU
 mYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=j7yUdsiL9R94H/WnG/No7GpHaUSLXOvLcNX4FvvXduY=;
 b=QCzqArXULXeZT2Xd7uE6h4IZyeNwEghHKBao0CALy+cy8GVJE08sK0oz3T60aPVw/g
 PjRQr0UA+XAvWQNtWRJ5F8horUWiNewmuf5NewnfzMMp+0YCLv0sQOL6j7Pb29YRtBRI
 QqaNTWB784jSqE+WSu+QsEtBVwxdygkjuMxh1Bd0nzLQW5ENtBk3AMuGcTtH2Gq0h3DM
 lH6w/IhfT3KOCrXyU4uX6VoBN0ZrOsVQlBnjyiNW+6HQhsRI3p0XQc3rzx5Dbgmh7V9C
 /f0UZ+vTDSTOPrvpYYbWFjOxLegWh8MtH1Emsm3GIIPpyG49/mVLwZXbuv5J0dqq/OHD
 +cSg==
X-Gm-Message-State: APjAAAWSEoVwJ1yU6ZPO5IsWwDAbALGN908Ixqac36uyXRLDEOKJoQNA
 t1rFi7g3b2SE0CFRQv0TSb8=
X-Google-Smtp-Source: APXvYqxgRn7HoArKh1VzpZy0RVPcVUTjyB/C6UG4ygZSfO+law6V+ykisSwLXLwobvgOb8mPv5k/wQ==
X-Received: by 2002:a1c:7ed7:: with SMTP id
 z206mr29823208wmc.124.1567416950098; 
 Mon, 02 Sep 2019 02:35:50 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m23sm18588029wml.41.2019.09.02.02.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 02:35:49 -0700 (PDT)
Date: Mon, 2 Sep 2019 10:35:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190902093548.GD9069@stefanha-x1.localdomain>
References: <20190829165026.225173-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <20190829165026.225173-1-slp@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: Re: [Qemu-devel] [PATCH v2] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, qemu-devel@nongnu.org,
 abologna@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2019 at 06:50:27PM +0200, Sergio Lopez wrote:
>      case VIRTIO_MMIO_QUEUE_PFN:
> +        if (!proxy->legacy) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: read from legacy register (0x%lx) in non-legacy mode\n",
> +                __func__, offset);

Please use HWADDR_PRIx since offset has type hwaddr.  On ILP32 and LLP64
hosts %lx is only 32-bit.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1s4nMACgkQnKSrs4Gr
c8g5mAf/RMRq3ThX8vb+KKHW03iTQpjNdFSsKw5GD8Z7HVhKxvhc7ilDqpbr38kA
26y3d1ROzopZddOAYNG+LnYSZA3eNVdAogvBJ6+V//ZKrvKf9Xmzj9avDsgr83jg
jh/a/GoLg81IkQ2k0jUDixC2gTm0G2QbeKow+K7s54CamDLKhYs6wqk20QQWGWwL
AB+7Y1bTzxS8GvPKDUHlc1tRU/WRAsl7nMUpP9SyEdtde0DpLvsdSDPd6a40oza+
pgnRt0nsI2RfDow3PffDPwdsAQs9ow2tL7jGMFxh648agiwTSIHZTpqrH/x0z4xX
ii3e4RvruT1+FW45W8ezRMcKR6p3Yw==
=QZpV
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--

