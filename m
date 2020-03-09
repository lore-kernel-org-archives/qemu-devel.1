Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C52EC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B502205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDfgUDL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B502205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNDi-0000Oh-5j
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 14:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBNCm-0008PI-Af
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBNCl-00019a-Ah
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:32:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBNCl-00018m-6C
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583778762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ryj0VvAj2225rx9wYzLRrmRshAkUWtMVyLw60oxy2uo=;
 b=WDfgUDL/uN4CHm5OwiMu2KRfB6eTzi23iRQnu+rJfBMdo8x35SobeXrNxX+teMRVrF71JW
 /eH/pXONbBaFj2KTNPJED/PTVt2/nIIcJ+8Bi+tPM/P/9k87DHDFhMT/QyCAwKjG9HGKSM
 Sn50EbFpKD2YtMryLRDFnRtdmcL3XYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-sASIoCbvPg6RAunHLuqkOg-1; Mon, 09 Mar 2020 14:32:37 -0400
X-MC-Unique: sASIoCbvPg6RAunHLuqkOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A2C3107ACC4;
 Mon,  9 Mar 2020 18:32:36 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E837A5D9E2;
 Mon,  9 Mar 2020 18:32:35 +0000 (UTC)
Subject: Re: [PATCH v8 1/9] qemu-binfmt-conf.sh: enforce safe style consistency
To: unai.martinezcorral@ehu.eus
References: <20200307172248.GA9@afee69d503a7>
 <1ba522c6-cae8-9e1f-ebf4-696076d2ca45@redhat.com>
 <CAGZZdDEqW4wkqsrYHYPy5ex1jqn5AAdbb4S0uzjfegMvwDUXmA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <daa79871-56eb-901f-0868-6e7edb7632e8@redhat.com>
Date: Mon, 9 Mar 2020 13:32:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAGZZdDEqW4wkqsrYHYPy5ex1jqn5AAdbb4S0uzjfegMvwDUXmA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 1:20 PM, Unai Martinez Corral wrote:
>   2020/03/09 16:01, Eric Blake:
> 
>> On 3/7/20 11:22 AM, Unai Martinez-Corral wrote:
>>> Spaces are added before '; then', for consistency.
>>
>> For consistency with what?  This is not our prevailing style; as
>> evidenced by this pre-patch search:
>>
>> $ git grep 'if \[.*\];' | wc
>>       274    2186   18170
>> $ git grep 'if \[.*\] ;' | wc
>>        25     256    1573
>>
>> and you are diverging from the dominant pattern.
>>
> 
> For consistency within the script that is being modified. I'm not trying to
> diverge, neither do I prefer any specific style.

Aha, I see what you were looking at: within the script itself, it was 10 
'] ;' vs. 2 '];'.  In which case, I'd recommend swapping the 10 
instances over to be common with the rest of the code base, rather than 
the 2 away from the rest of the code base but towards the rest of the 
script.

> Although the style in the current master is not consistent, ' ; ' is
> significantly more frequent. When I was told to keep consistency in v2, I
> picked that because it was the most common.
> Anyway, I will push a new version where all these are changed to the
> dominant pattern outside of this script.

Good to hear.

> 
> 
>> This part, however, is good.  Since one part is controversial, you may
>> want to split this into two patches, or even drop the reformatting part.
>>
> 
> Since the current master is neither consistent nor coherent with the
> dominant pattern, I don't think I can drop the reformatting as long as I
> want to fulfill your requirements.

Splitting into two patches (one to fix '] ;' spacing, the other to add 
'[ "x$..."' protection) is then the best course of action.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


