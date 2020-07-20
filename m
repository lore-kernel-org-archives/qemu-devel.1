Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A2BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 20:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F172080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 20:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDsnfTmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F172080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxc4l-0007cG-8N
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 16:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxc43-0006kD-K9
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 16:07:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24095
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxc40-0000hT-VE
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 16:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595275623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIWq4II3CfSPxkPXX/kJLVrXCW4YQke3JXRZtLzRd9s=;
 b=IDsnfTmTNAgqj7lUIip+IkEgajgeUBKVB40KlKrZ9k74kd4EuBJSHckkpye2fV7iU1wcoU
 lidK1h1fbi9CwKifJvhvm9M+g0UCDuH/szQ01jUnuXUtg46ZagCBlI7FqhK8Lh7XPVbklE
 KFX9FzoD1bnJDzriV6bR+p1V7hcgPVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-T6I3cwpoOleXusR2m0IsGQ-1; Mon, 20 Jul 2020 16:07:02 -0400
X-MC-Unique: T6I3cwpoOleXusR2m0IsGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23BA4107ACCA;
 Mon, 20 Jul 2020 20:07:01 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4487610021B3;
 Mon, 20 Jul 2020 20:07:00 +0000 (UTC)
Subject: Re: [PATCH 1/1] python/machine: Change default timeout to 30 seconds
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200720160252.104139-1-jsnow@redhat.com>
 <20200720160252.104139-2-jsnow@redhat.com>
 <20200720200137.GY1274972@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <14061c9d-be4f-f8ef-049e-c161274a3d84@redhat.com>
Date: Mon, 20 Jul 2020 16:06:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720200137.GY1274972@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 4:01 PM, Eduardo Habkost wrote:
> On Mon, Jul 20, 2020 at 12:02:52PM -0400, John Snow wrote:
>> 3 seconds is too short for some tests running inside busy VMs. Build it out to
>> a rather generous 30 seconds to find out conclusively if there are more severe
>> problems in the merge/CI tests.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> I would send my Reviewed-by to this patch without blinking if it
> only changed the default value without touching anything else,
> but this changes argument order and defaults in 4 different
> methods.
> 
> I will still review this, though, and I will probably reply in a
> few minutes with my Reviewed-by.

sorry, couldn't help myself ...

Since I changed the default, I thought it was better to remove the 
default in the inner methods that can't be called by client code anyway.


