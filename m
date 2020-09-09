Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AC8C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA7A2078E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPXY+NTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA7A2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4gF-0004AY-Id
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG4eH-0002o3-1I
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:16:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG4eF-00047l-7n
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599675406;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8yCTaWtidvwiQgxj1YIdD+a2edNgHAenTpilRMl5BVE=;
 b=YPXY+NTd4Z7oeCFvzBmtDqnfF1Yk8OrDfedvgo9ROj3+BkcHbC831T5XgjcrBWI3E60v7K
 6kDb6fTMJpMCAY0ObitvZmga9GnI9eKtO1CxCVLQPq1c5LryghCjMQj4WWS7H6puX0ETSt
 fbrt0vLVLXqtrut8rL1O8aHIUORu8Q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-YPQ01uDkMBeGwSUntAh90Q-1; Wed, 09 Sep 2020 14:16:44 -0400
X-MC-Unique: YPQ01uDkMBeGwSUntAh90Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E25F1084D64;
 Wed,  9 Sep 2020 18:16:42 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A64EF27C21;
 Wed,  9 Sep 2020 18:16:35 +0000 (UTC)
Date: Wed, 9 Sep 2020 19:16:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH v2 14/21] cirrus: Building freebsd in a single short
Message-ID: <20200909181633.GW1011023@redhat.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-15-luoyonggang@gmail.com>
 <CAPyFy2BrjPh_E3YaxEx73eJjSd3TXeghiokeKL-Y+suupmiP8Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPyFy2BrjPh_E3YaxEx73eJjSd3TXeghiokeKL-Y+suupmiP8Q@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:15:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 01:32:04PM -0400, Ed Maste wrote:
> On Wed, 9 Sep 2020 at 05:47, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > freebsd 1 hour limit not hit anymore
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> 
> Reviewed-by: Ed Maste <emaste@FreeBSD.org>
> 
> > When its running properly, the consumed time are little, but when tests running too long,
> > look at the cpu  usage, the cpu usage are nearly zero. does't consuming time.
> 
> So it looks like we have a test getting stuck. After this change is in
> we could split the test execution out into its own script so to make
> it more obvious if/when this happens - for example,
> 
>   script:
>     - mkdir build
>     - cd build
>     - ../configure --enable-werror || { cat config.log; exit 1; }
>     - gmake -j8
>   test_script:
>    - gmake V=1 check
> 
> I can follow up with a proper patch for that (and making the change
> for macos as well) later.

What would help most is if there's a way to convince meson to print
the execution time of each test case, instead of merely its name.
That way we could immediately spot the slow test when it hits


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


