Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0601320706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+OZVL60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0601320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAS1b-0003kO-Ai
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 02:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kARxv-0002DH-AG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 01:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kARxt-0000KE-Dk
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 01:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598335068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhnKdt8rz5RnE1SznAa43aU8yHbdYSpL6dqaNhlC+vM=;
 b=F+OZVL60DBv2mDuxBuPLcEGIGMYtnLUTBgmV5eauGnNZj71oQi48+H3c19tQGdxZfykICl
 LKiOgWljvkmMPkUkwCmgviqfu12ZFF43W3WuhNuEq47IbTv3n5pEIzUTe3nYnX6Uv3QjvO
 diUdq3UCF7oVWB3BNTsVtwGbGNBNBBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-EkyN53XMOUuXReWpb021WA-1; Tue, 25 Aug 2020 01:57:44 -0400
X-MC-Unique: EkyN53XMOUuXReWpb021WA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4158980EF8C;
 Tue, 25 Aug 2020 05:57:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-152.ams2.redhat.com [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C36C55D9D5;
 Tue, 25 Aug 2020 05:57:41 +0000 (UTC)
Subject: Re: meson.build files are missing copyright/license headers
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <CAFEAcA_0R9mQNFnyzdpR65YRHoDs0uPKWxmCOQUojbpAM-jP8A@mail.gmail.com>
 <CAJ+F1CL1Hp-g8gNMpdGgk2d0KCzJfBde9f_mX8TLtewe3-B48g@mail.gmail.com>
 <CAFEAcA_u_3P9MQ23zWTUH-aM8Nabbt+PVv+4qOWpEAhiuJq+cg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e9155559-9a06-ec6f-4be0-2a692364c665@redhat.com>
Date: Tue, 25 Aug 2020 07:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_u_3P9MQ23zWTUH-aM8Nabbt+PVv+4qOWpEAhiuJq+cg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/08/2020 20.46, Peter Maydell wrote:
> On Mon, 24 Aug 2020 at 19:29, Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
>> On Mon, Aug 24, 2020 at 1:44 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>   It looks like the new meson.build files are missing the usual
>>> copyright-and-license header comment. Could somebody add them,
>>> please?
>>>
>>> scripts/ninjatool.py does have a copyright line but is missing
>>> the license statement.
>>>
>>
>> Afaik, most makefiles didn't have any, so it falls under the default GPL2+ LICENSE rule.
> 
> Yep, but the rule is that new files should have them, even if
> old files didn't always.
> 
>> If it's a matter of prepending
>>
>> # SPDX-License-Identifier: GPL-2.0-or-later
>>
>> On each meson.build file, I can prepare a patch.
> 
> Everything needs at least a copyright line (in this case, judging
> by existing files in the tree it will probably be something like
> "Copyright (c) 2020 Red Hat, Inc." but check with your legal
> department what they like ;-)), plus a statement that clearly
> defines the license the code is under. We don't mandate SPDX[*],
> but it will do the job if you want to use it.
> 
> [*] Mostly because nobody's cared enough to say "we should
> standardize on this and convert existing files and add the
> check to checkpatch that new files have an SPDX line".

We should standardize on this and convert existing files and add the
check to checkpatch that new files have an SPDX line! :-)

Ok, now sombody said it loud. Would there be any objections to enforce 
this via checkpatch on new files?

  Thomas


