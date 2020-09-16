Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5665C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C25122288
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b22PiOw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C25122288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXYu-0003L6-HA
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIXW0-0000Sb-FO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIXVy-0005Is-Dw
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600263025;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIH+R55VOvm0twieckRf3sVWTxxf/14AN973KlPOQbE=;
 b=b22PiOw/RNPjmRjuJvvDDpaOHLSN3EwWrSYiax+aILhOygekWuDzL7VIpPras2f6Xb536J
 FlD2sMf9wwvN6W7LhSJYS5EbGCx/soC+1ZTxeDWsk9CDDQG+uv4xBiPp4KHGFBNSQJ8oeo
 fJcKn32FLm2jbulJKElEG0ZqznP0k3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-sxc1rsM1OJ2x7QJJcr_1ug-1; Wed, 16 Sep 2020 09:30:16 -0400
X-MC-Unique: sxc1rsM1OJ2x7QJJcr_1ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8646D192CC43;
 Wed, 16 Sep 2020 13:30:15 +0000 (UTC)
Received: from redhat.com (ovpn-113-248.ams2.redhat.com [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FC1B7512B;
 Wed, 16 Sep 2020 13:30:13 +0000 (UTC)
Date: Wed, 16 Sep 2020 14:30:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: About 'qemu-security' mailing list
Message-ID: <20200916133011.GN1535709@redhat.com>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <CAFEAcA8FD9HNKvsGs0q6YpSdX8gsoBaNtAPXuvv+e35O33Jbmg@mail.gmail.com>
 <20200916130525.GL1535709@redhat.com>
 <a799a303-c54f-82ee-0a6b-3fd06a98b10a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a799a303-c54f-82ee-0a6b-3fd06a98b10a@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 03:25:45PM +0200, Thomas Huth wrote:
> On 16/09/2020 15.06, Daniel P. Berrangé wrote:
> > Using a bug tracker has the notable advantage over direct email CC's
> > that if the security triage team needs to pull in a  domain specific
> > expert, that newly added person can still see the full history of
> > discussion on the bug.
> > 
> > With individual email CC's, the previous discussions are essentially
> > a information blackhole until the security triage team is good enough
> > to forward the full discussion history (this essentially never happens
> > in IME). Mailing list also has that easy archive access benefit.
> > 
> > Is it possible to setup people to be able to view launchpad private
> > bugs, without also making them full admins for the QEMU launchpad
> > project ?
> 
> Honestly, I'd rather like use to move to the gitlab bug tracker instead
> of extending our use of the launchpad tracker. LP is IMHO a really ugly
> bug tracking tool.

I assume you mean here moving to use GitLab for *all* bug tracking,
not merely security bug tracking ? I don't think it would be sane
to split our process across different bug trackers.

I have no love for LP, so wouldn't disagree with a move to GitLab,
especially if we're intending to expand its usage for other parts
of QEMU project infrastructure. If we ever use it as the canonical
git repo host, then I'd say using its bug tracker too is pretty
much a no-brainer.

> > Does launchpad still send clear text email notifications to the
> > permitted admins for private bugs ? I recall I used to get clear
> > text emails for private bugs in the past for non-QEMU projects.
> 
> IIRC, yes, the email notifications for the private bugs are still send
> without encryption.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


