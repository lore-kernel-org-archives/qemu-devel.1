Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BC9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF54206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDHPYJcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF54206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJ4x-0001Ut-PK
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jrJ4F-0000Ra-Ua
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:37:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53400
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jrJ4C-00054k-Ve
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593772631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLy6J0rR87x/UaIr12oNWogdPYYi4gz/HBto258uaTI=;
 b=EDHPYJcscn68sMic+c2jGjP5NQ+mlqjBokpyjxCwQAklyK8slogkh1Vz78oiWVULLx47nR
 /5Dgdnf7qTxR5kwlEE9xT6Z52oviC2PTFNx6V6jyLYpXpePV9x+TMcqXY4zhjAz25N1jKm
 n0b3UchUQOdX8SR9Rhv0QK4mGHxrjDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-ROnTtFQCNKWBtcb1xZTNUQ-1; Fri, 03 Jul 2020 06:37:10 -0400
X-MC-Unique: ROnTtFQCNKWBtcb1xZTNUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E933287950E;
 Fri,  3 Jul 2020 10:37:08 +0000 (UTC)
Received: from titinator (ovpn-113-254.ams2.redhat.com [10.36.113.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31A306FEF4;
 Fri,  3 Jul 2020 10:37:04 +0000 (UTC)
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200630125916.GG91444@stefanha-x1.localdomain>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 0/3] trace: Add a trace backend for the recorder library
In-reply-to: <20200630125916.GG91444@stefanha-x1.localdomain>
Date: Fri, 03 Jul 2020 12:37:02 +0200
Message-ID: <lysge8c2b5.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-06-30 at 14:59 CEST, Stefan Hajnoczi wrote...
> On Fri, Jun 26, 2020 at 06:27:03PM +0200, Christophe de Dinechin wrote:
>> The recorder library implements low-cost always-on tracing, with three
>> usage models:
>>
>> 1. Flight recorder: Dump information on recent events in case of crash
>> 2. Tracing: Individual traces can be enabled using environment variables
>> 3. Real-time graphing / control, using the recorder_scope application
>>
>> This short series introduces a new "recorder" back-end which connects
>> to the recorder. Traces using the recorder are intentionally "always on".
>> An example is given of how the recorder can also be used separately
>> from generated traces. This can be useful if you want to enable
>> multiple related traces for a particular topic.
>>
>> This series requires a small makefile fix submitted earlier, included
>> here for convenience.
>>
>> Christophe de Dinechin (3):
>>   Makefile: Compute libraries for libqemuutil.a and libvhost-user.a
>>   trace: Add support for recorder back-end
>>   trace: Example of "centralized" recorder tracing
>
> Please add a build to .travis.yml that enables recorder. That way we'll
> catch build failures.

There is no recorder package in Xenial.

>
> Thanks,
> Stefan



--
Cheers,
Christophe de Dinechin (IRC c3d)


