Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC363C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20E520578
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrwlBrpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20E520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhNI-0005TK-0t
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jvhMi-0004xP-Tj
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:22:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33161
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jvhMh-0007u8-AP
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594819346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZcHm55zGDOiGRFwz5DbqLxIU8dZdbFvwFKQOO6VqBY=;
 b=NrwlBrpGbSHesX+1qZKZv9LahYSC+AFtbN9TEXf4oltxtP9YE4TJgi0tFw52Hxr1zVY7pH
 oZYTozurmTQsvEGYW/0p51h6DRS9IGwG2XiVvE3GH1nD72vXQbwyBXmbZU5mlKFN50OC9t
 SK/7ogD6k+vxnjvByGaYtnLG0oDBa7A=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-m6vXHBuAMrSX4inCMbCFDA-1; Wed, 15 Jul 2020 09:22:24 -0400
X-MC-Unique: m6vXHBuAMrSX4inCMbCFDA-1
Received: by mail-oi1-f199.google.com with SMTP id r62so886224oif.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 06:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WZcHm55zGDOiGRFwz5DbqLxIU8dZdbFvwFKQOO6VqBY=;
 b=alAa+jKu/ltYWjBFWB655QM6QOnVRrkjbbaV1F9ynjI666RtFRcsL/DzxLln0uDJMY
 9ShiOphwP+cnBKVqpe0QJ9Xm7weW9iDzB03VmLJv4a0+FUD6EunFwQZGaA3QuCb5MJoQ
 Y7+jd5qms5r+zMmVLuAdQE3bSflOBw2F01zJ5cXx0TzaUvGABqaQPzHkpPZLvZCzsY3M
 738QC2Er4Ny40JJckmrDogXeqVFYRra5A1GHMTF/RIDeaNiJS4kPjPHBQp+x6MmqKdtT
 KBbcFm43y066hiegTOjOXepYNQTlDVVcjJD+M4vyGOmPBzClSZiE63nhsZyas+99irZT
 1UOA==
X-Gm-Message-State: AOAM5330dgwyEMQXB73aEuvzOYvRq3C36qhPVBhViXPVhqCjO9a2Vq4D
 sZeiBIYzD6v6Ur3Ocu4SHFil91X/pyA1uiZ0kZqP1DBdXGy8MkNN39Ol5PG9zqKfXKLJncQMuif
 S98jeOCkTc/vsHMOrq7EnNwvU9OW9K7Q=
X-Received: by 2002:aca:5350:: with SMTP id h77mr7406832oib.156.1594819343564; 
 Wed, 15 Jul 2020 06:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLLnG/XpwWFNE8QQMh3KjoJ2oj/qUr7LQNwje+mtsj9R5AfSx0V1huLFMsmLvcSfs/97s8aJQiAg9acOPZS5c=
X-Received: by 2002:aca:5350:: with SMTP id h77mr7406816oib.156.1594819343349; 
 Wed, 15 Jul 2020 06:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
 <CAMRbyyux0eQo8vmz4JB8pT_1i4PJviQJPKiaJC6ehwjLhc649A@mail.gmail.com>
 <20200713165637.GH10318@linux.fritz.box>
In-Reply-To: <20200713165637.GH10318@linux.fritz.box>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 15 Jul 2020 16:22:06 +0300
Message-ID: <CAMRbyysaB5MDWGz7upg-O=N2vhQn4OUdZVsqeBothYBtZyy6ZA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
To: Kevin Wolf <kwolf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 7:56 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 13.07.2020 um 18:33 hat Nir Soffer geschrieben:
> > On Fri, Jul 10, 2020 at 5:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Unaligned requests will automatically be aligned to bl.request_alignment
> > > and we don't want to extend requests to access space beyond the end of
> > > the image, so it's required that the image size is aligned.
> > >
> > > With write requests, this could cause assertion failures like this if
> > > RESIZE permissions weren't requested:
> > >
> > > qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> > >
> > > This was e.g. triggered by qemu-img converting to a target image with 4k
> > > request alignment when the image was only aligned to 512 bytes, but not
> > > to 4k.
> >
> > Was it on NFS? Shouldn't this be fix by the next patch then?
>
> Patch 2 makes the problem go away for NFS because NFS doesn't even
> require the 4k alignment. But on storage that legitimately needs 4k
> alignment (or possibly other filesystems that are misdetected), you
> would still hit the same problem.

I want to add oVirt point of view on this. We enforce raw image
alignment of 4k on
file based storage, and 128m on block storage, so our raw images cannot have
this issue.

We have an issue with empty qcow2 images which are unaligned size, but we don't
create such images in normal flows.

Nir


