Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7144C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 12:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3052B206ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 12:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWyDLudh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3052B206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbjMj-0002O7-U0
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 07:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbjLO-0001iR-BV
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 06:58:50 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:33973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbjLL-00062C-6i
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 06:58:49 -0500
Received: by mail-ej1-x630.google.com with SMTP id o9so8287294ejg.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 03:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PNluf4X0VCuOoLT0A8ywjLlP/8uYZQDkMsALTSpkxUk=;
 b=HWyDLudhGgMXm+Vo6QepuXqiIRzpnp8tOKgLJfaCHKJbtGKBOM7lIdSocF1dueovTX
 NtGO4jyEWlkYY5GIeGAC1CKyO/tzY7LDZCxW3RIkx295Kx2VCMfdS90HbUS6zLZq48v9
 PdE2x0hkQrJtwyK4g/DCgc9O4s61S7OEgjbo4a6wNUGjJDsVqAp/talqyi19zkAGyuBt
 /ZZKKaiLbv1NrTb/RrDolKH0jEpWUpy34P/b2XH7nEmzyZ/l1SwuGs2jYTTlfOr7MMhq
 GuF3Z3o/dTY53KguJtvlgLCBZ7SAohxUaNw7/5SoxJ1iCoDbqmFGx7T14h2oVmZjPQrC
 4slA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PNluf4X0VCuOoLT0A8ywjLlP/8uYZQDkMsALTSpkxUk=;
 b=fKpSNjy0qEkizwffNoeIbxdxDoIUMRt7WxFh+d5fqLWD8nVVsKorHFArcCytjmDmFB
 Nwrc4xD2/VAxFGWLYQyU1Vd9ED0KRifWOd1v3BaOT3+PMcwnSMxooeBRLEz2S5EBwKGZ
 Ajjw4uAi18QUGOlrlON1MMBKzZy5TUK+TNZ/Vs6Lh88V8Yc7vlqqh22h3m+ODJiGqPzg
 IZHNeNt/+wD9lWvFc9yr/xadqb2piazn2j19tE1rH8i/2Yy34J1gkJGtmbiOZ3y+E9NZ
 CvtBB2kxCjrRqzAIbp7X2ebdXgGAHXXzd1h33MDJSGz3PQxl+X02rvzvP/emSnwM7R6H
 N70g==
X-Gm-Message-State: AOAM533euOtynfX9JAfWgTzuJFHXRzPeFA/Wv1Xw6EEopDz6f1XC0bo9
 7pJPcvUac+ZukyXsmlTq2t8aLPdoeMhwu/oud4MU7A==
X-Google-Smtp-Source: ABdhPJx1D+YDYDbNiJxsv14kGiB8XxQ4WmCc987DQX1bD/edoSWBoyo3FrmgDZTVXtX/LPyZopKNNrwDEvX+3is35LA=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr9941188ejk.382.1604836719794; 
 Sun, 08 Nov 2020 03:58:39 -0800 (PST)
MIME-Version: 1.0
References: <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
 <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
 <20201030101013.GG99222@redhat.com>
 <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
 <c75f91b7-6972-9e48-efa9-49792fc011d2@redhat.com>
 <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
 <de1d3c49-967b-bc96-220f-3deabc441dfa@redhat.com>
 <20201105155006.GP630142@redhat.com>
 <72985bcf-668d-7472-192f-502963d2b6ad@redhat.com>
In-Reply-To: <72985bcf-668d-7472-192f-502963d2b6ad@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Nov 2020 11:58:28 +0000
Message-ID: <CAFEAcA_dT_RQ8Pmk_S=zCSu1tUbptuP0+rtrsS55tEg+XD=S2Q@mail.gmail.com>
Subject: Re: Migrating to the gitlab issue tracker
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 8 Nov 2020 at 09:01, Thomas Huth <thuth@redhat.com> wrote:
> I agree with Daniel. Please let's not clog the new bug tracker right from
> the start with hundreds of bugs - that only makes it harder to focus on the
> tickets that are really important. Let's use the migration instead to start
> as clean as possible again.

I really don't like doing this kind of thing. It basically
tells bug reporters "we don't care about your reports".
We ought to at least triage them. Certainly for arm a
lot of the reports in LP are real bug reports which we
shouldn't just drop on the floor.

thanks
-- PMM

