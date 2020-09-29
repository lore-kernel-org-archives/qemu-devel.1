Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A664BC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86BE207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmPootB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86BE207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHiV-0007NB-D6
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNHgm-00060c-Qr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNHgk-00032M-W1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:37:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601393830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8cc9IIyzjSUAbUWpHaPZ6/q23SwBX+d3fzkby4bx6Y=;
 b=KmPootB4byLVQ+hmIdNfmKuuzt6grs0XGkLHsC57ZVZ4Fp+4iRamn3JRJdCxb/nPEIjJLV
 X8aGY25+u3wGKTq0wrICNbG+5DAUrdoED5ICcWTmISZ6UmdWH8LojGHhm6/HJ25NZef8Dt
 R1NZSTdcKzKx8eZpL3rNQczh+eO72Fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-Bfo562yjNCWRNeEuYZFhVw-1; Tue, 29 Sep 2020 11:37:08 -0400
X-MC-Unique: Bfo562yjNCWRNeEuYZFhVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 714CD80733D
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:37:06 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFD4760C13;
 Tue, 29 Sep 2020 15:37:05 +0000 (UTC)
Subject: Re: [PATCH v3 04/47] qapi: modify docstrings to be sphinx-compatible
To: Cleber Rosa <crosa@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-5-jsnow@redhat.com>
 <20200929033946.GE700868@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <2263602c-97c7-4e6b-4bde-f209e6d5efef@redhat.com>
Date: Tue, 29 Sep 2020 11:37:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929033946.GE700868@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 11:39 PM, Cleber Rosa wrote:
> On Thu, Sep 24, 2020 at 08:28:17PM -0400, John Snow wrote:
>> I did not say "sphinx beautiful", just "sphinx compatible". They will
>> not throw errors when parsed and interpreted as ReST.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/doc.py    | 10 +++++-----
>>   scripts/qapi/gen.py    |  6 ++++--
>>   scripts/qapi/parser.py |  9 +++++----
>>   3 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
>> index 92f584edcf..c41e9d29f5 100644
>> --- a/scripts/qapi/doc.py
>> +++ b/scripts/qapi/doc.py
>> @@ -65,11 +65,11 @@ def texi_format(doc):
>>       Format documentation
>>   
>>       Lines starting with:
>> -    - |: generates an @example
>> -    - =: generates @section
>> -    - ==: generates @subsection
>> -    - 1. or 1): generates an @enumerate @item
>> -    - */-: generates an @itemize list
>> +    - ``|:`` generates an @example
>> +    - ``=:`` generates @section
>> +    - ``==:`` generates @subsection
>> +    - ``1.`` or ``1):`` generates an @enumerate @item
>> +    - ``*/-:`` generates an @itemize list
>>       """
>>       ret = ''
>>       doc = subst_braces(doc)
>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>> index bf5552a4e7..3d25a8cff4 100644
>> --- a/scripts/qapi/gen.py
>> +++ b/scripts/qapi/gen.py
>> @@ -154,9 +154,11 @@ def _bottom(self):
>>   
>>   @contextmanager
>>   def ifcontext(ifcond, *args):
>> -    """A 'with' statement context manager to wrap with start_if()/end_if()
>> +    """
>> +    A 'with' statement context manager to wrap with start_if()/end_if()
>>   
> 
> If you're making it compatible, why not take the time to give
> backticks to start_if and end_if?
> 

I forget. Must not have been a good reason, then...?

> Bonus points for setting the "meth" role, but not lost points for not
> doing it, as I understand this is beyond what you're attempting at
> this time.
> 

I remain unsold on using explicit roles for references in docstrings, 
because I'd like to keep the amount of Sphinx-ese syntax down to a 
minimum if I can. The double backticks are bad enough ...

>> -    *args: any number of QAPIGenCCode
>> +    :param ifcond: List of conditionals
>> +    :param args: any number of QAPIGenCCode
>>   
> 
> I would argue that this is not a strict sphinx compatibility change,
> but a fix to a broken docstring.
> 

Not entirely correct: the syntax of *args breaks document generation.

(OK, I could make QAPIGenCCode a reference ...)

> - Cleber.
> 


