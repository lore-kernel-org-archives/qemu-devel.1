Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F82C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256DE20719
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5PG91fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256DE20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kac0G-0001dV-Vk
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 04:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kabzC-00018O-Cv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:55:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kabz8-0008M5-49
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604570112;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbjuLUC72ODNQj+c4JLPv3UqTW/NG6Jf4EQHuhS3nzU=;
 b=W5PG91fmAHpjXRYlhS2E5XJFSpaQI2AonkCW1MX/g8EPSVhtzYp7ygiOkeh13ByrY8LxNW
 jHXFAZ5eSAC4rO4YhiLQ90KVeFTet/y5u/KxitxdSwp2n+X6K8dj1YT6lEqhIOn/LqXhJG
 zXE67IdddCtvWR8uQYRxpDN9cde5zTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-Y4BXMsYVOHCjTe0dxSHnQA-1; Thu, 05 Nov 2020 04:55:05 -0500
X-MC-Unique: Y4BXMsYVOHCjTe0dxSHnQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CADF10B9CAA;
 Thu,  5 Nov 2020 09:55:04 +0000 (UTC)
Received: from redhat.com (ovpn-115-13.ams2.redhat.com [10.36.115.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BA2019930;
 Thu,  5 Nov 2020 09:55:01 +0000 (UTC)
Date: Thu, 5 Nov 2020 09:54:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Migrating to the gitlab issue tracker
Message-ID: <20201105095458.GD630142@redhat.com>
References: <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
 <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
 <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
 <20201030101013.GG99222@redhat.com>
 <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
 <c75f91b7-6972-9e48-efa9-49792fc011d2@redhat.com>
 <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
MIME-Version: 1.0
In-Reply-To: <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 05, 2020 at 07:14:47AM +0100, Thomas Huth wrote:
> On 05/11/2020 01.06, John Snow wrote:
> > On 10/30/20 6:57 AM, Peter Maydell wrote:
> >> On Fri, 30 Oct 2020 at 10:10, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>> This
> >>> makes it more appealing to leave existing bugs in the LP tracker until
> >>> they are resolved, auto-closed, or there is a compelling reason to move
> >>> to gitlab.
> >>
> >> The compelling reason is that there is no way that I want to
> >> have to consult two entirely separate bug tracking systems
> >> to see what our reported bugs are. We must have an entry
> >> in the new BTS for every 'live' bug, whether it was originally
> >> reported to LP or to gitlab.
> [...]
> > OK. I will try to investigate using the Launchpad API to pull our
> > existing information, and then using the Gitlab API to re-create them. 
> 
> Before we migrate hundreds of bugs around, I think we should first check
> which ones are stale, and which are still valid. So for all bugs that are in
> "New" state and older than, let's say 2 years, I think we should add a
> message a la:
> 
>  The QEMU project is currently considering to move its bug tracking to
> another system. For this we need to know which bugs are still valid and
> which could be closed already. Thus we are setting all older bugs to
> "Incomplete" now. If you still think this bug report here is valid, then
> please switch the state back to "New" within the next 60 days, otherwise
> this report will be marked as "Expired". Thank you and sorry for the
> inconvenience.
> 
> Then set the state to "Incomplete" and wait and see how many bugs expire in
> 60 days.

This sounds like a good idea.

I would further suggest that for bugs older than 5 years, we just close
them straightaway and skip this message. Users can always re-open or
re-file the bug in the very unlikely case they still care after 5 years.
We have some bugs that date from 2010, and just doesn't seem like we will
ever address those even if the user responded to the message by setting
it back to "New".

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


