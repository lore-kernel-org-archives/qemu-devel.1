Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D50C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E602080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4Dh9Ou8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E602080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSInH-0004aB-GC
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSIm7-0003it-Oq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSIm2-0004VS-VM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602589640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNFn/qMy9EnfR5us5Ma9cJQD06CsqPHVsuPTnklBTpI=;
 b=V4Dh9Ou8+TqvsbVBYajygbDrS0BvVDGiVt2oQYQGMqq6yqLfWXtqY6HlVjacAqJBnk7sU6
 ANKuRe8GuDQVu2fyDeC5HPKmxagXJUtkj1qR2ZwMhiNJZBgk4VhoXb8/gZY5wpAt3SB7mg
 x6jTp/k/l5sARq0K6FjfJhtwtKHTeIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-Kz1K0P4lO72nbV4rZAwMnw-1; Tue, 13 Oct 2020 07:47:18 -0400
X-MC-Unique: Kz1K0P4lO72nbV4rZAwMnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B1B7107AFB2;
 Tue, 13 Oct 2020 11:47:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF4975C1C2;
 Tue, 13 Oct 2020 11:47:14 +0000 (UTC)
Subject: Re: [PULL 00/15] Trivial branch for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
 <CAFEAcA81HdRLh25MoC+=ZS7TERAzbZt_Ns+-Lp=oZFL69nMsoA@mail.gmail.com>
 <f22fbab6-9b09-341c-98c8-0832e29de1a5@redhat.com>
 <b27a2faa-15d0-fe28-a758-537e5fdeb94c@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <76083919-fdef-de5d-128c-0099b8978175@redhat.com>
Date: Tue, 13 Oct 2020 13:47:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b27a2faa-15d0-fe28-a758-537e5fdeb94c@vivier.eu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/2020 13.40, Laurent Vivier wrote:
> Le 13/10/2020 à 13:34, Thomas Huth a écrit :
>> On 13/10/2020 13.06, Peter Maydell wrote:
>>> On Tue, 13 Oct 2020 at 07:56, Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> The following changes since commit 2387df497b4b4bcf754eb7398edca82889e2ef54:
>>>>
>>>>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-10-10' int=
>>>> o staging (2020-10-12 11:29:42 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request
>>>>
>>>> for you to fetch changes up to ef3a1d9fc36140f8933fbced70ee21fd9740b33c:
>>>>
>>>>   meson.build: drop duplicate 'sparc64' entry (2020-10-12 23:11:32 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> Trivial Patches Pull request 20201013
>>>>
>>>> ----------------------------------------------------------------
>>>
>>> Compile failure on ppc64be:
>>>
>>> ../../hw/rtc/twl92230.c: In function ‘menelaus_rx’:
>>> ../../hw/rtc/twl92230.c:289:23: error: array subscript is above array
>>> bounds [-Werror=array-bounds]
>>>          return s->dcdc[addr - MENELAUS_VCORE_CTRL1];
>>
>> Uh, oh, mea culpa, copy-n-paste error... that should have been
>> MENELAUS_DCDC_CTRL1 instead.
>> Laurent, could you fix it up, or shall I send a v2 of the patch?
> 
> I prefere a v2, I don't like to play with patches in a pull request.

Sure, I'll send a v2 when I've got some spare time (i.e. for a future pull
request, not for this one).

 Thomas


