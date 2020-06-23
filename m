Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A69C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6626E2070E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3fUD4x9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6626E2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkmB-0005RE-JW
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jnkl6-0004XM-HM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:22:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jnkl3-0007o5-RG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592925764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yurOEOR3+8OV7Dyuj+11/b4vu7uceWZ/I62bnyA8Ua4=;
 b=B3fUD4x9SovfERfu9uIvfGsYKaQoqXjTjXo76VCxc1dfnJmD7iTDXY80XCCgGR/NSa3Jmq
 p9abv9oW5uQjcF+yaQOqXOXPXfopTxnemaO4akODixXt7Y0Cf0iGpM1rUJYfDfSex6T3OQ
 hCCk4XwNiKidtPJko+JZVihLzhJMH2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-K_kaor1YPV62cLTXSoxDUw-1; Tue, 23 Jun 2020 11:22:38 -0400
X-MC-Unique: K_kaor1YPV62cLTXSoxDUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5636E1005512;
 Tue, 23 Jun 2020 15:22:37 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D685D7166A;
 Tue, 23 Jun 2020 15:22:34 +0000 (UTC)
Subject: Re: [PATCH v3 1/5] qdev: Introduce DEFINE_PROP_RESERVED_REGION
To: Markus Armbruster <armbru@redhat.com>
References: <20200611151209.22547-1-eric.auger@redhat.com>
 <20200611151209.22547-2-eric.auger@redhat.com>
 <87k0zzz6nt.fsf@dusky.pond.sub.org>
 <f0ec7470-d683-1bfd-103d-54c57ebd3863@redhat.com>
 <87imfhhkyz.fsf@dusky.pond.sub.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e5964e6e-2ee2-577d-775a-b02d63bca651@redhat.com>
Date: Tue, 23 Jun 2020 17:22:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87imfhhkyz.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 jean-philippe@linaro.org, bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 6/23/20 5:15 PM, Markus Armbruster wrote:
> Auger Eric <eric.auger@redhat.com> writes:
> 
>> Hi Markus,
>>
>> On 6/22/20 1:22 PM, Markus Armbruster wrote:
>>> Eric Auger <eric.auger@redhat.com> writes:
>>>
>>>> Introduce a new property defining a reserved region:
>>>> <low address>, <high address>, <type>.
> [...]
>>> I dimly remember discussing the wisdom of numeric type here, dig, dig,
>>> ..., aha:
>>>
>>>     Subject: Re: [PATCH for-5.0 v11 12/20] qapi: Introduce DEFINE_PROP_INTERVAL
>>>     Date: Fri, 13 Dec 2019 11:03:02 +0100
>>>     Message-ID: <87y2vg4k6h.fsf@dusky.pond.sub.org>
>>>
>>>     >> So the "label" part of "<low address>,<high address>,label" is a number?
>>>     > yes it is.
>>>     >> 
>>>     >> Is a number appropriate for your use case, or would an enum be better?
>>>     > I think a number is OK. There might be other types of reserved regions
>>>     > in the future. Also if we want to allow somebody else to reuse that
>>>     > property in another context, I would rather leave it open?
>>>
>>>     I'd prioritize the user interface over possible reuse (which might never
>>>     happen).  Mind, I'm not telling you using numbers is a bad user
>>>     interface.  In general, enums are nicer, but I don't know enough about
>>>     this particular case.
>> Yep I remember too ;-) I left as it was because I think this property
>> could be used for other use cases.
> 
> YAGNI :)
> 
> A string would work, too, wouldn't it?
:-)

Eric
> 
> [...]
> 
> 


