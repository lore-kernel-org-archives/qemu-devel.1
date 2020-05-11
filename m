Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03F3C54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDD920722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdCmiwui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDD920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9cY-0002r2-Rn
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY9bK-0001YY-SO
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:40:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY9bH-0004mB-Gl
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:40:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id h17so2390040wrc.8
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/nJ47pRwycSRQxpw74AO8QTIl9chn+nUhzC/PNu4eV4=;
 b=OdCmiwuiCNUPvw9HFPrHE4pq4q9kCdMvlYa7AkDAqNz5D9c4QRcEq2uK3+JFsng+ZJ
 ZrSYQFV4aqFzUk/l7s9UpwwFRd2V9W9U7pDuh//n1dW4YFSswhbFE8sw1B/Vqak/OGuQ
 Ukem2aame0x5hhY48d/egvo6jnJRY24YCw1wdQcc7NI9NGypVkhm6ajcH63udmAS/31k
 VvTX5wenfo1qYqqBcbNcv1eC7UmG8JwEyOccqW4VON/XJQZ2bnUKhS5a7YKzF/rNJPsw
 zNBRhp4AGBw7fADNa/STQR2bTAbx5Zyx6FSc5ObqjA2m+gN4Pdwu8D1uChNcC0TzX3zV
 kSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/nJ47pRwycSRQxpw74AO8QTIl9chn+nUhzC/PNu4eV4=;
 b=T3UVDywzWfzGjaANKjJRu5lAXdhh4HS+orK+J1agVU+K2LzSwwY44SMBHt2XZwCPQV
 6ubgBzJLe/4CQDyagUu3o6DjaJ1tLRqfF6kXkzCjHFpM+gaBqqenUodq0FtTHpcqv4mZ
 bRpjnwtMgB6ENZXyz9sKQ90g/ChneGvelKipdZU1/VfGNTAmEdq02gVcOkuObOXGlJZA
 3gwgyduiX/SWQkcABcvwvl8iLyovsHF7zAHVSM3n5kYn0gT3dvNPr7jT3WkjZnxH93ju
 F2bwaB4JmaUAumrzVU6HHWYdeVmZM1w/xMlrAYSPH8hDuGgd4eGi9oDnZFKeBRV0n9Dk
 smUg==
X-Gm-Message-State: AGi0PuZi1qLrBkpn1TBAQABsdSafSfPYYDprMP9wB+JHcb2bCDaPtd0L
 qiYtd/ZmicnlP9YyWvmk36Q=
X-Google-Smtp-Source: APiQypJcKd3t6lXxuogsb/zgd4mssfltPLcg2H7xgbQH6tC4SevUrlSQC/slUEuAMSnhFGoOdO5AmA==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr20181401wrs.90.1589208008473; 
 Mon, 11 May 2020 07:40:08 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o205sm13240872wmo.32.2020.05.11.07.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 07:40:07 -0700 (PDT)
Date: Mon, 11 May 2020 15:40:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
Message-ID: <20200511144005.GC182627@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Have you decided whether to drop the remote device program in favor of
using a softmmu make target?

Is there anything in this series you'd like me to review before you send
the next revision?

Stefan

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl65Y8UACgkQnKSrs4Gr
c8gRRwgAq6oFhmXH0FUcGtJBuxMA/AR9i/nGc/t2DnfHeAUT7/HTleDRZtRvdprZ
IqAUahshHLXfpJrzGG4nVhATHBqWO8nNxcvh7P1PxyPAOL1DLPC4z54HqDu6BCYv
fIneAvjpG734/vWuQpEQcPj/VdM6VX3Zduog+usSnUdEw7LeNU7qxnIUChQ995Qa
JUlWAMMbrlf1/RPRYSQMeLw5/0O781SFqy1b9B7dX2qS2ZDMQryo+Ilu+QdU82Vf
bGt2b6X+Rg/BShb2ut9VuXV5sqQ/NZSGWqeueH5osLbPTGWV7pW2kqGOFxA9FQwy
872BjrsDUkDX8D9QhNxdLFA6iw2grg==
=XbLa
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--

