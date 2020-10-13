Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16CDC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241BC208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdruEeJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241BC208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGDn-0002RY-Sl
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSGC0-0001K3-TZ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSGBy-0000hu-TD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602579717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJxlfcwRwxwoKfUpzW/aGKrdRXqGFZlBzRQkEKlG3hM=;
 b=SdruEeJT3+O7eG1zX6htMcw2QgyuErUIdswchDqNuSJLgskqRbSWwqD7IgxAO674dg88xv
 NeAJ4WexTk4eH9cNvfDgcYK5VWiaVZXfQrU/qgyo4tGfr0MiqLcr0modl/cIYF4A/BqL4Z
 et7wIsBli8vy4yBUOMWS6B7zi4C5W3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-Mao9d4v7NGiBz_OVVPxUZg-1; Tue, 13 Oct 2020 05:01:56 -0400
X-MC-Unique: Mao9d4v7NGiBz_OVVPxUZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA54D1008307;
 Tue, 13 Oct 2020 09:01:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56BC460C07;
 Tue, 13 Oct 2020 09:01:52 +0000 (UTC)
Subject: Re: [PATCH v7 2/4] gitignore: ignore a bit more
To: luoyonggang@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20201012233740.190-1-luoyonggang@gmail.com>
 <20201012233740.190-3-luoyonggang@gmail.com>
 <7431126f-cc78-57d3-fd78-bd21c5785927@redhat.com>
 <CAE2XoE_gYX9G7LS6q5GAMsAZAxpGe-M1nO=bei9+D5HKwhBnUw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0c0ff749-9b79-e24f-6576-e0a396db37d7@redhat.com>
Date: Tue, 13 Oct 2020 11:01:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_gYX9G7LS6q5GAMsAZAxpGe-M1nO=bei9+D5HKwhBnUw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/2020 10.53, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Tue, Oct 13, 2020 at 4:38 PM Philippe Mathieu-Daudé <philmd@redhat.com
> <mailto:philmd@redhat.com>> wrote:
>>
>> On 10/13/20 1:37 AM, Yonggang Luo wrote:
>> > Enable the creating multiple build directory at the source root.
>> > Ignore /meson/ and /roms/ for better search experience.
>> >
>> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
> <mailto:luoyonggang@gmail.com>>
>> > ---
>> >   .gitignore | 4 +++-
>> >   1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/.gitignore b/.gitignore
>> > index b32bca1315..f78ee9f297 100644
>> > --- a/.gitignore
>> > +++ b/.gitignore
>> > @@ -1,5 +1,5 @@
>> >   /GNUmakefile
>> > -/build/
>> > +/build*/

The naming of your private build directories is IMHO something that should
not be part of the public .gitignore file. I think you can use your
~/.gitignore file for that.

>> >   *.pyc
>> >   .sdk
>> >   .stgit-*
>> > @@ -10,3 +10,5 @@ TAGS
>> >   *~
>> >   *.ast_raw
>> >   *.depend_raw
>> > +/meson/
>> > +/roms/**/*
>>
>> Why?
> As I said, help for searching tool ignore it, meson and roms are thirdparty
> packages.

Hmm, but "git status" should still show whether there are modifications in
the subdirectories, so IMHO this should not be ignored?

 Thomas


