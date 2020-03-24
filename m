Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9B1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DE820714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buGV1PBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DE820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGk2L-0007bC-BG
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGk0u-0006io-0i
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGk0s-0007rV-KJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:54:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29959)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGk0s-0007po-FZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585058077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fufdrNrz463Hga0gUZ/DZxFc/5xi1JnQIXei1lf2JLk=;
 b=buGV1PBbrZNTbrh4oka02oVWeU36xZbCLTyvcr/Kschk+Dr7dRYID/BccEv3yUTwLQyu5w
 B15ITX/GQdktGT679SqW1ecLGQpTGB65Pan2viBekCqC2M7ftCq76yOhurbzECNnlcQCaq
 xB24Odfa/yaFGhv6jv/DjRzZawks5uQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-EM4d40jKNvekHwGbW6ubHA-1; Tue, 24 Mar 2020 09:54:33 -0400
X-MC-Unique: EM4d40jKNvekHwGbW6ubHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D91358010F3;
 Tue, 24 Mar 2020 13:54:32 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 064FD19C6A;
 Tue, 24 Mar 2020 13:54:31 +0000 (UTC)
Subject: Re: deprecation of in-tree builds
To: Stefan Hajnoczi <stefanha@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1407efec-2da8-3ab8-ca99-7a09b1d66ce2@redhat.com>
Date: Tue, 24 Mar 2020 08:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323133244.GK261260@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 8:32 AM, Stefan Hajnoczi wrote:

>>> We could also make configure actively warn if used in
>>> the source tree.
>>
>> This was discussed before. I think instead of annoying people with a
>> warning, rather configure should be changed to create a build dir if run
>> from source and have a Makefile in top dir that runs make -C builddir so
>> people don't have to care about this or change their ways and can continue
>> to run configure && make from source dir but you don't have to support
>> in-tree build. Then you can deprecate in-tree builds but supporting only
>> out-of-tree without this convenience would not just unnecessarily annoy
>> those who prefer working in a single tree but people (and apparently some
>> tools) expect sources to build with usual configure; make; make install so
>> that should be the minimum to support.
> 
> Yes, please!  I use in-tree builds and find it tedious to cd into a
> build dir manually.
> 
> Also, many build scripts (packaging, etc) we'll break if we simply
> remove in-tree builds.  I think make && make install should continue to
> work.

Here's what I'm using locally to let my finger memory of building 
in-tree work in spite of having done 'mkdir build; cd build; 
../configure ...'.  We'd still need glue code in configure itself to 
detect when it is being invoked in-tree to create a subdir build/ and 
such a forwarding file, but if we want in-tree to FEEL like it works 
(even though it uses a build dir under the hood), it's certainly worth 
considering.

$ cat GNUmakefile
# Hack for redirecting while reminding myself to use distinct builddir
ifeq ($(MAKECMDGOALS),)
recurse: all
endif
.NOTPARALLEL: %
%: force
	@echo 'changing dir to build for $(MAKE) "$(MAKECMDGOALS)"...'
	@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)
force: ;
.PHONY: force
GNUmakefile: ;


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


