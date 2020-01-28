Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C9FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237652467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFzBdAeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237652467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWSz-0004sd-Ao
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwVc3-0004Ig-6v
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwVbz-0001Vt-Iy
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:29:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwVbz-0001QB-8Q
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580236155;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOE7J6mnxgiLuufN3u3RqlXv5Pa6U0VZOiLgw2fMtpw=;
 b=XFzBdAeIiK8/iKcfZDHx6XyuFs4Eet2dtx7lF7m4hrb7IJGg2jnerB7LzldWDe4wSsnKRG
 GR35ZNsqlpaAeW2Z4MkaK2FMs0vyaKcGmO4UJ00h5D5+GF+6r/xlsH2t1HMBYUPY5Jdqb+
 o+QtHjtUdkZIDKz+1cTe1tWrDzAx17Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-Jz6PjBTKOnWOlkEjE6zhMw-1; Tue, 28 Jan 2020 13:29:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F81A477;
 Tue, 28 Jan 2020 18:29:11 +0000 (UTC)
Received: from redhat.com (ovpn-117-159.ams2.redhat.com [10.36.117.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 030BC5DA70;
 Tue, 28 Jan 2020 18:29:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/19] 10 next patches
In-Reply-To: <CAFEAcA-46VVr2sGWEEdxKOCBVxAFZhTJJUiVpVLUO3BTapBu2w@mail.gmail.com>
 (Peter Maydell's message of "Tue, 28 Jan 2020 17:08:12 +0000")
References: <20200127223321.2742-1-quintela@redhat.com>
 <CAFEAcA-46VVr2sGWEEdxKOCBVxAFZhTJJUiVpVLUO3BTapBu2w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 28 Jan 2020 19:29:08 +0100
Message-ID: <87lfprzb7v.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Jz6PjBTKOnWOlkEjE6zhMw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Mon, 27 Jan 2020 at 22:34, Juan Quintela <quintela@redhat.com> wrote:
>>
>> The following changes since commit 105b07f1ba462ec48b27e5cb74ddf81c6a793=
64c:
>>
>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200127'
>> into staging (2020-01-27 13:02:36 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/juanquintela/qemu.git tags/10_next-pull-request
>>
>> for you to fetch changes up to 3189f80ee7b44c968796e63f81c92c915fccdb08:
>>
>>   migration/compress: compress QEMUFile is not writable (2020-01-27
>> 20:47:24 +0100)
>>
>> ----------------------------------------------------------------
>> Migration pull request
>>
>> This pull request include:
>> - simplify get_qlist (eric)
>> - fix null in multifd_send_terminate_threads (zhimin)
>> - small fix for compress (wei)
>> - migrate multifd + cancel fixes (juan)
>> - migrate compression: the bits that are reviewed (juan)
>>
>
> Hi -- this passed tests, but half the commits seem to
> have incorrectly still got the below-the-'---'-line
> remarks in them: could you strip those out and resend,
> please?

ouch

Sorry.

Later, Juan.


