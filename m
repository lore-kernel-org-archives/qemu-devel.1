Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21939C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D918B2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyS6ApEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D918B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvi9P-00076B-4A
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvi8V-0006YM-Q9
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:11:51 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:39601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvi8U-0000CZ-6Z
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:11:51 -0400
Received: by mail-oi1-x230.google.com with SMTP id w17so2298257oie.6
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qa3PCUQ1OfduItsrVC4+c45iCBoyD4BdhhRaNmIb0us=;
 b=iyS6ApEg8nepmGn6r2C1d9pfrz0aJyucsK8OC0wrPA66rEMccLD8COnuvyC5Xepyo6
 JePdv/mBfuRUvU/FmwzQnrGi7S1dY2UlqAZbJlCHs3JvZp7PyLFXkbXnAw6yDHAPenyV
 MUASmIGoqDKc72/4JC4laltCRrUBPehWZxtxHLTnin9kchgIEsjb7h+VG5bfnMFY1bjL
 rK9FcDDOaaXyuujUfqdAFLq46/jpAOhYNRAbJOW3+T9wQbN2pZavte7y1jH0GsLaCCI9
 b9Eb7hNJy4Qq6X/bYvGkRQf/ADWjBpMMQ1zkJ1RJEDHNXHrrg0s0vJ34cPE7/r/uzsHI
 4Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qa3PCUQ1OfduItsrVC4+c45iCBoyD4BdhhRaNmIb0us=;
 b=tlwSbX8Mv9mD1MfyZEF4XgThSsah2yq1qk4+RojOL1/MLpU8wLCondmeiPxo85U/a+
 rvMb8+AHq8CV++mhuz3pkX+7RzfxRIupvx8qzPcj08cVVrL3Hh+jc2tjifLbGjOjWvjt
 24HbSAFOAfRp/fXj+G3IbAV8Y8CjGPnuTn69Q951REr0usst5oAnA6cZyrrkGcP8/KKi
 V/ZQ3OdLK3gjSj9TvYO1ukyYA0EpoA6KRkx3nDHyl9vbTFWq8vcrbFDSnE4jXdpU79sn
 51CU/K8nAJYUPpgyE4Fi7hi7z2YwdvCViJp42lub8fe4yTBo8S397OhFYzGDk+TjIbFi
 9Q8g==
X-Gm-Message-State: AOAM532FgPDa99fwwftRbDvq4gqHHWoxK2PCt5eh15+aEF4224FlNLki
 tNSV06DBFW1fvXHndrgVIuXQRfTcTA+LIBEpv4E+Yg==
X-Google-Smtp-Source: ABdhPJxORFd4uyiLd3qVnldqsnjzx6FzHWz347oczmtLazJcZmiQPVF2bXUNcr4z+F+ClDQ8xcy8/MazmG8K3FRwRi4=
X-Received: by 2002:aca:2819:: with SMTP id 25mr7356886oix.48.1594822308794;
 Wed, 15 Jul 2020 07:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
In-Reply-To: <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 15:11:37 +0100
Message-ID: <CAFEAcA-P723rFSv9nn6eSbzRuSwMzHDxDPTAR-68-i_AZsDUaQ@mail.gmail.com>
Subject: Re: sysbus_create_simple Vs qdev_create
To: Pratik Parvati <pratikp@vayavyalabs.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 at 14:59, Pratik Parvati <pratikp@vayavyalabs.com> wrote:
> Can you please explain to me in brief on buses and device hierarchies (i.e. BusState and DeviceState) and how they are related to each other? As I can see, the DeviceState class inherits the BusState
>
> struct DeviceState {
>     /*< private >*/
>     Object parent_obj;
>     /*< public >*/
>
>     const char *id;
>     char *canonical_path;
>     bool realized;
>     bool pending_deleted_event;
>     QemuOpts *opts;
>     int hotplugged;
>     bool allow_unplug_during_migration;
>     BusState *parent_bus; \\ BusState is inherited here

This is not inheritance. The DeviceState has-a BusState parent_bus.
Inheritance is the parent_obj at the top: a DeviceState is-a
Object.

>     QLIST_HEAD(, NamedGPIOList) gpios;
>     QLIST_HEAD(, BusState) child_bus;
>     int num_child_bus;
>     int instance_id_alias;
>     int alias_required_for_version;
>     ResettableState reset;
> };
>
> and BusState, in turn, inherits the DeviceState as
>
> /**
>  * BusState:
>  * @hotplug_handler: link to a hotplug handler associated with bus.
>  * @reset: ResettableState for the bus; handled by Resettable interface.
>  */
> struct BusState {
>     Object obj;
>     DeviceState *parent; \\ DeviceState is inherited here

This isn't inheritance either. A BusState is-a
Object (which is the inheritance for this class),
and it has-a DeviceState parent.

Anyway, the two form a tree: every Device may
be on exactly one Bus (that's the parent_bus link),
and may have one or more child Buses (that's the
child_bus list). Every Bus is owned by exactly
one Device (its parent in the tree), may have
multiple siblings (if its parent has more than
one child bus), and has children (any Devices
which are plugged into the bus). These parent-and-child
links form the qdev or qbus tree. Note that this is
an entirely separate thing from the QOM hierarchy
of parent-and-child object relationships. It is
also entirely separate from the class hierarchy
of classes and subclasses.

thanks
-- PMM

