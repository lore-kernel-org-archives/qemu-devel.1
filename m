Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347C6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DFA207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3pF+RkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DFA207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYQp-0001NX-7O
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDYQH-0000mw-PW
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:27:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56289
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDYQF-00020o-1r
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599074872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJmaoGvT2s9d77XVKQk71ALhRc/oQDL7dCO0D6Y5U9s=;
 b=I3pF+RkMXEjstUXZwu+my2pZk5tE8YBS0ONYZ3bdFQJ+seK85fP2HAndL31ED4pNxQWZbc
 iIDFUNth4CutiuZYWSbF2z6fEQJ/bj/R7+OAK8e1bz6QhBQR+XTtqAggRuVfrvPsrNgmQ8
 lyGjWUOHSju9QI36UozVO9vKNTZW3Hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-A5cHG9FyPv6L-glTs59LyA-1; Wed, 02 Sep 2020 15:27:50 -0400
X-MC-Unique: A5cHG9FyPv6L-glTs59LyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26FFA18A2257;
 Wed,  2 Sep 2020 19:27:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-76.ams2.redhat.com [10.36.112.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01D7E7EEB5;
 Wed,  2 Sep 2020 19:27:47 +0000 (UTC)
Subject: Re: QAPI, The msys2 CI check are compiled sucess, but qapi tests are
 failing
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <CAE2XoE8d2m7deMgEf1v37FHKqxMegQAc4BbjOwcjOd_-BQH2Zg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eefda25a-f9da-2e2c-1147-3ff03380d68f@redhat.com>
Date: Wed, 2 Sep 2020 21:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8d2m7deMgEf1v37FHKqxMegQAc4BbjOwcjOd_-BQH2Zg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 20.33, 罗勇刚(Yonggang Luo) wrote:
> https://cirrus-ci.com/task/5708273301061632?command=main#L6792
> 
> make: *** [Makefile.mtest:63: check-qapi-schema] Error 1

I think nobody really ever cared about getting "make check" running on
Windows... So as a first step, I think you could submit your patches
without the "make check" at the end of the build script.

Now looking at the error at above URL, this looks like a problem with
the CR-LF vs. LF endings here. Could you try to add --strip-trailing-cr
to the invocation of "diff" in tests/qapi-schema/meson.build ?

 Thomas


