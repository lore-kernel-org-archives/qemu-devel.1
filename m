Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CD4C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849DA2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ytui0OJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849DA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEANR-000281-OI
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEAFT-0001Ue-TL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEAFR-0006ma-Kk
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599220276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucf/Y7fduYAkvaRsJro5JLsgfdxqyxAKIYkwnCcqHpU=;
 b=Ytui0OJR/4kvY7LoC+uh8MuhGRiXfTmgo7vd5GuZpWgbshHXTHweDEiUNfAwj0MuQjucI/
 UVX7Kr+V+NwW/Jt3Qjy9Oy9NZmT0DMvnKXfnHQWNaATZl0oHyJ0Jh+fCW7L2EaXh/Tfs4X
 esil3vvKEVP7fle7w22Cbm8usPLjsHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-CWG_7jBaMQ-x69XNdjXGwQ-1; Fri, 04 Sep 2020 07:51:12 -0400
X-MC-Unique: CWG_7jBaMQ-x69XNdjXGwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99E32AF203;
 Fri,  4 Sep 2020 11:51:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-159.ams2.redhat.com [10.36.112.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B13C1A800;
 Fri,  4 Sep 2020 11:51:10 +0000 (UTC)
Subject: Re: [PATCH] iotests: Remove 030 from the auto group
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200904055701.462482-1-thuth@redhat.com>
 <20200904082513.GA6237@linux.fritz.box>
 <51e03521-f0b7-bf29-1ab8-9025f2f4ce94@redhat.com>
 <0c90a606-c697-332d-a3b7-12aec7c67f85@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f4f3818a-e808-fc98-8c98-dfcfebe8c9e4@redhat.com>
Date: Fri, 4 Sep 2020 13:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0c90a606-c697-332d-a3b7-12aec7c67f85@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/09/2020 12.38, Max Reitz wrote:
> On 04.09.20 12:14, Thomas Huth wrote:
>> On 04/09/2020 10.25, Kevin Wolf wrote:
>>> Am 04.09.2020 um 07:57 hat Thomas Huth geschrieben:
>>>> Test 030 is still occasionally failing in the CI ... so for the
>>>> time being, let's disable it in the "auto" group. We can add it
>>>> back once it got more stable.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> I would rather just disable this one test function as 030 is a pretty
>>> important one that tends to catch bugs.
>>
>> Ok, ... should it always get disabled, or shall we try to come up with
>> some magic checks so that it only gets disabled in the CI pipelines (...
>> though I don't have a clue how to check for Peter's merge test
>> environment...)?
> 
> I suppose we could let check-block.sh set some environment variable.

Sounds like a plan! I'll try to cook a patch.

 Thomas


