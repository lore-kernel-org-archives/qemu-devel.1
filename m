Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67925C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5F3206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI1BZhPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5F3206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsMiN-00054E-Gq
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 03:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43142)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hsMhw-0004QA-5o
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hsMhv-0004MP-BQ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:38:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hsMhv-0004LO-4W; Tue, 30 Jul 2019 03:38:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id v15so56099436wml.0;
 Tue, 30 Jul 2019 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eltuFOdLPqZEtuP7u3U/Qb4bHZvG+c7oBho634MVhP0=;
 b=oI1BZhPxaPjsT0QanL3pwwE7F8yTU9MzQqLHR2bPVKIfaJi0+ws5jLjL0/zdX1Vsyg
 NkV7AC1DmzqiKjgUBlocaQ9YH2fVPnCh3amgsc2oFdR2dxWYABbO/cdYZAAugN8p1Rw4
 BWbQh//W/gTwhv4qD9+wUdAHDmrvxAeOWzGtFdsB02lh45ghZyYla8Y9xItXebtX+Uj4
 /ZhCKOZJhdX3UFX8nC2MURTpfTVx42+8szMF9eAnPAb57hSwASljOJExMbGhxWhfSjKx
 y4OVB5V6MZ4NKNwtm2byuaeW2dVf1rf0ojYMyfr3glCLroTN6n5dLKD/OnEcsDdCSSQk
 pPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eltuFOdLPqZEtuP7u3U/Qb4bHZvG+c7oBho634MVhP0=;
 b=p6a+41aGaoS85dx87UjenNpjQf56xv5CXhc0J56vzvIfKHVGEOKUq68vqwLeWGE4o9
 hDRdwh+ihkDXW5/jqK6n1rOgGO6uZt6D1IJ5X7Bp60nXPF5EfeX+gKIiOtOVijjdPerT
 BKJ5GZ8XlzMM//9KK5/xGOqTANZEbCXck47lsLzdlM5SpSq8z/kUafhOfLxlikqiF6hD
 8WwsERb43E0jvbmWDNA0nGZmStbL4nbGD+O63n1SCsuCRw4nd8InskY4nxJbw368rGjC
 sA9WqDbxn0uR8/rsTWb6HTDPVhPftTSZH6QnuxUY5o1zE7gJ8DhFH7pubaHakhQ9Obx9
 ecTg==
X-Gm-Message-State: APjAAAWbhhvbLgHOfDJ3O4Ax82Mk+coQ3HdgnILByQSQu3Brptoz3ur9
 XYqy44iInjOfUe6A+wMQctA=
X-Google-Smtp-Source: APXvYqxTazt+3B23aNL4UM1TkSNc7Qz2NiLnqY2tRlIS8n8DcS2FvdVUj2gVhltzP5TamV3i4zcIjA==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr107897391wmj.116.1564472282153; 
 Tue, 30 Jul 2019 00:38:02 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p10sm1954995wmk.2.2019.07.30.00.38.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 00:38:01 -0700 (PDT)
Date: Tue, 30 Jul 2019 08:38:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190730073800.GE30213@stefanha-x1.localdomain>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
 <20190729151651.21306-14-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <20190729151651.21306-14-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v7 13/15] qemu-nbd: adds option for aio
 engines
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, saket.sinha89@gmail.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 08:46:49PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  qemu-nbd.c    | 12 ++++--------
>  qemu-nbd.texi |  4 ++--
>  2 files changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/89gACgkQnKSrs4Gr
c8ixxgf/ZO2pjklEcqyAs+/npMoHATz71AoFFRg6ndeMTmNIEKB1e4Et4YBDE674
8BWsbhOkVQDssgHJHmgnUqidhiTK+/xiHEOUtqycclMhCv/X9fWpdcNyBZTaD2b3
Yp/QAMY0UdKdtpeVCwEWoyFzBQ3bycE6Eu8WceUpCM0WWxcrz+RKE7IanarQ7kFf
BYDF+fuQpN7SOzQKjnHk56Ju2Ibq5wA4VFDT7UsE0bG5Z2kPbaGXTeuZC0ViXq4c
D0wXbnyK9ACm41qqJRCKTEOcMFs6VwKkSz7KIWmN1cE7B4RXG8XtxAloQR9d63OC
eboNuVzseIjK5W5CQ9K5vAH0zjraCQ==
=CPmG
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--

