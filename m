Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD46FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FBD2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvGWLFPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FBD2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8rxX-0001Sm-Qy
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 17:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8ruu-0000X9-Mz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:16:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8rur-0005aU-Ks
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597958167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6RJ9n3ihAH6Yf/UdeFSXE4a3/Ae9k0wtArZablh7FQ=;
 b=NvGWLFPuplcjOi+idMZRB4J+Smjpk4Ai2BHXJS1UC00Aa9I7pzBy5A9fBI5+Yz4tvNQQL5
 2GQtOJc9YWruNz2h1JxoPZVuU79R+HmQF7A6yAw3iFjZlN+fXtVvnpSQSAaVgEyGDxkjL/
 gqmdAmA6jdviBK8CodjerlaZf/BrUH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-9PzonHRaOr6ngog3OrrtcA-1; Thu, 20 Aug 2020 17:16:02 -0400
X-MC-Unique: 9PzonHRaOr6ngog3OrrtcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75CD61007466;
 Thu, 20 Aug 2020 21:16:00 +0000 (UTC)
Received: from [10.3.114.63] (ovpn-114-63.phx2.redhat.com [10.3.114.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D411360BF1;
 Thu, 20 Aug 2020 21:15:59 +0000 (UTC)
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200820173124.243984-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <814594a0-391c-01fb-a418-234e477793d3@redhat.com>
Date: Thu, 20 Aug 2020 16:15:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820173124.243984-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 17:00:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 12:31 PM, Daniel P. Berrangé wrote:
> Meson requires the build dir to be separate from the source tree. Many
> people are used to just running "./configure && make" though and the
> meson conversion breaks that.
> 
> This introduces some backcompat support to make it appear as if an
> "in source tree" build is being done, but with the the results in the
> "build/" directory. This allows "./configure && make" to work as it
> did historically, albeit with the output binaries staying under build/.

An observation:

If you already had out-of-tree builds, this does not change anything. 
You can do an incremental build, where a tree that builds pre-merge 
should continue to build incrementally with 'make -C dir' post-merge.

If you are used to in-tree builds, and do a fresh checkout, this lets 
you maintain the illusion of an in-tree build although binaries may be 
located differently than you are used to.

But if you do an incremental update to an in-tree build, this will cause 
some odd behaviors, starting with the git update:

$ git merge $paolos_tag
error: The following untracked working tree files would be overwritten 
by merge:
	accel/kvm/trace.h
...
	util/trace.h
Please move or remove them before you merge.
Aborting
$ find -name trace.h -delete
$ git merge $paolos_tag
$ git am $this_patch
$ make
config-host.mak is out-of-date, running configure
Using './build' as the directory for build output
Submodule 'meson' (https://github.com/mesonbuild/meson/) registered for 
path 'meson'
Cloning into '/home/eblake/qemu-tmp2/meson'...
...
Command line for building ['libcommon.fa'] is long, using a response file
./ninjatool -t ninja2make --omit clean dist uninstall < build.ninja > 
Makefile.ninja
/bin/sh: build.ninja: No such file or directory
   GEN     tests/test-qapi-gen
make: Nothing to be done for 'all'.
$ echo $?
0
$ make
changing dir to build for make ""...
make[1]: Entering directory '/home/eblake/qemu-tmp2/build'
Makefile:84: *** This is an out of tree build but your source tree 
(/home/eblake/qemu-tmp2) seems to have been used for an in-tree build. 
You can fix this by running "make distclean && rm -rf *-linux-user 
*-softmmu" in your source tree.  Stop.
make[1]: Leaving directory '/home/eblake/qemu-tmp2/build'
make: *** [GNUmakefile:11: all] Error 2
$ echo $?
2

So I'm not sure why the first build gets as far as it does, but does NOT 
complete things and yet does not fail make, but my advice is that you 
should NOT try to an incremental build on in-tree build when crossing 
the meson epoch.  If you are a fan of in-tree convenience, you need a 
ONE-TIME distclean when pulling in these changes (the fact that you HAVE 
to clean up trace.h files to merge in the meson stuff should be a hint 
for that).  After that has been done, you can go back to pretending 
meson supports in-tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


