Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC8C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB5B206B1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB5B206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCer5-00061R-2T
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 03:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjt@tls.msk.ru>) id 1jCeqO-0005Zh-VG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjt@tls.msk.ru>) id 1jCeqN-0006fG-O1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:34:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:33899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1jCeqN-00063j-HF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:34:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2A59E403C2;
 Fri, 13 Mar 2020 10:34:44 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 494716C7;
 Fri, 13 Mar 2020 10:31:21 +0300 (MSK)
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
References: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
 <20200310093910.GB140737@stefanha-x1.localdomain>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <ab8aaa05-8738-f789-8281-cc9d4235a225@msgid.tls.msk.ru>
Date: Fri, 13 Mar 2020 10:34:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310093910.GB140737@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 86.62.121.231
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, pkg-qemu-devel@lists.alioth.debian.org,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.03.2020 12:39, Stefan Hajnoczi wrote:
> On Fri, Mar 06, 2020 at 02:26:48PM +0100, Christian Ehrhardt wrote:
>> On upgrades the old .so files usually are replaced. But on the other
>> hand since a qemu process represents a guest instance it is usually ke=
pt
>> around.
>>
>> That makes late addition of dynamic features e.g. 'hot-attach of a cep=
h
>> disk' fail by trying to load a new version of e.f. block-rbd.so into a=
n
>> old still running qemu binary.
>>
>> This adds a fallback to also load modules from a versioned directory i=
n the
>> temporary /var/run path. That way qemu is providing a way for packagin=
g
>> to store modules of an upgraded qemu package as needed until the next =
reboot.
>>
>> An example how that can then be used in packaging can be seen in:
>> https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=3Dbug-18=
47361-miss-old-so-on-upgrade-UBUNTU
>>
>> Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
>> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>> ---
>>  util/module.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>=20
> CCing Debian, Fedora, and Red Hat package maintainers in case they have
> comments.
>=20
> The use of /var/run makes me a little uneasy.  I guess it's related to
> wanting to uninstall the old package so the .so in their original
> location cannot be used (even if they had a versioned path)?

BTW, this is /run nowadays, not /var/run, as far as I can see.

/mjt

