Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D326C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC46E20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8SUINJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC46E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvOR-0001HF-5k
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtvLW-0006Lm-9f
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:53:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtvLU-0000w3-3U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594396430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=R64k3LBmeci8PljdRSfOmgciz9niQuCWC6CXvdwFHLQ=;
 b=C8SUINJNaMH1gLfSkjU9wpMGQaC04Ee2flQ1asoJgpXbfIM7bt6hrLDpJK2eEfLpnQBUgH
 og7L6LmZEswBX2+JIWo4eerBWY1qNRTloEqWRmD7vpjMYJF/ZW5E/LtFdq9En2/cEtEHxb
 UR5qa/8leiGxkhJ3vCcoZ0Yl2Bap4Oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-rwrUSTobONWXKDcv56RgFA-1; Fri, 10 Jul 2020 11:53:48 -0400
X-MC-Unique: rwrUSTobONWXKDcv56RgFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92FDC80BCB2;
 Fri, 10 Jul 2020 15:53:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E5445C1D3;
 Fri, 10 Jul 2020 15:53:44 +0000 (UTC)
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
 <CAFEAcA-UbHpj_xSbqjTsaURt8yPZjuYOmd3pe97vg_G7--17Cw@mail.gmail.com>
 <e78820bb-af5f-c2a0-7727-1a0caedfa584@suse.de>
 <CAFEAcA-raDJ2pSUG-OYHcJi_LnQwxMHvcyjsD7+=WxGYcrSz3w@mail.gmail.com>
 <a8113ed1-c508-0502-4f88-77f875d1a739@redhat.com>
 <40f4c566-8a5b-c27e-22a7-2a112a0cd77d@suse.de>
 <c6e3336f-38b8-a8fa-4862-58e6f094711d@redhat.com>
 <CAFEAcA80XK4voLDj+8kVFcHJb35HT9HL+Qh8kGb3_Qe5Em9ouw@mail.gmail.com>
 <adeb1f02-c712-e256-6840-649795fdc3b5@redhat.com>
 <CAFEAcA9f0tadztJP7Ki0potF6=E+GaG8a_X_5HTyH2yw2T7goA@mail.gmail.com>
 <20200710154706.GC4034168@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <22ef268b-3607-8513-2fac-69e1e22b292e@redhat.com>
Date: Fri, 10 Jul 2020 17:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200710154706.GC4034168@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/2020 17.47, Daniel P. Berrangé wrote:
> On Fri, Jul 10, 2020 at 04:42:11PM +0100, Peter Maydell wrote:
>> On Fri, 10 Jul 2020 at 16:31, Max Reitz <mreitz@redhat.com> wrote:
>>>
>>> On 10.07.20 17:18, Peter Maydell wrote:
>>>> readarray only arrived sometime in bash 4, and the OSX system
>>>> bash is 3.2.57, so it won't have that builtin.
>>>
>>> It arrived with 4.0, actually, which was released 11 years ago.
>>> I had assumed that would be sufficiently mature.
>>>
>>> So, um, 11 years isn’t sufficiently mature then and I’ll have to work
>>> around not having readarray for macOS?
>>
>> It's the usual Apple-vs-GPL3 issue.
>>
>> I note that the iotests do seem to regularly run into
>> non-portable constructs: Kevin's latest pullreq has
>> just failed due to a use of 'truncate' that doesn't
>> work on the BSDs.
> 
> Since we already depend on homebrew for the build environment, we can
> pull in the newer bash from homebrew, and ignore the ancient version
> from macOS stock install.

I just had the same idea. And then add a simple check for bash 3.x in
tests/check-block.sh so that it skips the iotests if only the old
version is available.

 Thomas


