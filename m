Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AC7C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A66320767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="fPbXJndt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A66320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmFh-0002w0-G1
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDmEd-0001vg-S2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:12:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDmEc-0006JF-5h
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:12:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id v4so2278790wmj.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nF0WZAxDl8wF0iMxS3Ok+GeArNthtrZG8PP+7UcEQtc=;
 b=fPbXJndtoxBIVkbJowBVqacbpuncc+fr61cRYq2WerQKTb9mFrJ6qEkkKgtJsuFHRT
 fAGPi3N09ekTdz7qv8nWSDb26o9B7VRb7J7RtIvn9ljAKtDvPJ16OtVPAcnLEc73G4d9
 RndpNZjKOAnFHV7odc0Mlavl8uchSpmXHSi2p3PiefwQPjm4BOEghPmXv8zo7lBKOID6
 bEDtev1l2OXfgqYCEEykm9nll5CRYVcCfTWR0hBQcoL6jqDFQpx6r8iEaW+2qvHVDZi6
 PsyQ46hJm8ikd9X/cwlBw14I4jIrkgeWCDd/DnzNBka+fklp4gkgcdl04zNH5iSWojgK
 zrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nF0WZAxDl8wF0iMxS3Ok+GeArNthtrZG8PP+7UcEQtc=;
 b=DXJj4y6YhWac8CgNbWy0FeG+2Z2RsAeDWcGPTtmwhWom09vk7soL4tztYHxP6NAHuH
 zLrfCGBy01WKzctTqHxxhU0ZW2XSVjPG5GK2C1Q0nui6DDs1YT0eI6fV3vjFjvHFV7zy
 vep+uRt5myvBWPGjuWbOVrFodwXbbvSjp9FuviKMdtzEuNXtidxUvYI+W7LdCi8OQKmz
 rjmaAfhN+EkMTCM9rxiiIIt8+VWAqHZLLJFtZZr35oH69lXNit0OSthCZwOG0JqD9kQV
 Ui7uFwybUn1rbUpbCcvxqfwitPGK1nJCy6r0wV7laMlhLR3chPrqAEplt7RIPjttvEyC
 1oJQ==
X-Gm-Message-State: AOAM530sObqzlZI7T6Vtuh7u65t5IuprN6pHrXuveHUlReQ0Ik9lL7+E
 TauJb9vCWLwm4c4qdz9cJwCo2pdk4v2z0cQMaf84ByK/Xbs=
X-Google-Smtp-Source: ABdhPJzmCwwKDlOnwRqlYBrr5QINgRE/zwEKvNagtQEVOMlBQdwe5upluqQledAAcAFim3UiPKfrfqacZcXT+vbbZig=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr1305674wmf.20.1599127968604; 
 Thu, 03 Sep 2020 03:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200829081233.10120-1-ani@anisinha.ca>
 <20200903060332-mutt-send-email-mst@kernel.org>
 <CAARzgwwFRUOoq7GOttzJVT8+67+7uNugC529SB8DX242p8A_QQ@mail.gmail.com>
In-Reply-To: <CAARzgwwFRUOoq7GOttzJVT8+67+7uNugC529SB8DX242p8A_QQ@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 3 Sep 2020 15:42:36 +0530
Message-ID: <CAARzgww8S4qd3Z3McEiwV=YFPRvj63pZ1oJe4Wx1njR0iE8KZw@mail.gmail.com>
Subject: Re: [PATCH] Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
 non-hotpluggable bus
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 3, 2020 at 3:41 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> On Sep 3, 2020, 15:35 +0530, Michael S. Tsirkin <mst@redhat.com>, wrote:
>
> On Sat, Aug 29, 2020 at 01:42:33PM +0530, Ani Sinha wrote:
>
> When ACPI hotplug for the root bus is disabled, the bsel property for tha=
t
>
> bus is not set. Please see the following commit:
>
>
> 3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on=
 the root bus").
>
>
> As a result, when acpi_pcihp_find_hotplug_bus() is called
>
> with bsel set to 0, it may return the root bus. This would be wrong since=
 the
>
> root bus is not hotpluggable. In general, this can potentially happen to =
other
>
> buses as well.
>
> In this patch, we fix the issue in this function by checking if the bus r=
eturned
>
> by the function is actually hotpluggable. If not, we simply return NULL. =
This
>
> avoids the scenario where we are actually returning a non-hotpluggable bu=
s.
>
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
>
> What exactly are the consequences though?
>
>
> The root bus

s/root bus/any device on the root bus
sorry.

might get ejected by the user when it should not if the user does the follo=
wing:
>
> outl 0xae10 0
> outl 0xae08 your_slot
>
> Please see Julia=E2=80=99s comment:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html
>

