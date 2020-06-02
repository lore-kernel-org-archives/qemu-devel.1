Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E66C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB113206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKuWGnKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB113206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCXi-0001H7-Gt
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgCX7-0000nc-HK
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:25:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgCX6-0004TB-Fq
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:25:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so4503660wru.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IC8Fssx++NCWFdJbhA43Le6p2QPbMZnvUDks/dAdLWI=;
 b=kKuWGnKugmoNENaeLk3NmI6zbF5f6vxol2Pg1SWG2JO1CljMaRymSN2SGJfaIi1+ES
 tHeJjwvurgW1XJnK1M75IDnzMFOvU5WcPO6nsvPBeUyFCvCKl83VibPnqpwnNaYZSzgh
 JcIb2ITDcN8cbjWsOL7nzmMfDoj0uNrpoW45yNhNgn2TxOiwtWzI1dXI+rTazhoUo5nH
 RzFx9AWtRaOO4dOJINdDnjNyDwBOSjEVDHM+eg1D8qAGITYQ51j+IO1RFlkZLpO2QOTh
 R9OoqhTbt9fD0yFrC8RpWK8IefGmN5VDXqRaLUqqQXLJ7PGQCE2kbp73NHqVbm5arLvI
 ImYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IC8Fssx++NCWFdJbhA43Le6p2QPbMZnvUDks/dAdLWI=;
 b=pCthjbUmjSIRWKysXzLAQZ0C29YIqFlzeB9CTa39FfnfJ6vytcH4WuUsQerwY3KIJ7
 tnkgtNCg6CmVpt9QSOr6Th8SVTZi8mePFcuOPd+HnOSQrHkFk7/WLSNgT58LJ7xbwHOy
 G1pfEU6QD2mw70wXdllQjW2wM778R3KKwSrfESE7IX9bycc2jSF+qyhjVTeWgCylffsj
 mOnqf2t05xcTNdy3/3v2s+RerW0jXtsF8JMAso7AWAXEKhVSqke4qQtFOqwtMMOEDkYm
 RQmO0AeKwOhEFX6G44K/BH5gUM43BGk/IlUi2DO4yEJQEZTcnSBqXnYkmXrlvFyVUQfX
 gfSA==
X-Gm-Message-State: AOAM531ZCHgygKzeffB8+IZ/Ummww/ikbATQeofHyvq+EyvcpmtbNl+0
 w8sLYxN9kUlXSr06n2pK7sT+6Q==
X-Google-Smtp-Source: ABdhPJyfdyF800/F6/1S0dczv9hLN3KSzJBjgGqi3QCZLdSbRoa2efv+DliJ6wBF6NUD2os3pu7pSQ==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr26327376wrs.234.1591125906839; 
 Tue, 02 Jun 2020 12:25:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm5569148wrm.96.2020.06.02.12.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 12:25:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E08A01FF7E;
 Tue,  2 Jun 2020 20:25:04 +0100 (BST)
References: <20200529132341.755-1-robert.foley@linaro.org>
 <20200529132341.755-4-robert.foley@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 04/12] cputlb: destroy CPUTLB with tlb_destroy
In-reply-to: <20200529132341.755-4-robert.foley@linaro.org>
Date: Tue, 02 Jun 2020 20:25:04 +0100
Message-ID: <878sh56zjj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.puhov@linaro.org, cota@braap.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> I was after adding qemu_spin_destroy calls, but while at
> it I noticed that we are leaking some memory.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

