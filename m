Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D17C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DEF22210
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MM97tLDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DEF22210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXAY-0005j6-15
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIX9S-0004qU-7D
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:07:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34682
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIX9Q-0002G4-4U
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600261626;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Fl0dKC4M3eb9N/eBlomDgz+0h6NLAzywL0eINdrdZXE=;
 b=MM97tLDcDIYkA3Qi7vv8lbEv8YWsLXTc8XDCW7T7onSY99DnaUCltQIKTRYDHU1k8wgkj2
 cQAeRACUkVU9lxk8ivxILleuRqK9ypEHAVprbMHUzfnWKhwveAo+9BkF1E7hCuzHMMwD1n
 BlkxJEn7wdHMjozyx6i437fcbwWUtQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-4ruSrFqfNOaouh-eAMpKtg-1; Wed, 16 Sep 2020 09:06:59 -0400
X-MC-Unique: 4ruSrFqfNOaouh-eAMpKtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 389978B9591;
 Wed, 16 Sep 2020 13:06:30 +0000 (UTC)
Received: from redhat.com (ovpn-113-248.ams2.redhat.com [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3F7F60CC0;
 Wed, 16 Sep 2020 13:06:28 +0000 (UTC)
Date: Wed, 16 Sep 2020 14:06:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: About 'qemu-security' mailing list
Message-ID: <20200916130525.GL1535709@redhat.com>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <CAFEAcA8FD9HNKvsGs0q6YpSdX8gsoBaNtAPXuvv+e35O33Jbmg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8FD9HNKvsGs0q6YpSdX8gsoBaNtAPXuvv+e35O33Jbmg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 06:27:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 01:33:38PM +0100, Peter Maydell wrote:
> On Wed, 16 Sep 2020 at 12:10, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > I think it's worth investigating whether GitLab Issues can be configured
> > in a secure-enough way for security bug reporting. That way HTTPS is
> > used and only GitLab stores the confidential information (this isn't
> > end-to-end encryption but seems better than unencrypted SMTP and
> > plaintext emails copied across machines).
> 
> Given that we currently use launchpad for bugs we should also look
> at whether launchpad's "private security" bug classification would
> be useful for us (currently such bug reports effectively go to /dev/null
> but this can be fixed).

Using a bug tracker has the notable advantage over direct email CC's
that if the security triage team needs to pull in a  domain specific
expert, that newly added person can still see the full history of
discussion on the bug.

With individual email CC's, the previous discussions are essentially
a information blackhole until the security triage team is good enough
to forward the full discussion history (this essentially never happens
in IME). Mailing list also has that easy archive access benefit.


Is it possible to setup people to be able to view launchpad private
bugs, without also making them full admins for the QEMU launchpad
project ?

Does launchpad still send clear text email notifications to the
permitted admins for private bugs ? I recall I used to get clear
text emails for private bugs in the past for non-QEMU projects.
This reduces the security benefits of launchpad compared to
email, though it is still a clear win in terms of triage process
most likely.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


