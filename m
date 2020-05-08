Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCFC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D8820725
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXvzsIak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D8820725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWtxo-0000tQ-Je
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 23:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1jWtvR-0004i2-Fj; Thu, 07 May 2020 23:43:49 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1jWtvQ-0006qW-1T; Thu, 07 May 2020 23:43:49 -0400
Received: by mail-pj1-x1041.google.com with SMTP id y6so3638792pjc.4;
 Thu, 07 May 2020 20:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=d1Jhrl3U55fk8bLW4ytoygLqK8oF6EAJsjnSbZLjgJQ=;
 b=OXvzsIakOI6aa87vstn8Mk+PDKTBSruDsz+8XTzOUZGuvt+THxPcBmUeQpxk/gRkDo
 /hTbc7Nw3DhW/Np3EqHUBhTWHFuehxSIs8yFQDrHEJ19PIEaxTUwySyGiECPe7/Pk0oC
 qJTsBZnjpDw50vd7glYcJEGaKvZZjz+LBJYy1dq/vJHXLyGY/WfJo7N6k2y0QOgpdwhT
 X1nzPI+ar8ls/5BiDeco0zX1uydGL6GvqorxwIswfRRbppqCiX4LwHN73SH+BWHKXl8C
 plzajWzwHkTzQwl80snHCAGOoZ84wUUTgFEyVUWcdVCJGyPcbgsjeWaOTPZq/ErIanlk
 LNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=d1Jhrl3U55fk8bLW4ytoygLqK8oF6EAJsjnSbZLjgJQ=;
 b=E4h4TdFLFcBfF4lUNbPKvW5CsMDMUVQ3GJv89CpLbq1FWYjrACPtFiOQnTb5p/22Ko
 fi6dtdLSxdPAoseOfClBhg8oc4XnwGVNCObI6ZQoIiSOOFnNpoE0KpnqFvoJx6d0qxur
 gEJn9hnlHsalzMD4nd6h+uXkJaIr5jD7HA30QfDaU+TRldAy4rUa9LPFPCjyRdBQk3tp
 bzltX5a5u30l0MChN9g0sFyt/NsDIp0dbPeg+5g1v3QygFLT+EYbHbTJ3PuHIjGAAZsS
 YpIl/3HfbU0S+FV1PuDf+o7Mvxj5dZ2lqGAQa6Nv3IznyAzkBJ8GLswdSP714xYJRb3f
 TQbQ==
X-Gm-Message-State: AGi0PuaDGLWD8l+Wop5X/djJE/4DGLpFNSzXX6u8Pmj9guLMMoNs8OnD
 kXx0IOieI7/hGFiqOQRzpH0+eAhD
X-Google-Smtp-Source: APiQypI4g1TC/3RT50MOxYVWZszfnU9sksE3iUycKhBPKg3Gf3rmgwh5M/NhZE3nH99z5Etdgql8RQ==
X-Received: by 2002:a17:90b:a8e:: with SMTP id
 bn14mr3870241pjb.197.1588909425952; 
 Thu, 07 May 2020 20:43:45 -0700 (PDT)
Received: from localhost (61-68-214-199.tpgi.com.au. [61.68.214.199])
 by smtp.gmail.com with ESMTPSA id i13sm1148840pja.40.2020.05.07.20.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 20:43:45 -0700 (PDT)
Date: Fri, 08 May 2020 13:43:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] ppc/pnv: Fix NMI system reset SRR1 value
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20200507114824.788942-1-npiggin@gmail.com>
 <55ff4f45-4e1f-e0af-7b25-0c197dd41e19@kaod.org>
In-Reply-To: <55ff4f45-4e1f-e0af-7b25-0c197dd41e19@kaod.org>
MIME-Version: 1.0
Message-Id: <1588908336.cr0wsknhb6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1041.google.com
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Excerpts from C=C3=A9dric Le Goater's message of May 8, 2020 3:14 am:
> On 5/7/20 1:48 PM, Nicholas Piggin wrote:
>> Commit a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
>> SRR1 setting wrong for sresets that hit outside of power-save states.
>>=20
>> Fix this, better documenting the source for the bit definitions.
>>=20
>> Fixes: a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
>> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> We should introduce some defines like the SRR1_WAKE ones in Linux and=20
> cleanup powerpc_reset_wakeup(). This function uses cryptic values.=20
> That can be done later on as a followup.
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks.

>> ---
>>=20
>> Thanks to Cedric for pointing out concerns with a previous MCE patch
>> that unearthed this as well. Linux does not actually care what these
>> SRR1[42:45] bits look like for non-powersave sresets, but we should
>> follow documented behaviour as far as possible.
>=20
> We should introduce some defines like the SRR1_WAKE ones in Linux and=20
> cleanup powerpc_reset_wakeup(). This function uses cryptic values.=20
> That can be done later on as a followup.
>=20
>=20
> I am currently after a bug which results in a CPU hard lockup because=20
> of a pending interrupt. It occurs on a SMP PowerNV machine when it is=20
> stressed with IO, such as scp of a big file.=20
>=20
> I am suspecting more and more an issue with an interrupt being handled=20
> when the CPU is coming out of idle. I haven't seen anything wrong in

So you can't hit it when booting Linux with powersave=3Doff?

Do we model stop with EC=3D0 properly? Looks like helper_pminsn seems to
be doing the right thing there.

> the models. Unless this maybe :
>=20
>     /* Pretend to be returning from doze always as we don't lose state */
>     *msr |=3D (0x1ull << (63 - 47));
>=20
> I am not sure how in sync it is with PSSCR.

That should be okay, the hardware can always enter a shallower state=20
than was asked for. Linux will handle it. For testing purpose, we could
model deeper states by scribbling on registers and indicating state loss.

Aide from SRR1 sleep state value, Linux uses the SRR1 wake reason value=20
to run the interrupt handler, but even if we got SRR1 wrong, Linux=20
eventually enables MSR[EE] so the interrupt should get replayed then=20
(this is what Linux used to do until we added the wake-reason processing=20
for improved performance).

But we do appear to get those right in powerpc_reset_wakeup().

Thanks,
Nick

