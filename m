Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD49DC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE61F207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1rCfzwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE61F207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKiQM-0007LO-0B
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKiPC-0006lO-Dk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:32:26 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKiP0-0008Vz-6i
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:32:19 -0400
Received: by mail-ed1-x543.google.com with SMTP id j2so16148863eds.9
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Mh+LNtfUAHDK7CxCAD0PAeotC4VSwWs+TaeU+cM3IA4=;
 b=R1rCfzwXL4XFrJWy0wSYcxTEFfgjrgqxT3HPYCJKXBQ98l5M2NGnjsmrMyOz98CVza
 0ewOFJk2YXGIdfSp51f961oaWWHjn0UEEdjC2+kTmoEnMkZhJQNtJ+xDbXINoHGyce98
 p7gvuKOrLLMqnHmQdDNZdU03MyYHmk8Znx6HHXAxRVwi0xCdmeS0VTPr1lsiokxSbJ64
 6vpOusBas++g7q+NIlSac+pQzq8YvhKM2k9lkPa0YT/VbMA1ItpEQbsh6Z6jYbabOmZF
 mLo2p4XqktXxIZVYWByzzQKgNtsYg+YafJuBATzTyyfCpdgYdyofG2054G4TpqRW7T8k
 xHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Mh+LNtfUAHDK7CxCAD0PAeotC4VSwWs+TaeU+cM3IA4=;
 b=EgrLNqwBht249BMhty7F/RfxXbQlYQEB25uAkSTcopnLaIAH4Bwzs36DEB03FerXYb
 j/WQCcr+5pq98QVP83WL6q232S1mKz1DZJSpXxdME3jG0SbJlqNUgvqsYaienWhKuR2f
 osIZdODCjqnhHIcuDCeUDvdZZWwT/1We1jHuxnsHQ6mGmmnwdUkVwtgLwKHET51eaPFv
 zCYe5g4c1VD2lQrnHbrdf/UIZU5sRaymQb0BYW8bXLlPvUYiWgJswNIz6rDxgMIjL0Z/
 0Rp0dVWi77Uv+WXsKRd58rA49NJiAEKM5JymigmTPyHV1PeLvTYH0wALCKuEkyj0rgkX
 IGaQ==
X-Gm-Message-State: AOAM532UCjKZ7Igqdg8W4FUXRyvl5rLGWSdWnngCxNABlvaMuLbV/sTn
 Hiso7N+zBHofuDnHaUnJ1nXPfVoUmNX6ga0jPJIzxA==
X-Google-Smtp-Source: ABdhPJxKCL6QeclPcOiPoN1Rgnp7ADS2yTnmu7X0Oh9WQflIxFsC4lXF66vKhFdqidm6YU3qlYx3wqbRM7i36u0jfGw=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr4032163edb.36.1600781530050; 
 Tue, 22 Sep 2020 06:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200922130806.1506324-1-pbonzini@redhat.com>
 <CAFEAcA8kovt998Ds0jbEAJTqkHmJETcHvfwqCS-JZWWW+=wLrw@mail.gmail.com>
 <044dc012-1203-e3a8-0758-b0fcb2d932a4@redhat.com>
In-Reply-To: <044dc012-1203-e3a8-0758-b0fcb2d932a4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 14:31:58 +0100
Message-ID: <CAFEAcA8Tssk+9YgsE5MMnar8fq+XjuVjo_u-YW5BnZA57oOt_Q@mail.gmail.com>
Subject: Re: [PATCH] coverity_scan: switch to vpath build
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Sep 2020 at 14:27, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 9/22/20 3:18 PM, Peter Maydell wrote:
> > This comment at the top of the script:
> >
> > # This script assumes that you're running it from a QEMU source
> > # tree, and that tree is a fresh clean one, because we do an in-tree
> > # build. (This is necessary so that the filenames that the Coverity
> > # Scan server sees are relative paths that match up with the component
> > # regular expressions it uses; an out-of-tree build won't work for this=
.)
> >
> > is now out of date and needs rephrasing.
>
> Or we can keep it as it, since commit dedad027205
> ("configure: add support for pseudo-"in source tree" builds")
> already create a 'build/' directory.

No, because even with the pseudo-in-tree build the paths will
no longer be the relative ones that the real pre-meson in-tree
build had, so the comment is no longer correct.

thanks
-- PMM

