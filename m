Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39887C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802D120809
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/uwBu1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802D120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLofa-0005NI-DD
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLodl-0003W9-MF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLodj-0005D6-TR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:24:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601043839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgnGZLVHNo4f6KsWUGBvhA9uEUMlgo1ufsPs80h9IS8=;
 b=P/uwBu1esBcK/pEKd67+9ZX0scOwxxI8NZh2B+PkFr3S52nwuOEQ6FoDsoRNexLl+pSyNX
 obBMHIVLtblePt9obIegAUiBQpSdXpu9oEviyuMzf05oH2wjn1+Mj65yrvQaCwGbxvwgTY
 8gHE6+Vl5XmT01le4VxFD4ekprEdDFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-s94ofRAkP9uuiOISO9ZvWw-1; Fri, 25 Sep 2020 10:23:54 -0400
X-MC-Unique: s94ofRAkP9uuiOISO9ZvWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F37C81891E88
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 14:23:53 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 719D010013C4;
 Fri, 25 Sep 2020 14:23:53 +0000 (UTC)
Subject: Re: [PATCH v3 05/47] qapi/doc.py: Change code templates from function
 to string
To: Markus Armbruster <armbru@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-6-jsnow@redhat.com>
 <87pn6aw7to.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <46a1882c-c17e-5f12-44ce-03ec51a05964@redhat.com>
Date: Fri, 25 Sep 2020 10:23:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87pn6aw7to.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 4:59 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> For whatever reason, when these are stored as functions instead of
>> strings, it confuses sphinx-autodoc into believing them to be
>> docstrings, and it chokes on the syntax.
>>
>> Keeping them as dumb strings instead avoids the problem.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> Quoting my review of the patch that added it: "This .format business is
> perhaps a bit too clever.  But let's move on."
> 

It seems perfectly fine, and I have no real explanation for why it 
confuses autodoc.

I think autodoc is using regex that it maybe shouldn't be to identify 
some constructs instead of the proper Python AST. I looked extremely 
briefly but made the assessment it wasn't going to be quick.

> doc.py is about to be replaced, obsoleting this patch.  Regardless:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Yes, understood -- until such time as it is actually deleted, I am 
keeping it updated with the style I am trying to enforce just to make my 
own life simpler.

It's no problem to just trash it when the time comes, but in this case I 
wanted to explore what stopped us from using Sphinx autodoc earnestly -- 
and it just so happened that this was the sticking point.

Thanks for looking!

--js


