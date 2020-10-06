Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA30BC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C02C206DD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xtt6gwZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C02C206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPop6-00075f-NA
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPooC-0006cb-CZ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPoo9-00056t-VP
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601997795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JxxH1T1YBrwwDC+R3bj9RLC92Gp6TpPddCO1ykxhyo=;
 b=Xtt6gwZEgxaXtrJO+p7AK9oT7NZBC+Vcb0TB8wDCRZYxHDrc+rTK1OAkXjTYCYx97n3F9e
 7aM85anapAJUhOU5jyteZ/BTOeLIR6k7awqGRCMUg6FLL+5agHSmLT8l1hfxej++dgBq3f
 lmTRa8Ahn+pjyE/u1dysZmY8LpIouWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-kAMWHdcmPW6Wd-WB0CMYyQ-1; Tue, 06 Oct 2020 11:23:13 -0400
X-MC-Unique: kAMWHdcmPW6Wd-WB0CMYyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65C2D1018F83
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 15:23:12 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D421C55770;
 Tue,  6 Oct 2020 15:23:11 +0000 (UTC)
Subject: Re: [PATCH v5 02/36] qapi: modify docstrings to be sphinx-compatible
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-3-jsnow@redhat.com>
 <87r1qbtxb1.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <5f95ee89-78be-424b-906e-56b4f9bf76a5@redhat.com>
Date: Tue, 6 Oct 2020 11:23:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1qbtxb1.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 7:21 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> A precise style guide and a package-wide overhaul is forthcoming pending
>> further discussion and consensus. At present, we are avoiding obvious
>> errors that cause sphinx documentation build problems.
>>
>> A preliminary style guide is loosely based on PEP 257 and Sphinx
>> Autodoc. It is chosen for interoperability with our existing Sphinx
>> framework, and because it has loose recognition in the Pycharm IDE.
>>
>> - Use Triple-double quotes (""").
>> - Opening and closing quotes appear on their own lines for multi-line docs.
>> - A single-sentence summary should be the first line of the docstring.
>> - A blank line follows.
>> - Further prose, if needed, is written next and can be multiple paragraphs,
>>    contain RST markup, etc.
>> - The :param x: desc, :returns: desc, and :raises z: desc info fields follow.
> 
> Mandatory when they apply?
> 

Subject of debate...

- Some people really hate obvious docstring comments.
- Some people really like the consistency.

Which type of developer am I? Guess it depends on when you ask.

Figured we'd hash that out when I go to write a style guide document.

>> - Additional examples, diagrams, or other metadata follows below.
>>
>> See also:
>>
>> https://www.python.org/dev/peps/pep-0257/
>> https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html#info-field-lists
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/gen.py    | 6 ++++--
>>   scripts/qapi/parser.py | 1 +
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>> index ca66c82b5b8..dc7b94aa115 100644
>> --- a/scripts/qapi/gen.py
>> +++ b/scripts/qapi/gen.py
>> @@ -154,9 +154,11 @@ def _bottom(self):
>>   
>>   @contextmanager
>>   def ifcontext(ifcond, *args):
>> -    """A 'with' statement context manager to wrap with start_if()/end_if()
>> +    """
>> +    A with-statement context manager that wraps with `start_if()` / `end_if()`.
>>   
>> -    *args: any number of QAPIGenCCode
>> +    :param ifcond: A list of conditionals, passed to `start_if()`.
>> +    :param args: any number of `QAPIGenCCode`.
>>   
>>       Example::
>>   
>> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> index 9d1a3e2eea9..31bc2e6dca9 100644
>> --- a/scripts/qapi/parser.py
>> +++ b/scripts/qapi/parser.py
>> @@ -381,6 +381,7 @@ def append(self, line):
>>   
>>           The way that the line is dealt with depends on which part of
>>           the documentation we're parsing right now:
>> +
>>           * The body section: ._append_line is ._append_body_line
>>           * An argument section: ._append_line is ._append_args_line
>>           * A features section: ._append_line is ._append_features_line
> 
> I'm asking because you're not adding :param line: here.
> 

Yeah, it's not necessary to test the syntax of what else I've written 
with sphinx, so I didn't add it. VERY TECHNICALLY this blurb isn't 
required at all and could be deleted. You can do so if you'd like; it 
will just show up later in some other patch or series more designed to 
fix formatting.

> Same for several other functions in this file.
> 
> In schema.py:
> 
>      class QAPISchemaMember:
>          """ Represents object members, enum members and features """
> 
> Are the spaces next to """ okay?
> 

Ideally cleaned up, but that's not a goal of this patch or series.

--js


