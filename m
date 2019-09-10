Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0295AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7C420872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWvOoPSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7C420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aVy-0003oS-Ve
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i7aUr-0003K0-Gl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i7aUq-0004CN-F4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:23:29 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b]:45410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i7aUq-0004C5-7Z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:23:28 -0400
Received: by mail-qk1-x72b.google.com with SMTP id z67so15908014qkb.12
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BNvUO72Mk1Bm49vO+1tiTgYFrR7bPUFr8scU53PG80c=;
 b=RWvOoPSZlaPhxIf5MhuLb2xDVsVmGF/eFdqfuFiaCmAVsEjPtMcPYuXZu7RV6CAy9n
 jwasUJdqyjGuhi5lENa2VFxXECHhWxBQY3CK6gcCJgmS8mz+1PAecwGDRzADVRxLbA32
 U2tPxmZpc7HsYDnZ7zKfI2oSKFVXvRfY2zDyND+SAQVBjyjfs15MS8XyWiXEazlE0Rt/
 C5cfNHLOUdVUfNmgeiRiV13flyCCMGUPaRlItekawnZcTQ0ZYj8KtpiQwnowtBmurIM+
 wefzw/rYP+bdkBpipAMQ/0FzHlxiqVbLtNeeA+/C2RMr58Czn2je48gouvzLXbu1da1w
 wlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BNvUO72Mk1Bm49vO+1tiTgYFrR7bPUFr8scU53PG80c=;
 b=siLVELJYKDgl9XaZFynVU4QSWEckqgnSwUt0tCN+C3kjQ0TEZmUTwD4e7PW0t6RhUK
 7Ac/Yd5SuY/POtlDIX+Vk/t4g+jF2/OD9/18du2GrzxGNlpkkxPxieddjvLkh8Choayz
 D7ooQnaD+vuUrIID4M+QmeWhoBoLVK555BNVQvz04RMEX8RhiG8Ha74ONZ6uu70w82x3
 V3S0yp+6hDgl74qXbHZivSEEabFtnBf7LWTQbLgTFDTz4FYgY/YfrJoVGnt4V4NksffF
 Rmx5g4v0MtzqDsIn6Itz4MStf2YkBG7G9Kz/DOdi2C3ACmtsdTD5Kg237eZ31d4T6Vni
 cdGQ==
X-Gm-Message-State: APjAAAUwWXKYk9/ThSy/lnegvP7FhiiC1+eGqu1xWYWryxsBlZatzoHS
 3dRC8MzdEC+P01e6I3ftspTH3+7dVPu5w5Gs858=
X-Google-Smtp-Source: APXvYqzWAQDhKSKSqLfGfr1gmFbCZeah2IV4OJOBdFOg/Ki98xDamNTKVCtiQo/n+b+rT5sKL05sluRTLnyUrZJN7JU=
X-Received: by 2002:ae9:ee0d:: with SMTP id i13mr5058312qkg.196.1568100206730; 
 Tue, 10 Sep 2019 00:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <21182000.2zn5IIMESL@silver>
 <20190902173432.20f2637b@bahia.lan> <2734436.Mu773bgsdE@silver>
 <87r24xqjoz.fsf@fsf.org>
 <CAFEAcA8yfdJk74rybVCdc0gJDoAHO99LWHwvGVfh6CgueH6cfA@mail.gmail.com>
In-Reply-To: <CAFEAcA8yfdJk74rybVCdc0gJDoAHO99LWHwvGVfh6CgueH6cfA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 10 Sep 2019 09:23:15 +0200
Message-ID: <CAJSP0QVfcaj=O_uDCbMycdNKfbP+3bybtHmQgecG+yPsRC1oxg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72b
Subject: Re: [Qemu-devel] DMARC/DKIM and qemu-devel list settings
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, antonios.motakis@huawei.com,
 Ian Kelling <iank@fsf.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 4, 2019 at 4:30 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 3 Sep 2019 at 20:11, Ian Kelling <iank@fsf.org> wrote:
> > I don't know who has the Qemu-devel list admin password, but whoever has
> > it can adopt the unmodified message fix by changing
> > dmarc_moderation_action to Accept here:
> > https://lists.nongnu.org/mailman/admin/qemu-devel/privacy/sender and
> > remove subject_prefix here
> > https://lists.nongnu.org/mailman/admin/qemu-devel/general
>
> I'm one of the list admins, at least for the main qemu-devel
> list; some of the sublists have different admins (and
> perhaps different settings -- there's no way to conveniently
> say "manage all 5 of these lists with the same policies,
> so it's easy for them to get out of sync, deliberately
> or accidentally).
>
> I have been considering whether we change how we're handling
> the DMARC problem for the list. I picked munge-the-email
> initially because I think we didn't really understand the
> consequences in terms of patchmail, and also because there
> was a group of subscribers who complained that they liked
> the [qemu-devel] tag, used it for filtering email, etc.
> I think overall my opinion has shifted to thinking that
> the downsides of munge-the-email are too great and we should
> indeed switch to not modifying the message at all.

Yes, I think so too.

Thanks for notifying us, Ian!

Stefan

