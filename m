Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388B8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA51207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA51207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyvy-0001WH-9T
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jqyvG-0000qa-SK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:06:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:41389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jqyvE-0003O1-Oc
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:06:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 08C7840098;
 Thu,  2 Jul 2020 16:06:33 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id C56F46D;
 Thu,  2 Jul 2020 16:06:32 +0300 (MSK)
Subject: Re: [PATCH] Makefile: Compute libraries for libqemuutil.a and
 libvhost-user.a
To: Christophe de Dinechin <dinechin@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <20200616161814.891053-1-dinechin@redhat.com>
 <20200623144415.GP36568@stefanha-x1.localdomain> <ly1rlvd2en.fsf@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <be57d624-f3b1-7abf-39fe-6568e95805f8@msgid.tls.msk.ru>
Date: Thu, 2 Jul 2020 16:06:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ly1rlvd2en.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 09:06:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.07.2020 12:12, Christophe de Dinechin wrote:
..
>>>  # Build libraries
>>>
>>> +libqemuutil.a-libs += $(call extract-libs, $(util-obj-y) $(trace-obj-y) $(stub-obj-y))
>>> +libvhost-user.a-libs += $(call extract-libs, $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y))
..
>> Another thing I wonder about: the purpose of the .a files is to compile
>> all object files and only link those .o files needed by the program
>> (i.e. a subset of the .a file).
> 
> I believe that what you are saying is that by passing the required libraries
> automatically, the binaries that use libqemuutil.a will inherit undesired
> ldd dependencies. Indeed, a quick experiment shows that if you pass a -l
> option, the library dependency is recorded even if no symbol in that library
> is used. I saw no obvious linker option to address that.

There's --as-needed and --no-as-needed ld flag (used with cc as -Wl,--as-needed),
which is designed for this very case.

JFYI.

/mjt

