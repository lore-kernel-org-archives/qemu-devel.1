Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B555C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A9F206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYgMMdZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A9F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo1NN-0000Nc-Iv
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 05:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo1Ml-0008C2-Gx
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:06:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo1Mj-0008Nt-KR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592989604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcolnespcva+s5U4c+1P/onc99KyaKCn1Mqstj6ktkw=;
 b=DYgMMdZogTr1rqsvs5cpI5mcolQ4qdaVYdXdw2yWzrsVFh3Bh0p2YrUfEXnHGsYV189ja6
 2Nt0IBOxvzVhiPTeBbB1K0SagacfvvI3O9dls14sN2B16Kb/XKzFI4gx5pvFzW2uBRvO4E
 igoo2dF48n+UAQ4SyvC6AB720Yi2DfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-SxblfpqFNLOG8Efli0c2nQ-1; Wed, 24 Jun 2020 05:06:41 -0400
X-MC-Unique: SxblfpqFNLOG8Efli0c2nQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF7D8800D5C;
 Wed, 24 Jun 2020 09:06:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-35.ams2.redhat.com [10.36.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F541BA45;
 Wed, 24 Jun 2020 09:06:39 +0000 (UTC)
Subject: Re: [PULL 00/18] Block patches
To: Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200622151059.921191-1-mreitz@redhat.com>
 <CAFEAcA-QDYBf4COqrLmeO_v-gt6rq_J3rs6YexHGjCGTokVvDQ@mail.gmail.com>
 <8bed1833-3a47-ece9-2b5d-23881fa5a238@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <61337b2f-d0ae-ca1c-55bd-9b363e625459@redhat.com>
Date: Wed, 24 Jun 2020 11:06:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8bed1833-3a47-ece9-2b5d-23881fa5a238@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 09.27, Max Reitz wrote:
> On 23.06.20 14:55, Peter Maydell wrote:
>> On Mon, 22 Jun 2020 at 16:11, Max Reitz <mreitz@redhat.com> wrote:
>>>
>>> The following changes since commit bae31bfa48b9caecee25da3d5333901a126a06b4:
>>>
>>>    Merge remote-tracking branch 'remotes/kraxel/tags/audio-20200619-pull-request' into staging (2020-06-19 22:56:59 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/XanClic/qemu.git tags/pull-block-2020-06-22
>>>
>>> for you to fetch changes up to 74c55e4142a7bb835c38d3770c74210cbb1e4fab:
>>>
>>>    iotests: don't test qcow2.py inside 291 (2020-06-22 16:05:23 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Block patches:
>>> - Support modifying a LUKS-encrypted image's keyslots
>>> - iotest fixes
>>>
>>> ----------------------------------------------------------------
>>
>> Hi; I see various iotest failures, different things on
>> PPC64 Linux, OpenBSD and FreeBSD, and on an AArch32 build
>> that happens to not have optional crypto libs installed.
> 
> OK.  Sorry.  None of this looks easily fixable, so I suppose I’ll have
> to drop everything but the last two patches for now.

At least the problem with "seq" in test 293 should be easy to fix, since 
we're requiring bash for the iotests. See e.g. commit 30edd9fa50e86fbf 
as an example.

  Thomas



