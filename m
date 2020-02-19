Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B71FC34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 03:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574DC20801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 03:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJDj1ws+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574DC20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4GLO-0007Aa-Js
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 22:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j4GKX-0006jQ-1f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j4GKV-0006ME-0s
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:47:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j4GKQ-0006DM-TU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582084033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7FT3/Ibq2GXBNjdnFiSWj49dgV/LmJNn6JmL4naf0o=;
 b=gJDj1ws+LKgBZ6cOzStfladdYu5/e/gtY9EYj2Hyk0YWLzdAMUY5qRjPHpVP1U8mGmaOMT
 clIKOW+YUq+mRYWAVT3Q9EzqdniMiPM2eaPCekBQ2oAVYwevQ2LXv4y68GHwTYTkYqAdzm
 DVfGn/FOL/yM6M1ftQvszW/isg93sUY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-Hdq7j4u7N1KJfe66X9_sDw-1; Tue, 18 Feb 2020 22:47:12 -0500
Received: by mail-qv1-f69.google.com with SMTP id g15so13777412qvk.11
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 19:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YjZweJEA+07bX8ZlJi3mbHa4b6RWLdQNVRLIdk4tLRk=;
 b=mFhbI7wlTxkjnCnEJE0MlAS/mT1qLzE1PaZQDw9CM/cOSMD8vVlh3Q26bXqWsePql8
 dQ7yxSrx/T0ItUkft19+J2ifusABoWIIlVwoPRraYIWFAMrd1d+nAsCj/DWgSqY07ajk
 E5yM33q9FsPYMDjfvjJlXtcXzabli7VRsbY/lyKdt864zwLRn9nMGExqxeRJkvMP5+Vy
 Kw3UI+ftg4KnZ+hjxV2g6d6VhyA6b6p39D/svh88srV/c7PGjngkQh0Omi41Z/PC+Ip0
 +q4hEighyKtXXNdYn4VdMFdFNzywDKjMjDF9ZZzXXGfQX3VpXKpe6LS4E/lU7JrjTsub
 Nb4Q==
X-Gm-Message-State: APjAAAUEBhkwPbzsPNNyrFLT5yoXwtg34cMBtnJR5CYZkldvYHvBQpv8
 H50JuRUD+et9lQFvv9dMnu249d2pIB7U7bt2I10rXJ4a59Ps3Dav8143HnOIwc3q3fqFD0YUkp4
 BN00hNkHWD0zYlAA=
X-Received: by 2002:ac8:1b59:: with SMTP id p25mr20622796qtk.336.1582084031697; 
 Tue, 18 Feb 2020 19:47:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9dKegaO6CRxMJF6P6THPS3z0dEkijoaK62FkQQvV+vCmv7jzyrksPYKJUjTey+wIrLLDL9g==
X-Received: by 2002:ac8:1b59:: with SMTP id p25mr20622785qtk.336.1582084031481; 
 Tue, 18 Feb 2020 19:47:11 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id w202sm379797qkb.89.2020.02.18.19.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 19:47:10 -0800 (PST)
Date: Tue, 18 Feb 2020 22:47:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laine Stump <laine@redhat.com>
Subject: Re: [PATCH] pcie_root_port: Add disable_hotplug option
Message-ID: <20200218223104-mutt-send-email-mst@kernel.org>
References: <20200218161717.386723-1-jusual@redhat.com>
 <d872dcc7-9275-1354-ce6a-7dd52ac33929@redhat.com>
 <CAMDeoFVQis-UXKpGZNJkD9NqyozwUxW+nn_h6iv+f-EgkLeRKw@mail.gmail.com>
 <9ea6a6b9-778d-78a8-1909-dce1ed98a24d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9ea6a6b9-778d-78a8-1909-dce1ed98a24d@redhat.com>
X-MC-Unique: Hdq7j4u7N1KJfe66X9_sDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 10:02:19PM -0500, Laine Stump wrote:
> Also, is there a rhyme/reason for some options having true/false, and som=
e
> being off/on? disable-acs seems to be true/false, but disable-modern is
> on/off. Doesn't make any difference to me in the end, but just thought I'=
d
> bring it up in case there might be a reason to use on/off instead of
> true/false for this one.

Some places accept on/off, some true/false, some on/off/true/false
others on/off/yes/no and others on/off/true/false/yes/no.

In this case both user visitor machinery. Which I *think*
means on/off is the safe choice and true/false can be
broken in some places.

We really should clean up this mess ... Julia, what do you think?
Let's make them all support all options?


--=20
MST


