Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD9FC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676092080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPpzmkXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676092080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgB2b-0000Of-JJ
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59810)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chmeeedalf@gmail.com>) id 1hgAvf-00019i-WF
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1hgAve-0004JM-JB
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:37:51 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1hgAve-0004HO-2u; Wed, 26 Jun 2019 12:37:50 -0400
Received: by mail-io1-xd42.google.com with SMTP id u13so6081189iop.0;
 Wed, 26 Jun 2019 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eLbdG4UnFVI/tE72kVCbYfoj31PWgbsP/uUtDLM1NPA=;
 b=TPpzmkXf4a4NgWWWGu8i4RS0vvoaQQzWMgs7YWm+GXCYVAx4gI+kCXEIdLNARlWwIB
 zFDqETYi/P8q3FSPbi8RPEzfYjy6oQVyxL77W0wKvJOmn66efcvZCn8n4oWGyvGBhm6s
 /A2zpb8ByQBzGq/op0/UExKw1DaW14YW8ihNHBWXR+/+tfQ2YVpby2pQmRR/kpP+L7GK
 TaQXXXIQUBSMus4gnDIadOtBNH+1ivHokVur8jx/o3l53AGB20lwwTBcVl8spOkwNvd/
 2bTZ3GO+S0YqxmtnnCjfq4NXh4fzK3WsuUmzUbFXxlOqyhTKlhGe7xZdW5MSHg0hgrJn
 mBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eLbdG4UnFVI/tE72kVCbYfoj31PWgbsP/uUtDLM1NPA=;
 b=QWNqlz8Y+P8WdmcaK34Gsn5JXXtXGOdCFbDA4v/hoGcVv4tIPdrDnXc15TFmcpM5qm
 OyAmu/dLOPuHolu0qllA4jJvYi31N/OxxPX5XMHv1SBg9hx3/hXmEx5wmCJQEANQR50y
 wQiIiTRA2bAvnOYCkfnNZ3pekL2joYZwU6yDcTlRdgQjuOMai9uu8bqbCAxr8ca6v7R5
 IX4wvQ3oqUS6pAzQbkfbrsM1jDCHSzNvY8OiTEUHRccu7ChwprhihrjL0FYi3c1f9bPr
 4YXHt3EDOfFUa4bOoA3gywkiu/vNitqppMR8ucFjA1ej78UyTpKHvYU4x92MYZi1uxZu
 GVCw==
X-Gm-Message-State: APjAAAUHjsBVbh5MZJ1qMKE31SgSmhnCL9hhvGLAYd8lEw/+CJ77odW9
 j5pfiulWJCKjru4G/pf015U=
X-Google-Smtp-Source: APXvYqwLPQdYquEUE1DbQUq802oalVZNQ+oDRo51l+p/wmFUTU2BXNKRe/goYJD6kqwmghrpP5VtAQ==
X-Received: by 2002:a5e:8505:: with SMTP id i5mr6213688ioj.101.1561567068514; 
 Wed, 26 Jun 2019 09:37:48 -0700 (PDT)
Received: from titan.knownspace (173-25-245-129.client.mchsi.com.
 [173.25.245.129])
 by smtp.gmail.com with ESMTPSA id t19sm14196051iog.41.2019.06.26.09.37.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 09:37:48 -0700 (PDT)
Date: Wed, 26 Jun 2019 11:37:42 -0500
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190626113742.6bcd8a26@titan.knownspace>
In-Reply-To: <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; powerpc64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [Qemu-trivial] Fix cacheline size retrieval on
 FreeBSD/PowerPC(64)
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
Cc: qemu-trivial@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 18:16:36 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 26/06/2019 =C3=A0 18:14, Laurent Vivier a =C3=A9crit=C2=A0:
> > Le 07/06/2019 =C3=A0 20:56, Justin Hibbits a =C3=A9crit=C2=A0: =20
> >> The attached very trivial patch fixes a startup bug that prevents
> >> at least Qemu 3.1 and later from working on FreeBSD/powerpc64.
> >>
> >> - Justin
> >> =20
> >=20
> > Please don't send a patch in attachment but inlined in the message
> > (you may use "git send-email" for that).
> >=20
> > This patch fixes "util: add cacheinfo" that has changed the type
> > from unsigned to long.
> >=20
> > You can add the following line in the commit message:
> >=20
> > Fixes: b255b2c8a548 ("util: add cacheinfo")
> >=20
> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> >  =20
>=20
> CC: author of b255b2c8a548 ("util: add cacheinfo")
>=20
> Thanks,
> Laurent

Hi Laurent,

Sorry.  I had never used git send-email before, so wasn't comfortable
with it.  I just updated the commit message with your feedback and used
git send-email to submit the patch.  I hope everything went well.

Thanks for your feedback.

- Justin

