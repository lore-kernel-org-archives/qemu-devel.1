Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C63218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYyHwPGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C63218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvil-0003AK-H4
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFvgs-0007m0-Qq
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:42:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57583
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFvgq-0007ma-Un
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599640971;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huIvKVojxkARRpqjMjoyBwSYv5G9m5T4Z6vu/LsBKXs=;
 b=IYyHwPGOuCvC2av8x53VpvE6BYDci5KH6+M8Q1+dEE893x99E+9LKtrOBEW2B0LC1rS9UX
 LK7/FcW4Lpo51njMSzBGW2udng5cWM7Yt3FOt6KXt9IAvWGjoZinNj+Snr6xnDBNy+LQkN
 qGn3WV43ZeSm1+5Wf0/SZK1+0Y3lPO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-VOv8a6odPam_wIHyg9l4OA-1; Wed, 09 Sep 2020 04:42:26 -0400
X-MC-Unique: VOv8a6odPam_wIHyg9l4OA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2185010ABDA2;
 Wed,  9 Sep 2020 08:42:25 +0000 (UTC)
Received: from redhat.com (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8515460CC0;
 Wed,  9 Sep 2020 08:42:13 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:42:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: [PATCH 14/16] cirrus: Building freebsd in a single short
Message-ID: <20200909084210.GJ1011023@redhat.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-15-luoyonggang@gmail.com>
 <20200909081735.GE1011023@redhat.com>
 <CAE2XoE_-E6yZ9HKZVRd3VN7SRD_w6DUQwcG4e_51-8y2JzOEvw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_-E6yZ9HKZVRd3VN7SRD_w6DUQwcG4e_51-8y2JzOEvw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 04:24:00PM +0800, 罗勇刚(Yonggang Luo) wrote:
> On Wed, Sep 9, 2020 at 4:17 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Wed, Sep 09, 2020 at 03:48:18AM +0800, Yonggang Luo wrote:
> > > freebsd 1 hour limit not hit anymore
> >
> > How long does the combined job take with this change ? If it is
> > within 10 minutes of the limit, then we still want the split, as
> > transient changes in the CI system can push it over the limit
> > making the test unreliable.
> >
> I think we going to a wrong direction, I think there is some tests a stall
> the test runner,
> please look at
> https://cirrus-ci.com/task/5110577531977728
> When its running properly, the consumed time are little, but when tests
> running too long, look at the cpu
> usage, the cpu usage are nearly zero. does't consuming time.
> 
> And look at
> https://cirrus-ci.com/task/6119341601062912
> 
> If the tests running properly, the time consuming are little
> 
> We should not hide the error by split them

Ok, please explain this in the commit message so reviewers know why the
change is intentionally reverting the previous split.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


