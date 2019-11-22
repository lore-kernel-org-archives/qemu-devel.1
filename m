Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4BC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D4F2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UovjnWG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D4F2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYAbD-0008Il-Qd
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 10:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iYAaF-0007SE-Ca
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iYAaC-0001SL-KD
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:10:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51620
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iYAaC-0001RM-0s
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574435451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPjPqrIxGlTGMbcC2tskOhGPSY1BxY0qx1WX1PF8Zb0=;
 b=UovjnWG+b5ENMFiyUjNwVkhqMNwIFc2t8F/qrT3hfljpdj+s7nnSoEtMGVQBvJilK/H1WW
 HYj3MYh/OLOHdqjPUHtLwEqaE9G3hqW0+BkXhZV9iXdUg2XlnyR9EOINdfa1Y9Zpnaql6Y
 JV03n0VTRbCICuI5BYQqEmxJ5+DfhP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-FppxGJ5yMRSw4YQd8E1boQ-1; Fri, 22 Nov 2019 10:10:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D747E80268E;
 Fri, 22 Nov 2019 15:10:47 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE9910840CD;
 Fri, 22 Nov 2019 15:10:47 +0000 (UTC)
Subject: Re: [QUESTION] Usage of '0b' as a prefix for numerical constants?
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAL1e-=gstogyXyAFV09-_mdqPs525bQP673+TcoxoRRDKwYAqw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f78d09e1-c416-9646-7786-8091640da383@redhat.com>
Date: Fri, 22 Nov 2019 09:10:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gstogyXyAFV09-_mdqPs525bQP673+TcoxoRRDKwYAqw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: FppxGJ5yMRSw4YQd8E1boQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 8:56 AM, Aleksandar Markovic wrote:
> Hello, all.
> 
> I am currently reviewing some code, and I see it uses '0b' as a prefix
> of numerical constants, similar to these examples:
> 
> switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
> 
> or
> 
> ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID, RID, 0b0000);

Binary constants introduced by 0b are a gcc'ism, copied by clang, and 
thus usable in qemu if we want to (similar to our use of the ?: 
operator, the {} initializer, the ranged case 0 ... 7, 
__attribute__((cleanup)), ...).  But it is not standard C.

> 
> I remember a while ago, something stopped me from using '0b' as a
> prefix in my own code (was it checkpatch.pl, or perhaps some statement
> on coding style, or a compiler, or something else - I don't really
> remember), so I didn't use it, and used '0x' (hexadecimal constant).
> 
> What is really the view of the community on usage of '0b'?

For small constants, 0b111 is just about as readable as 0x7.  But for 
large constants, I much prefer 0x7f over 0b1111111.

> 
> Please C language standard and compiler experts, and also regular
> participants like me, speak up.

If you want to provide a patch for coding standards (either admitting 
that yes we use the extension and here are some guidelines on using it, 
or declaring no new uses of it and maybe patching existing uses to 
switch to hex constants), then go for it.  Maybe wait for more opinions 
to come in to see which color more of the developers prefer for their 
bikeshed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


