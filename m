Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B256C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A2420657
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qoz+t3MN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A2420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4Mx-000292-9C
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb4CI-0001BO-P2
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:30:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb4CH-0003WL-6s
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589902222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+67JuJTexPLa+fWen04abpPjVQ+DjdYjfH0h3LtSBc=;
 b=Qoz+t3MNQPxeDdaWn/I4AojONTbSFAr+JLkLgxuMeU2aE19BaDVvDcSjqZfv9AU9k4lHjM
 kymPqf2BsMRu0ajs0lY4GO8V+lRJy3RYY4tVpr2Lz+5zo2MTHMWTL4/Cf84vqVn5/CCIhZ
 RvFeIXmJlmX4krIxzTZ3AolaK8bGjVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-wbTo795ZNYS3YCA1hL8EhQ-1; Tue, 19 May 2020 11:30:10 -0400
X-MC-Unique: wbTo795ZNYS3YCA1hL8EhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 931E71005512;
 Tue, 19 May 2020 15:30:09 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F8756F7F5;
 Tue, 19 May 2020 15:30:09 +0000 (UTC)
Subject: Re: [PULL 0/7] bitmaps patches for 2020-05-18
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200518205448.690566-1-eblake@redhat.com>
 <CAFEAcA_PtAO_Nm+ZhU5juRM3+C69JQ3GSnyt8TiVVEjgF0XXkQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <356993c6-4038-14a8-1121-d92a20b313b4@redhat.com>
Date: Tue, 19 May 2020 10:30:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_PtAO_Nm+ZhU5juRM3+C69JQ3GSnyt8TiVVEjgF0XXkQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 7:42 AM, Peter Maydell wrote:
> On Mon, 18 May 2020 at 21:55, Eric Blake <eblake@redhat.com> wrote:
>>
>> The following changes since commit a28c9c8c9fc42484efe1bf5a77affe842e54e38b:
>>
>>    Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200518-pull-request' into staging (2020-05-18 16:37:09 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-18
>>
>> for you to fetch changes up to 6660c3a69c668ff98e2a86bca0b1301648ff4b02:
>>
>>    qemu-img: Add bitmap sub-command (2020-05-18 15:32:56 -0500)
>>
>> ----------------------------------------------------------------
>> bitmaps patches for 2020-05-18
>>
>> - update bitmaps maintainers
>> - add 'qemu-img bitmap' subcommand
> 
> Hi; this fails to compile:
> 
> /home/petmay01/linaro/qemu-for-merges/qemu-img.c: In function ‘img_bitmap’:
> /home/petmay01/linaro/qemu-for-merges/qemu-img.c:4593:27: error: too
> few arguments to function ‘cvtnum’
>               granularity = cvtnum(optarg);
>                             ^~~~~~

Semantic conflict with my NBD queue that got merged first. Will post v2 
pull request shortly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


