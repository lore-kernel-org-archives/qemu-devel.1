Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD0FC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66828207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVj45ilm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66828207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MHx-0000oU-LJ
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j4MHN-0000Ny-7o
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j4MHL-0001ya-NU
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:08:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j4MHL-0001v5-IQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582106906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZFVOKD5woTctB9mvnspyLUtKF/EFQdcQ25djbvYil4=;
 b=YVj45ilmFMZ+/X8j2Azl0Lcq/EeheBngvAxfCT9oOuW0hy13+6huPZjW0e3WAUxacR60lL
 Jha6bV6WSSHfbmh5oONcwHorh+m+bvQuEm+UykT+dc5ZOEoLxKgkv7JpVTgIws1UUtWEym
 Gz/CuUxFyFGeeMA4uw1NsZBux4ieggQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-CiCA1gYWOcOs3LJ9iHWjnQ-1; Wed, 19 Feb 2020 05:08:23 -0500
Received: by mail-qv1-f69.google.com with SMTP id g9so2604695qvy.20
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 02:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qq14RJlGyB22JntZVIzHJcGUmgr8bvhsuw4qJdwnQPQ=;
 b=gpmQa6ah4mCbHf57UHglvyDA5FHIuiWJ4qNd3hvauykbXu0mLXUmGfEtaiPzi6FTT6
 Gn1agWo1TeN/RIQoidYC1HRke4+pjpBngjgTRpsShfTo3l9z2y8iVo6r0ozdK2Ea9EKp
 CxdF5M6cRXw6o2kU5QQBy83g9hQn/0D31Fe//xmprPHI1QEF6er8hwPHLB5cWPPotOa5
 28v/t0nY8VdhSlPpQUPc8FUqVnVDc50tRpqwxMNlkYns/7aGXGGmbXKJ2b9OCxrSJh+N
 IjEMKMvsFaUyhafvpfkFxED3hWUicmdMIWjPjJSb83I1AWa65w67HizM1X7HItJLnzBI
 i2hQ==
X-Gm-Message-State: APjAAAV2asx8scTx+zcvOzo70rhulltw3oQFfjWcvGKi1B9cEAwXvQvw
 PCxxY8Ki5rc1vOB9zO0lgOjt0VFOVhCWUsdCI8Cb9jPbULzvGIU2Z3hwqOaBVhM9K7D8xupzjB8
 o1AT80A159PWS2BY=
X-Received: by 2002:ad4:442c:: with SMTP id e12mr20362179qvt.19.1582106903348; 
 Wed, 19 Feb 2020 02:08:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqywVDQRj1LKFScZNJ+d4cxjLX/v9QPyyPDnc59yIKiSahYIHWQSPH4aa4AaTsMEVwKnQOUwDQ==
X-Received: by 2002:ad4:442c:: with SMTP id e12mr20362166qvt.19.1582106903064; 
 Wed, 19 Feb 2020 02:08:23 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id t12sm29595qkg.95.2020.02.19.02.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 02:08:22 -0800 (PST)
Date: Wed, 19 Feb 2020 05:08:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v2 0/3] vhost-user: Lift Max Ram Slots Limitation
Message-ID: <20200219050721-mutt-send-email-mst@kernel.org>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <20200206033248-mutt-send-email-mst@kernel.org>
 <20200209171442.GA14809@localhost.localdomain>
 <20200210110330-mutt-send-email-mst@kernel.org>
 <20200219053324.GA3052@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200219053324.GA3052@localhost.localdomain>
X-MC-Unique: CiCA1gYWOcOs3LJ9iHWjnQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 12:33:24AM -0500, Raphael Norwitz wrote:
> On Mon, Feb 10, 2020 at 11:04:28AM -0500, Michael S. Tsirkin wrote:
> >=20
> > On Sun, Feb 09, 2020 at 12:14:42PM -0500, Raphael Norwitz wrote:
> > > On Thu, Feb 06, 2020 at 03:33:13AM -0500, Michael S. Tsirkin wrote:
> > > >=20
> > > > On Wed, Jan 15, 2020 at 09:57:03PM -0500, Raphael Norwitz wrote:
> > > > >=20
> > > > > Changes since V1:
> > > > >     * Kept the assert in vhost_user_set_mem_table_postcopy, but m=
oved it
> > > > >       to prevent corruption
> > > > >     * Made QEMU send a single VHOST_USER_GET_MAX_MEMSLOTS message=
 at
> > > > >       startup and cache the returned value so that QEMU does not =
need to
> > > > >       query the backend every time vhost_backend_memslots_limit i=
s called.
> > > >=20
> > > > I'm a bit confused about what happens on reconnect.
> > > > Can you clarify pls?
> > > >=20
> > > >From what I can see, backends which support reconnect call vhost_dev=
_init,
> > > which then calls vhost_user_backend_init(), as vhost-user-blk does he=
re:
> > > https://github.com/qemu/qemu/blob/master/hw/block/vhost-user-blk.c#L3=
15. The
> > > ram slots limit is fetched in vhost_user_backend_init() so every time=
 the
> > > device reconnects the limit should be refetched.=20
> >=20
> > Right. Point is, we might have validated using an old limit.
> > Reconnect needs to verify limit did not change or at least
> > did not decrease.
> >=20
> > --=20
> > MST
> Good point - I did not consider this case. Could we keep the slots limit =
in
> the VhostUserState instead?
>=20
> Say vhost_user_init() initializes the limit inside the VhostUserState to =
0. Then,
> vhost_user_backend_init() checks if this limit is 0. If so, this is the i=
nitial
> connection and qemu fetches the limit from the backend, ensures the retur=
ned
> value is nonzero, and sets the limit the VhostUserState. If not, qemu kno=
ws this
> is a reconnect and queries the backend slots limit. If the returned value=
 does
> not equal the limit in the VhostUserState, vhost_user_backend_init() retu=
rns an
> error.
>=20
> Thoughts?

Right.
Or if we really want to, check backend value is >=3D the saved one.
Basically same thing we do with features.

--=20
MST


