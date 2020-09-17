Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA76C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCB22087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM49Nc90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCB22087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIz3T-0005QW-Sx
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIz2D-0004kB-FR
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:53:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52776
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIz2A-0004fk-L0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600368809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fs56+6Sy+oLVIRfBTYUZtfP6eFuZvoJ9qx+3LPNX2Lc=;
 b=SM49Nc90WGIodyVxjpNm4Ys8giu74hw8v/RrojXDG84YCD+oQ0v3VR/ycgFBw+kMEo7+0g
 TPYjRLAQMiRw2Te/k8ao22CJlTrcNPQdVlUHzt8Ovg7IsDdIs/LlXSr6o7X1tOrzRvx+Pq
 fPhjz0/orPjzqBdxUC6kWk/0xnaNO2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-hImQGLMnOtuYvHAgy1fWBw-1; Thu, 17 Sep 2020 14:53:25 -0400
X-MC-Unique: hImQGLMnOtuYvHAgy1fWBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D75B80734F;
 Thu, 17 Sep 2020 18:53:24 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED61877D85;
 Thu, 17 Sep 2020 18:53:22 +0000 (UTC)
Subject: Re: [PATCH 15/37] qapi/common.py: split build_params into new file
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-16-jsnow@redhat.com>
 <877dsspiqd.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <9cd429a9-246b-167b-b75e-8ce3164ff39f@redhat.com>
Date: Thu, 17 Sep 2020 14:53:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <877dsspiqd.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 10:42 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> Including it in common.py creates a circular import dependency, because
>> schema relies on common.py. To type build_params properly, it needs to
>> be moved outside of the chain.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/commands.py |  2 +-
>>   scripts/qapi/common.py   | 23 -----------------------
>>   scripts/qapi/events.py   |  2 +-
>>   scripts/qapi/params.py   | 40 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 42 insertions(+), 25 deletions(-)
>>   create mode 100644 scripts/qapi/params.py
> 
> Ugh.
> 
> Would moving it gen.py work?
> 

Actually, yes.

I have an experimental patch way, way later in the series that does this:

1. Leaves common.py with *just* functions and constants used by 
schema.py: c_name, POINTER_SUFFIX, and transitively EATSPACE.

2. Splits gen_c.py out of gen.py, putting all of the C-specific 
generator classes in there.

3. Adds params.py and the C-specific bits of common.py into gen_c.py.


In effect, you get gen_c.py with all of the C-specific bits in it, all 
of the other code-generation modules import from gen_c (marking them 
obviously as C code generators), and schema.py and other parsing friends 
import only the tiny common.py for c_name().


I'll adjust this patch to stash this in gen.py for now. It's too 
disruptive to shift the other refactor around in my stack.

--js


