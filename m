Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BB2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A7C2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKbMsOCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A7C2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6yK-0003cv-0M
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iX6sR-0006br-Jo
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iX6sJ-000735-93
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:01:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iX6sI-000722-RL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574182869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDPm86k5Fq03D3f20xXIH24X9RtgtIxADSFz9vkU+EI=;
 b=CKbMsOCHp3nqOC6euC2LKjYRXB8nzyg4Z3oADidFdmFqXEKcu6lZa/OrkCvrFqwVLmJiZ2
 ODolc0yGjrYGqlcm1CG7YWX7WYmU35rxzNv2MpVgYFDswnV4XS1mznn9xaHUErmUbbTK6j
 vfD2lHoAR2PFoWrwL0oW0IbQbBamrH0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-od3RtUFpPMuRhkJ81CFcWw-1; Tue, 19 Nov 2019 12:01:06 -0500
Received: by mail-qv1-f70.google.com with SMTP id m43so15090653qvc.17
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/LkNCiYwWKSBGqYEZtdUPk0L85Dp5XIJEuuF85ESeBw=;
 b=rrMq7V0l+sA/KGhxwn7Q+zSmTM2eGieCGpaxDlubHGJPUrnBHRchohKsdlguYGPOf5
 UMgMhD7JKTunaGU92pxHNGYr6utBZPmedijNxxEQqoEq8pz9zV6CgvdP/gcfx2Q/BTGu
 Akc+wXdDJjlLQ3er2ZAyxG8UxfsgeIPZgPW3tkqSlOH95/7LfTY9LkNtaun8FFWZFwAK
 WJYmS9+JirdtzsOCfCdm6LDt0ALDcPyiD5Jmk+WSc46f4Oa+X8wS1rJ468ThdqiYz08C
 FX6CVc26N7XSM4Ma3+1aZs+NQOaJG1ltpUfFS2vQnyIOJrUL0xToBnkwojQejK4Kf6dq
 fXjA==
X-Gm-Message-State: APjAAAWzIBzNWEKM5EOceNfIgJ2nZ//LKijq9z6uHwEnwTOyss7SCmE6
 aWuNesDUnQPyHBRJTv7KaFztThol6Q6UD4mYLin/pucpWX5e+PgQKZXkChZZQnAzSQBhzDaJCwD
 mLSbSJmc//f28daA=
X-Received: by 2002:ac8:7550:: with SMTP id b16mr33434751qtr.286.1574182865808; 
 Tue, 19 Nov 2019 09:01:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMXdfFiaIpdhJb3hNt3RdIyiP7KzpBUaRlF84G2qHprHAux2WjVk8Je8OvZxYG87c5if4qQA==
X-Received: by 2002:ac8:7550:: with SMTP id b16mr33434716qtr.286.1574182865513; 
 Tue, 19 Nov 2019 09:01:05 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id m22sm10282372qka.28.2019.11.19.09.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 09:01:04 -0800 (PST)
Date: Tue, 19 Nov 2019 12:01:03 -0500
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/2] TM field check failed
Message-ID: <20191119170103.GM9053@xz-x1>
References: <cover.1570503331.git.qi1.zhang@intel.com>
 <20191119060259-mutt-send-email-mst@kernel.org>
 <20191119162110.GL9053@xz-x1>
 <20191119113853-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191119113853-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: od3RtUFpPMuRhkJ81CFcWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qi1.zhang@intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, yadong.qi@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 11:39:04AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 19, 2019 at 11:21:10AM -0500, Peter Xu wrote:
> > On Tue, Nov 19, 2019 at 06:05:11AM -0500, Michael S. Tsirkin wrote:
> > > On Tue, Nov 19, 2019 at 08:28:12PM +0800, qi1.zhang@intel.com wrote:
> > > > From: "Zhang, Qi" <qi1.zhang@intel.com>
> > > >=20
> > > > spilt the reserved fields arrays and remove TM field from reserved=
=20
> > > >  bits
> > >=20
> > > Looks good to me.
> > > Also Cc Peter Xu.
> > > Also I wonder - do we need to version this change
> > > with the machine type? Peter what's your take?
> >=20
> > It should be a bugfix to me.  With the patchset we check even less
> > reserved bits, then imho it shouldn't break any existing good users.
> > So we can probably skip versioning this change.
>=20
>=20
> Can you ack this patch then?

I've commented.  I'll wait for a reply from Qi or a new version before
I ack it.  Thanks,

--=20
Peter Xu


