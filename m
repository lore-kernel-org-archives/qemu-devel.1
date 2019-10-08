Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5406C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF3D206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF3D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHq0d-0004pf-2v
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iHpyX-0003V6-0f
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iHpyV-0004hJ-EO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iHpyS-0004em-4k; Tue, 08 Oct 2019 09:56:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B4F718C4286;
 Tue,  8 Oct 2019 13:56:23 +0000 (UTC)
Received: from [10.3.116.162] (ovpn-116-162.phx2.redhat.com [10.3.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 005DB5C1D4;
 Tue,  8 Oct 2019 13:56:22 +0000 (UTC)
Subject: Re: [PATCH] qemu-nbd: Document benefit of --pid-file
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191007194840.29518-1-eblake@redhat.com>
 <20191008092448.GD1192@redhat.com>
 <04440b88-78f6-e177-924d-e16fc3c29b5c@virtuozzo.com>
 <d4b715de-6d5d-6f43-e845-86ddc01c3eac@redhat.com>
 <20191008133834.GG1192@redhat.com>
 <99240aec-6d19-cea6-5b95-6bbf5a9106e8@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <de461851-39a3-0c48-9270-85e0f0859603@redhat.com>
Date: Tue, 8 Oct 2019 08:56:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <99240aec-6d19-cea6-5b95-6bbf5a9106e8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 08 Oct 2019 13:56:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 8:53 AM, Vladimir Sementsov-Ogievskiy wrote:

> 
> I've already implemented loop of attempting to connect in my series (patch 4/3).
> It's a bit more difficult to implement, but it's done. And it's a bit better,
> as it test exactly what we want to test. Can we proceed with it?
> 

For test purposes, yes, that's fine (a test doesn't have to be clean, 
just work).

>>
>> We shouldn't need todo any of those tricks IIUC.  The --fork argument is
>> supposed to only let the parent process exit once the server is running.
>>
>> IOW, if you run qemu-nbd --fork, in the foreground, then when execution
>> continues the sockets should be present & accepting connections. No need
>> to check for existance of any files or check connecting, etc.
>>
>>
>> Except that AFAICT, --fork isn't actually implemented with this semantics
>> in qemu-nbd. It looks like we only listen on the sockets after the parent
>> has already exited :-( Can we fix that to synchronize wrt socket listeners ?

Yes, sounds like something good to have.  I'll take a look at doing that.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

