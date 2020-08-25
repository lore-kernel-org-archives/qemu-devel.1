Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD12C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CE120738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiiLF0BS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CE120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZU0-0004xS-Fq
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAZT3-00047z-Il
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:58:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40480
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAZSx-0000ZI-9C
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598363901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXx6SushKnOCDa3ar4nTGa3OcDOm+rAH+vGfELGUdr8=;
 b=SiiLF0BSSfotkR3d5SJIbPjz95XPgouFqYiMkQJ78BuwwIrIfwvERGvCY8mIrYLhyp9387
 O8uC4SaOrEWbwwOmninNuNI7jX8J30MmckRe/zQLBon1zTUxRGZZXjIl8AY5iPhTRp8OPz
 YarmIpM51+lLgFhvcbcN2gUqoND/J88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-XYfQ4tMNP2apdAeFF724rA-1; Tue, 25 Aug 2020 09:58:19 -0400
X-MC-Unique: XYfQ4tMNP2apdAeFF724rA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6409080B71A;
 Tue, 25 Aug 2020 13:58:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-152.ams2.redhat.com [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8669619C58;
 Tue, 25 Aug 2020 13:58:13 +0000 (UTC)
Subject: Re: meson.build files are missing copyright/license headers
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA_0R9mQNFnyzdpR65YRHoDs0uPKWxmCOQUojbpAM-jP8A@mail.gmail.com>
 <CAJ+F1CL1Hp-g8gNMpdGgk2d0KCzJfBde9f_mX8TLtewe3-B48g@mail.gmail.com>
 <CAFEAcA_u_3P9MQ23zWTUH-aM8Nabbt+PVv+4qOWpEAhiuJq+cg@mail.gmail.com>
 <e9155559-9a06-ec6f-4be0-2a692364c665@redhat.com>
 <CAFEAcA919wJg00vVTyVksaZGNmD50gH1jQj6RWA1ZAafEJAbOg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ec7272ca-ffed-10b3-4176-8d2905d25772@redhat.com>
Date: Tue, 25 Aug 2020 15:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA919wJg00vVTyVksaZGNmD50gH1jQj6RWA1ZAafEJAbOg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/08/2020 11.53, Peter Maydell wrote:
> On Tue, 25 Aug 2020 at 06:57, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 24/08/2020 20.46, Peter Maydell wrote:
>>> We don't mandate SPDX[*],
>>> but it will do the job if you want to use it.
>>>
>>> [*] Mostly because nobody's cared enough to say "we should
>>> standardize on this and convert existing files and add the
>>> check to checkpatch that new files have an SPDX line".
>>
>> We should standardize on this and convert existing files and add the
>> check to checkpatch that new files have an SPDX line! :-)
>>
>> Ok, now sombody said it loud. Would there be any objections to enforce
>> this via checkpatch on new files?
> 
> I wouldn't object, indeed I think checkpatch-enforcement is an
> important part of the process. I think that if we're going
> to move to SPDX we should:
>  * look at the SPDX spec and identify what we need to do beyond
>    just adding SPDX lines (eg do we need a LICENSES/ subdir
>    like the kernel has with a file per license?)

Ack

>  * document (in docs/devel?) that we require SPDX

Ack

>  * decide what our plan is for 3rd-party code (libvixl, etc)
>    [where any SPDX line we add will be lost again next time
>    we resync our copy of the code]

For things like libvixl, I wonder why this is not a git submodule instead?

For other things that we sync manually, I guess it should be ok to add
the SPDX tags there since the files are likely out of sync anyway.

>  * put in a checkpatch check for new files (presumably the
>    Linux kernel has one we can borrow)

Ack

>  * update existing files (I think the kernel folks probably
>    have scripted stuff for the easy parts of this; multi-license
>    files like fpu/softfloat.c likely need by-hand conversion)

Yes. I think we have to be very careful here with old files - adding the
tags is likely ok, but e.g. removing the boilerplate text in the various
headers at the same time could be problematic (e.g. the MIT license says
"... this permission notice shall be included in all copies or
substantial portions of the Software")...

> Mostly I think if we're going to do this we should find somebody
> who wants to put in the work to push it forwards so we don't
> have a half-and-half interminably extended transition between
> old-style license notices and SPDX.

Agreed. I'd certainly be interested in helping here, but I currently
don't have time to fully drive this. So if someone has spare time for
this that would be very welcome - otherwise I might have a closer look
at the topics in a couple of weeks or months.

 Thomas


