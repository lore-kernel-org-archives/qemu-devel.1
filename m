Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77545C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4FB2067B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWLx3bDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4FB2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj1SL-0001k5-C1
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 10:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jj1Re-0001FL-G7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:11:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jj1Rd-0002Il-Qj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591798268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=phthIbgSkiymNcUN8w0aZ9SlQ7+pFpY+Od4p28l49tg=;
 b=fWLx3bDCf8mbGjK8b4KUiyRKcZhDti9meIUbHVkHWdquipLoMy3n/vpKFfE/F/5KV19VuS
 1QD8VE0Zi4VS1LkcLMXHGro5QeSu7gW1bYqoU4rO28YUnDpb1G7gCkFpjXK39UbdXkcZP5
 9BuJKmMwor8tdm5MyYo+WKjRhMIhPaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-9hWD8v4NPwio5uQAprQVfA-1; Wed, 10 Jun 2020 10:10:49 -0400
X-MC-Unique: 9hWD8v4NPwio5uQAprQVfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AC2C80B73A;
 Wed, 10 Jun 2020 14:10:48 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.40.192.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 296067DFF5;
 Wed, 10 Jun 2020 14:10:36 +0000 (UTC)
Subject: Re: [PATCH] hw/vfio/pci-quirks: Fix broken legacy IGD passthrough
To: Laurent Vivier <laurent@vivier.eu>
References: <20200610035102.20192-1-thuth@redhat.com>
 <706060db-46c4-2dee-d746-eba24e6b137d@redhat.com>
 <a8195883-fb78-0cc1-5e15-e100dcb807de@redhat.com>
 <c5be50d5-5158-ddcc-8de0-bc6c3cfce12a@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c2809e06-5353-ca2d-e195-55c5a3e0dbac@redhat.com>
Date: Wed, 10 Jun 2020 16:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c5be50d5-5158-ddcc-8de0-bc6c3cfce12a@vivier.eu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/2020 15.16, Laurent Vivier wrote:
> Le 10/06/2020 à 09:50, Thomas Huth a écrit :
>> On 10/06/2020 09.31, Philippe Mathieu-Daudé wrote:
>>> On 6/10/20 5:51 AM, Thomas Huth wrote:
>>>> The #ifdef CONFIG_VFIO_IGD in pci-quirks.c is not working since the
>>>> required header config-devices.h is not included, so that the legacy
>>>> IGD passthrough is currently broken. Let's include the right header
>>>> to fix this issue.
>>>>
>>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1882784
>>>> Fixes: 29d62771c81d8fd244a67c14a1d968c268d3fb19
>>>>        ("hw/vfio: Move the IGD quirk code to a separate file")
>>>
>>> What about shorter tag?
>>>
>>> Fixes: 29d62771c81 ("vfio: Move the IGD quirk code to a separate file")
>>
>> I always forget whether to use the short or the long version for
>> "Fixes:" ... this can hopefully be fixed (if necessary) when the patch
>> gets picked up.
> 
> you can add in your ~/.gitconfig
> 
> [alias]
>         showfix = log -1 --format=fixes
> [pretty]
>         fixes = Fixes: %h (\"%s\")%nCc: %ae
> 
> and then:
> 
> $ git showfix 29d62771c81d8fd244a67c14a1d968c268d3fb19
> Fixes: 29d62771c81d ("hw/vfio: Move the IGD quirk code to a separate file")

That's nice, thanks! I've put it now in my gitconfig :-)

 Thomas


