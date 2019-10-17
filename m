Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B5EECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37F320869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37F320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2cR-00031f-3i
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iL2bg-0002Qp-63
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iL2bf-0003R0-3y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:02:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iL2be-0003Pe-Tn; Thu, 17 Oct 2019 06:02:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F01E718C8939;
 Thu, 17 Oct 2019 10:02:05 +0000 (UTC)
Received: from [10.36.117.42] (ovpn-117-42.ams2.redhat.com [10.36.117.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CDCF60BE1;
 Thu, 17 Oct 2019 10:02:05 +0000 (UTC)
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Subject: s390x/qemu-user: TODO /home/dhildenb/git/qemu/tcg/tci.c:859:
 tcg_qemu_tb_exec()
Organization: Red Hat GmbH
Message-ID: <60a0d510-b693-0ed7-560f-e70904d9574d@redhat.com>
Date: Thu, 17 Oct 2019 12:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 17 Oct 2019 10:02:06 +0000 (UTC)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm currently trying to run Fedora 31 under qemu-user 
(https://github.com/fedora-cloud/docker-brew-fedora/tree/8a81f67271e959dfc8f8a888b161bbd540b7a83b/s390x) 
in order to debug  a vector instruction issue.

Strangely, when trying to chroot into above rootfs and running 
/bin/bash, I get

t460s: ~/f31  $ sudo chroot . ./qemu-s390x  /bin/bash
TODO /home/dhildenb/git/qemu/tcg/tci.c:859: tcg_qemu_tb_exec()
/home/dhildenb/git/qemu/tcg/tci.c:859: tcg fatal error
Aborted


But it's not fundamentally broken:

t460s: ~/f31  $ sudo chroot . ./qemu-s390x  /bin/ls
bin   dev  home  lib64       media  opt   qemu-s390x  run   srv  tmp  var
boot  etc  lib   lost+found  mnt    proc  root        sbin  sys  usr


I do wonder why we don't run into the same issue under qemu-systems390x.

@Richard, any idea?

-- 

Thanks,

David / dhildenb

