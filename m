Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648DDC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49C1221FA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MICJ3VIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49C1221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRO8-00069V-FM
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYRMf-0005Pi-A8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYRMc-00032v-CF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604052627;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVwVnoRxUqZpr/mrTGKJmC7MyqRxNIxKTcfp5NH9Fxo=;
 b=MICJ3VIbHSnx832ogwOnOrB+YpVd0iCKsWgD1DgGNvrf836mS2I4382nM5U+/KXejacZ+N
 D55NdyR8lH65qyFJLx5Kra637ydTUmjsNUV1LRVpoaiTMhYfHkyMDUxm03FIpoXpBteaFP
 wg+OVYhTW0XEe7JG0omjJyOWZfFFYgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-7P-QXbvwMqeHMkFXRKcrjQ-1; Fri, 30 Oct 2020 06:10:19 -0400
X-MC-Unique: 7P-QXbvwMqeHMkFXRKcrjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3716C809DE5;
 Fri, 30 Oct 2020 10:10:18 +0000 (UTC)
Received: from redhat.com (ovpn-113-50.ams2.redhat.com [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AB2D10013C1;
 Fri, 30 Oct 2020 10:10:15 +0000 (UTC)
Date: Fri, 30 Oct 2020 10:10:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Migrating to the gitlab issue tracker
Message-ID: <20201030101013.GG99222@redhat.com>
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
 <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
 <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
 <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 10:03:44AM +0000, Peter Maydell wrote:
> On Fri, 30 Oct 2020 at 09:23, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > My convincing strategy is "do nothing" :-)
> 
> I am, er, not convinced :-)
> 
> > Most importantly we need to be able to make the existing "QEMU" component
> > in launch read-only to prevent people filing new bugs there, ideally with
> > a change in the description to point people to the new bug tracker.
> >
> > We can leave existing bugs in LP to continue their discussion. If there
> > are some we explicitly want in gitlab manually re-file them. Aside from
> > that if we periodically auto-close any stale bugs, after a while we'll
> > have culled launchpad down to zero.
> 
> Minimally, we should have an easy way to refile specific bugs
> that doesn't involve manual cut-n-paste. Most of the Arm bugs
> in launchpad are valid, for instance, I think, and I really
> don't want to be spending a day in unnecessary clerical work
> copying information into gitlab...

Auto-migrating content is easy enough. The challenge is user accounts,
because theres no mapping from launchpad to gitlab. If you just
import issues using a generic account, then you loose the communication
with the original bug report in a large portion of migrated bugs. This
makes it more appealing to leave existing bugs in the LP tracker until
they are resolved, auto-closed, or there is a compelling reason to move
to gitlab.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


