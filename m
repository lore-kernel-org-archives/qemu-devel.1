Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53FEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 09:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96244206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 09:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96244206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIrxY-0000Zz-CU
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 05:43:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIrwn-0000JA-6q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hIrwd-0007lB-T9
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:42:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hIrwX-0007jX-Ac; Tue, 23 Apr 2019 05:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03F8EC02E60C;
	Tue, 23 Apr 2019 09:42:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C6B1A913;
	Tue, 23 Apr 2019 09:42:20 +0000 (UTC)
Date: Tue, 23 Apr 2019 10:42:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jie Wang <wangjie88@huawei.com>
Message-ID: <20190423094217.GC6022@redhat.com>
References: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 23 Apr 2019 09:42:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] 
 =?utf-8?q?question=EF=BC=9A_Does_qemu-pr-helper_hav?=
 =?utf-8?q?e_its_own_log_files=EF=BC=9F?=
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Zhangbo \(Oscar\)" <oscar.zhangbo@huawei.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, "Fangyi \(C\)" <eric.fangyi@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423094217.W_4TDnxtNXR9K5GJeAOPNpawSpYBRQIhbpFj2dOZtrE@z>

On Tue, Apr 23, 2019 at 11:12:40AM +0800, Jie Wang wrote:
> =C2=A0Does qemu-pr-helper have its own log files=EF=BC=9F

When QEMU launches it, i think it just inherits stdout/err from
QEMU itself, so errors appear mixed into QEMU's stdout output.

When libvirt launches it, there stdout is connected to /dev/null
and stderr is connected to a pipe which libvirt closes almost
immediately. This means any errors are lost as any attempt to
write to stderr will get EPIPE :-(



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

