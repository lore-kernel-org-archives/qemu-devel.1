Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55121C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBBB2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4xtcG+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBBB2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5Wx-0000mS-75
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jl5Mh-0001nO-3R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jl5MY-0005gA-LB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592289982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqgsOw1a2P1L/SAd1EMDnyw9jtgX932OEGT98EbCM2U=;
 b=E4xtcG+riXkIOC0SRq3gouuONRHiy0uZ2ax8Yvji3I/a2elm0nV1ErzjFcFOGzXcctLczQ
 5GtuX7R7wOBbm57/hoWO0Bqn5fVL2UlVHuqfbXdiVt5wW+GuYiJlkdeYjH1PGnFYDRaGg9
 vSmcvaLcLHGOuVrzQTI6DeFYp6XSP8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-TEN4xq4hMeyWHSQPyPIJJA-1; Tue, 16 Jun 2020 02:46:18 -0400
X-MC-Unique: TEN4xq4hMeyWHSQPyPIJJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F28C3835B57;
 Tue, 16 Jun 2020 06:46:16 +0000 (UTC)
Received: from [10.40.193.154] (unknown [10.40.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1942819C79;
 Tue, 16 Jun 2020 06:46:12 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] qemu-options.hx: Document hmat-lb and hmat-cache
 order
To: Markus Armbruster <armbru@redhat.com>
References: <cover.1591794890.git.mprivozn@redhat.com>
 <5bd3f4a03227658cbdb1d184518c7805c1c0122f.1591794890.git.mprivozn@redhat.com>
 <877dw8bvu5.fsf@dusky.pond.sub.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <8de1babf-0925-eda0-9d30-a765aff0c4df@redhat.com>
Date: Tue, 16 Jun 2020 08:46:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <877dw8bvu5.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
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
Cc: Igor Mammedov <imammedo@redhat.com>, Liu Jingqi <jingqi.liu@intel.com>,
 Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 10:02 AM, Markus Armbruster wrote:
> Michal Privoznik <mprivozn@redhat.com> writes:
> 
>> To simplify internal implementation the hmat-cache parsing code
>> expects hmat-lb to be already parsed. This means, that hmat-lb
>> arguments must come before hmat-cache. Document this restriction
>> so that management applications can follow it.
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>   qemu-options.hx | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index b1a399079a..3fe9e6d6a0 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -319,6 +319,9 @@ SRST
>>       'none/direct(direct-mapped)/complex(complex cache indexing)'. policy
>>       is the write policy. line is the cache Line size in bytes.
>>   
>> +    Please note, that due to internal implementation, '\ ``hmat-cache``\ '
>> +    must be configured only after '\ ``hmat-lb``\ ' option.
>> +
>>       For example, the following options describe 2 NUMA nodes. Node 0 has
>>       2 cpus and a ram, node 1 has only a ram. The processors in node 0
>>       access memory in node 0 with access-latency 5 nanoseconds,
> 
> What happens when we do it wrong?
> 

We error out.

https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg08409.html

> Can we catch doing it wrong somehow?  I figure that would be much better
> than merely documenting it.
> 

Sure, but that would require some more code (according to Igor's e-mail 
and discussion linked from the linked document). And frankly, to libvirt 
it doesn't matter. For everybody else, let's document it at least and if 
somebody ever writes the missing piece we can remove the restriction 
from the docs.

Michal


