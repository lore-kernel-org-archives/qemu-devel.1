Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ABDC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C8920661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnMjH9E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C8920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfX6-0007vh-0A
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izfVt-0006JD-W8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izfVs-0008B9-VR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:40:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izfVs-00088J-Rb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580989204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=RNWvJ/HzHrhXei8cPbN9ZbwLItg++GS1gpF3CH62Rq0=;
 b=AnMjH9E9jMigNjJGAb8mbvxv2ZyJsekL/rGKanRWuICH/Vqar7en5ZJaz7a+6YWDw2/+vG
 /NrsFkbxOmleIKAuyFBPQtwY6v+YKxT/h139LEL/SEwcNNaGsBqlqciswd8aN2LQoyRZwF
 kDhZ/dUUgBSKHuNHoZtMaTfpZZ++cV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-MNkCSEpEPGuUk7N9Rl_4nw-1; Thu, 06 Feb 2020 06:39:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD4881050904;
 Thu,  6 Feb 2020 11:39:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEF3410016DA;
 Thu,  6 Feb 2020 11:39:57 +0000 (UTC)
Subject: Re: [PATCH] hw/bt: Remove empty Kconfig file
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200123064525.6935-1-thuth@redhat.com>
 <CAFEAcA-Tx69KM4dg2GLNhd-Uf=SNrY4oq2+g6twyJMZE_tWx0w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c32bfe2e-2603-8401-7f7e-8ddc5bedec4f@redhat.com>
Date: Thu, 6 Feb 2020 12:39:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Tx69KM4dg2GLNhd-Uf=SNrY4oq2+g6twyJMZE_tWx0w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MNkCSEpEPGuUk7N9Rl_4nw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/02/2020 12.38, Peter Maydell wrote:
> On Thu, 23 Jan 2020 at 06:46, Thomas Huth <thuth@redhat.com> wrote:
>>
>> While removing the bluetooth code some weeks ago, I had to leave the
>> hw/bt/Kconfig file around. Otherwise some of the builds would have been
>> broken since the generated dependency files tried to include it before
>> they were rebuilt. Meanwhile, all those dependency files should have
>> been updated, so we can remove the empty Kconfig file now, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
> 
> I ran this through my usual buildtests and they were all fine.

Finally! :-)

> Tested-by: Peter Maydell <peter.maydell@linaro.org>

Great, thanks for testing it again, Peter!

 Thomas


