Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F167320658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipC67WAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F167320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvi1k-00077I-7n
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvi0i-0005dr-PO
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:03:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvi0h-00077q-27
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukakhoyVrLdU7zvE4fTYSsg0S8TlcvHDcot9ZeBa/eg=;
 b=ipC67WAxEhIIGlbGRYmHAitKRdXRRd55kibu5w3PFVXBl/Q0O/VTjudjkLHk0ZoeOqWjo7
 VzzkmcDNWFM1vxqiPidL8VlMgiHTtCo9DzkXRrUuts29kN9dhNF4a9xb50Pured5PXKcoC
 gdB5NjShWshJ1111hmCiNmXVus2bBm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-mVsj-rBIMbu3EvWUc9oZVw-1; Wed, 15 Jul 2020 10:03:43 -0400
X-MC-Unique: mVsj-rBIMbu3EvWUc9oZVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E54E107ACCA;
 Wed, 15 Jul 2020 14:03:42 +0000 (UTC)
Received: from [10.72.13.230] (ovpn-13-230.pek2.redhat.com [10.72.13.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6FB110013C2;
 Wed, 15 Jul 2020 14:03:36 +0000 (UTC)
Subject: Re: [PATCH v4 0/2] net: tap: check file descriptor can be used
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200707184515.371476-1-lvivier@redhat.com>
 <e4eb0b4a-aa07-0dfe-f6ca-3435b867df57@redhat.com>
 <01a66c39-0677-205c-120e-d7b4355efcdb@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <94550f94-afc9-51ee-351b-f8b43bcbf27d@redhat.com>
Date: Wed, 15 Jul 2020 22:03:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <01a66c39-0677-205c-120e-d7b4355efcdb@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/15 下午5:16, Laurent Vivier wrote:
> On 09/07/2020 07:46, Jason Wang wrote:
>> On 2020/7/8 上午2:45, Laurent Vivier wrote:
>>> v4: use qemu_try_set_nonblock() with vhostfd in net_init_tap_one(),
>>>       and with fd in net_init_socket()
>>>
>>> v3: move qemu_fd_is_valid() checking into a new function
>>>       qemu_try_set_nonblock(), and use qemu_try_set_nonblock() in
>>>       qemu_set_nonblock().
>>>
>>> v2: Add patch from Daniel to check the fd can be used
>>>
>>>       I have updated Daniel's patch not to check for EINVAL on TUNGETIFF
>>>       as I think we can avoid this special case because TUNGETIFF
>>>       is available since kernel v2.6.27 (October 2008)
>>>       Moreover I think the code was wrong as it was checking with
>>> -EINVAL and
>>>       not EINVAL.
>>>
>>> Daniel P. Berrangé (1):
>>>     net: detect errors from probing vnet hdr flag for TAP devices
>>>
>>> Laurent Vivier (1):
>>>     net: check if the file descriptor is valid before using it
>>>
>>>    include/qemu/sockets.h |  1 +
>>>    net/socket.c           |  9 +++++--
>>>    net/tap-bsd.c          |  2 +-
>>>    net/tap-linux.c        |  8 +++---
>>>    net/tap-solaris.c      |  2 +-
>>>    net/tap-stub.c         |  2 +-
>>>    net/tap.c              | 50 +++++++++++++++++++++++++++++-------
>>>    net/tap_int.h          |  2 +-
>>>    util/oslib-posix.c     | 26 +++++++++++++------
>>>    util/oslib-win32.c     | 57 ++++++++++++++++++++++++------------------
>>>    10 files changed, 108 insertions(+), 51 deletions(-)
>>
>> Applied.
> It would have been great to have these fixes in 5.1
>
> Thanks,
> Laurent


Yes, pull has been sent.

Sorry for the late.

Thanks



