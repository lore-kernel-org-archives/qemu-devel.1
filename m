Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25701C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9BE206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va4WtbCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9BE206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtILF-0004Gl-Uu
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtHlc-0006J6-92
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:38:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtHlY-0003Q7-Pd
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244288;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8Z2Gh8iDn/pnjTwj/tk9pg091TYfdl6bfJD17+GLrn4=;
 b=Va4WtbCMo4oTkuva1YlVOBa4AGpabfvkF+RusK6JgJYxDiJd8DACtWT+M0f+d1VDUd/jtN
 SAFNaVNXXPY6l0iGcx/LkDbSM32N8jXa1Q7oLGhovOj49Dd4OluBN/RhOXTlQMjKWnAbrs
 waft7Gr0yCl6AUaY5xM/gOJOf/n2c6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-wJIGFVQANCeLH0FuHYQ-RQ-1; Wed, 08 Jul 2020 07:35:16 -0400
X-MC-Unique: wJIGFVQANCeLH0FuHYQ-RQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFD221940920;
 Wed,  8 Jul 2020 11:35:10 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8423660E1C;
 Wed,  8 Jul 2020 11:34:39 +0000 (UTC)
Date: Wed, 8 Jul 2020 12:34:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] trivial: Remove trailing whitespaces
Message-ID: <20200708113436.GG3229307@redhat.com>
References: <20200706162300.1084753-1-dinechin@redhat.com>
 <159405307662.7847.17757844911728214859@d1fd068a5071>
MIME-Version: 1.0
In-Reply-To: <159405307662.7847.17757844911728214859@d1fd068a5071>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, dmitry.fleytman@gmail.com, mst@redhat.com,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, armbru@redhat.com,
 jcmvbkbc@gmail.com, kraxel@redhat.com, edgar.iglesias@gmail.com,
 jcd@tribudubois.net, marex@denx.de, sstabellini@kernel.org,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, paul@xen.org,
 magnus.damm@gmail.com, mdroth@linux.vnet.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au, philmd@redhat.com, atar4qemu@gmail.com,
 riku.voipio@iki.fi, ehabkost@redhat.com, mjt@tls.msk.ru,
 alistair@alistair23.me, pl@kamp.de, dgilbert@redhat.com, r.bolshakov@yadro.com,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, ronniesahlberg@gmail.com,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org, rth@twiddle.net,
 kwolf@redhat.com, ysato@users.sourceforge.jp, crwulff@gmail.com,
 laurent@vivier.eu, mreitz@redhat.com, qemu-ppc@nongnu.org, dinechin@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 06, 2020 at 09:31:21AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200706162300.1084753-1-dinechin@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PATCH] trivial: Remove trailing whitespaces
> Type: series
> Message-id: 20200706162300.1084753-1-dinechin@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20200706162300.1084753-1-dinechin@redhat.com -> patchew/20200706162300.1084753-1-dinechin@redhat.com
> Switched to a new branch 'test'
> 9af3e90 trivial: Remove trailing whitespaces
> 
> === OUTPUT BEGIN ===

snip

> ERROR: trailing whitespace
> #2395: FILE: target/sh4/op_helper.c:149:
> +^I$

One case of trailing whitespace missed.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


