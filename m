Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7369C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FF0207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhwfgSoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FF0207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtokP-0006Hw-Up
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtojR-0005Ma-9X
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:50:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51711
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtojP-0007d3-As
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594371005;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Sujqwt9PQuEHjpHbgGmsiu+y6vspVGQ9YRyaWGhpHJI=;
 b=KhwfgSoBsaKfAIdPOvIlZwuYI3bSodPRhmWrsBYBKq1MXw8E60QUj18VJLhdGsZQKQQe9T
 YwO1kksTI2tNX17eUyFe8Z8lWXRM+w9xdxux33wulRD75+3SNlBv2v4zm2ldVacFIaXcbW
 eFX8xpA0muPe7yxTKg0ob/xN7ei96gQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-xh6Cx1CAOieikxktKBKYLg-1; Fri, 10 Jul 2020 04:50:03 -0400
X-MC-Unique: xh6Cx1CAOieikxktKBKYLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A1981B18BCD;
 Fri, 10 Jul 2020 08:50:01 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2568D1002380;
 Fri, 10 Jul 2020 08:49:56 +0000 (UTC)
Date: Fri, 10 Jul 2020 09:49:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Separate notifications from list messages?
Message-ID: <20200710084954.GC4017912@redhat.com>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
 <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Liviu Ionescu <ilg@livius.net>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 09:32:28AM +0100, Peter Maydell wrote:
> On Fri, 10 Jul 2020 at 09:25, Liviu Ionescu <ilg@livius.net> wrote:
> >
> >
> >
> > > On 10 Jul 2020, at 11:09, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > What sort of notifications are we talking about here ?
> >
> > For example:
> >
> > ...
> > Received: from mg.gitlab.com (74.90.74.34.bc.googleusercontent.com
> >  [34.74.90.74]) by smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
> >  5f074fb9a33b1a3dd4571072 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
> >  Thu, 09 Jul 2020 17:11:21 GMT
> > Date: Thu, 09 Jul 2020 17:11:20 +0000
> > Message-ID: <5f074fb827f26_7cd93fa34d371dbc1570d@sidekiq-catchall-02-sv-gprd.mail>
> > Subject: QEMU | Pipeline #164899134 has failed for master | 3d7cad3c
> > Reply-to: GitLab <noreply@gitlab.com>, GitLab <gitlab@mg.gitlab.com>
> > From: GitLab via <qemu-devel@nongnu.org>
> > ...
> 
> Thanks; yeah, I've seen those go past. Do we expect any other
> kinds to appear as we make more use of gitlab?

This was an explicit configuration choice to make the CI failure reports
appear on the list, rather than expecting one or two people to be
responsible for watching the CI. IME if we move them off to a separate
list in practice almost no one will bother to subscribe to the list.

Ideally we would not have any failures in the first place, but right now
GitLab CI is done post-merge.

When Peter starts using GitLab CI as one of the pre-merge gates, then we
should see very few CI failure messages on list. We'll likely still get
a few due to transient infrastructure problems. I think this is the
important thing to focus on here, rather than trying to hide away the
current CI failures.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


