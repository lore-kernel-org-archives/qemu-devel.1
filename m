Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B17C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C1420708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUak1RAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C1420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQa0k-0003xS-Tm
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQZye-0001Wh-2T
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQZyc-0002m4-Ac
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602179113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqeffdtE1Pa/w55wkvKv8QG+jsxPDVjxTffVoT5pvqA=;
 b=GUak1RAsvSQsB8FMlYMk89K/pf/xtPFNmT46YpGBVf2E+WQW1KZDjOE66X5eNPAtn5I/hx
 33KRlqTR59jcG+KB777yvaNSWPnTJBfc/WGijwDgT9qlOyDosA9tdr6oQCKkoXsQWF9PYD
 EHXSXIWsLUB7r/0FCC36fBvccy+WpNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-8uiFrXFwOwar80MtwMa7sw-1; Thu, 08 Oct 2020 13:45:12 -0400
X-MC-Unique: 8uiFrXFwOwar80MtwMa7sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15F3864143
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 17:45:11 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80E465D9E8;
 Thu,  8 Oct 2020 17:45:08 +0000 (UTC)
Subject: Re: [PATCH v5 11/36] qapi/common.py: Add indent manager
To: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-12-jsnow@redhat.com>
 <87d01uifmn.fsf@dusky.pond.sub.org>
 <0a507019-1e59-2967-9c7a-fa3712a74ae0@redhat.com>
 <20201007181830.GZ7303@habkost.net> <87zh4x2nbx.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <235710fd-11e5-365f-b77c-fd5b5ca3c917@redhat.com>
Date: Thu, 8 Oct 2020 13:45:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87zh4x2nbx.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 3:23 AM, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
>> On Wed, Oct 07, 2020 at 02:08:33PM -0400, John Snow wrote:
>>> On 10/7/20 4:50 AM, Markus Armbruster wrote:
>>>> John Snow <jsnow@redhat.com> writes:
>>>>
>>>>> Code style tools really dislike the use of global keywords, because it
>>>>> generally involves re-binding the name at runtime which can have strange
>>>>> effects depending on when and how that global name is referenced in
>>>>> other modules.
>>>>>
>>>>> Make a little indent level manager instead.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>>>
>>>> Intentation is a job for QAPIGen (and its subtypes).  But if this patch
>>>> is easier to achieve this series' goal, I don't mind.
>>>>
>>>
>>> I agree, but refactoring it properly is beyond my capacity right now.
>>>
>>> This was the dumbest thing I could do to get pylint/mypy passing, which
>>> required the elimination (or suppression) of the global keyword.
>>>
>>> Creating a stateful object was the fastest way from A to B.
>>
>> An even dumber solution could be:
>>
>>    indent_prefixes = []
>>    def push_indent(amount=4):
>>        """Add `amount` spaces to indentation prefix"""
>>        indent_prefixes.push(' '*amount)
>>    def pop_indent():
>>        """Revert the most recent push_indent() call"""
>>        indent_prefixes.pop()
>>    def genindent():
>>        """Return the current indentation prefix"""
>>        return ''.join(indent_prefixes)
>>
>> No global keyword involved, and the only stateful object is a
>> dumb list.
> 
> Ha, this is Dumb with a capital D!  I respect that :)
> 
> John, I'm not asking you to switch.  Use your judgement.
> 

It's something we'll revisit soon, I'm sure. it's not good to be 
managing indent in so many different ways in so many different places.

(I prefer to leave it alone for now to try and press forward with 
accomplishing regression checks on strict typing.)

--js


