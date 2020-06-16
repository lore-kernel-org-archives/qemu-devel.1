Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E296C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADCA2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaOcY8iJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADCA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5hb-0003NW-8q
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jl5S9-0001Ix-UC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:52:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44298
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jl5S8-0006X4-3V
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592290331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSHQnkty5Ij6bYsBZIFxzy52uokPml9YjdRl+QNYvZU=;
 b=XaOcY8iJgn1xMgay95m3CRkR65X/wp4VEaX2vhFDRmzdBX1vgQg9/NrhOk1BPYrHR6jzbY
 tVmSoP32q5AUzxmd5bewMXlsrOtkzo95KCee+um/8r4lw3glHQsp+ZLPjHpw3p5+E2HK4S
 drGvDo7Ng4JeYvXVMeMcXEu8T8Zzn94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-IkjC-mpRM8e1y2B5iyEqrg-1; Tue, 16 Jun 2020 02:52:07 -0400
X-MC-Unique: IkjC-mpRM8e1y2B5iyEqrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C56D107B467;
 Tue, 16 Jun 2020 06:52:06 +0000 (UTC)
Received: from [10.40.193.154] (unknown [10.40.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C62865D9CD;
 Tue, 16 Jun 2020 06:52:04 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] qemu-options.hx: Mark all hmat-cache attributes
 required
To: Markus Armbruster <armbru@redhat.com>
References: <cover.1591794890.git.mprivozn@redhat.com>
 <b6d3bc2ac8b38a419c98fb5eb1454ffbcb4fa172.1591794890.git.mprivozn@redhat.com>
 <87a714bvy6.fsf@dusky.pond.sub.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <3a1c4ea2-dbca-4184-f2e1-0d94a8224811@redhat.com>
Date: Tue, 16 Jun 2020 08:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87a714bvy6.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:57
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

On 6/15/20 10:00 AM, Markus Armbruster wrote:
> Cc: the people involved in commit c412a48d4d "numa: Extend CLI to
> provide memory side cache information".
> 
> Michal Privoznik <mprivozn@redhat.com> writes:
> 
>> The documentation to `-numa hmat-cache` says that @node-id, @size
>> and @level are the only required attributes. The rest
>> (@associativity, @policy and @line) is optional. Well, not quite
>> - if I try to start QEMU with only the three required attributes
>> defined the QAPI code is complaining about associativity missing.
> 
> Only because @associativity visited first.
> 
>> According to QAPI all attributes are required. Make the docs
>> reflect that.
> 
> Correct.
> 
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>   qemu-options.hx | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>

> 
> Assuming non-optional is what we want:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Indeed, it is:

https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg08411.html

Thanks,
Michal


