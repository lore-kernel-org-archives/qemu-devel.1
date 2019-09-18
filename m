Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C3C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEA821927
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEA821927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAev9-00052v-0m
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iAetw-0004Vg-D0
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iAetu-0003Sa-GO
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:42:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iAetq-0003Qp-Sv; Wed, 18 Sep 2019 14:41:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0F978A1C88;
 Wed, 18 Sep 2019 18:41:57 +0000 (UTC)
Received: from [10.10.124.73] (ovpn-124-73.rdu2.redhat.com [10.10.124.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F9E019C6A;
 Wed, 18 Sep 2019 18:41:57 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190912001633.11372-1-jsnow@redhat.com>
 <20190912001633.11372-2-jsnow@redhat.com>
 <974b64b8-a191-c529-4e77-6a38b372c4b8@virtuozzo.com>
 <e5d871da-c5e1-1a5e-4714-387cbc93a055@redhat.com>
 <2eea4fa4-cee1-9007-0ff9-784d004c2668@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <59694b0e-b6c1-7dfb-818a-c82dc0f14947@redhat.com>
Date: Wed, 18 Sep 2019 14:41:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <2eea4fa4-cee1-9007-0ff9-784d004c2668@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 18 Sep 2019 18:41:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/18/19 9:05 AM, Thomas Huth wrote:
> On 18/09/2019 00.29, John Snow wrote:
>>
>>
>> On 9/16/19 10:56 AM, Vladimir Sementsov-Ogievskiy wrote:
> [...]
>>> Finally do we support something except linux for iotests?
>>> for bash tests _supported_os also used only with "Linux" in 87 tests..
> 
> The iotests in the "auto" group are supposed to work on other OSes
> beside Linux, too, since they are run automatically during "make check"
> now. You can use github with cirrus-ci to check FreeBSD and macOS, see
> e.g.: https://cirrus-ci.com/build/5114679677943808
> 
> Travis has support for macOS, too.
> 
> And to test them on OpenBSD (or FreeBSD), you can use the VM tests, e.g.
> something like this:
> 
> make vm-build-openbsd J=8 BUILD_TARGET=check-block \
>    EXTRA_CONFIGURE_OPTS=--target-list=x86_64-softmmu
> 
>> aaand lastly, running `make check` doesn't happen to call any of the
>> tests that appear broken on FreeBSD right now, so I'm just going to go
>> ahead and say we can open Pandora's box and make the default python test
>> behavior to run on any OS, and start re-blacklisting the edge-cases as
>> we find them.
> 
> Sounds good. If it breaks on FreeBSD or macOS, we'll find out with
> cirrus-ci or Travis pretty soon.
> 

Yeah. It's annoying, but genuinely the quickest way to figure it out. 
Keep an eye on the v5 of this series for fallout.

--js

