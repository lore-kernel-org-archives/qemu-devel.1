Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92670C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F699207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtTZpr43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F699207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1AFa-0004nE-N7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1AE2-0003cW-KC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:12:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1AE0-0005lZ-Az
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596121921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcH1uMhYZ66g+JlPsvtnvtmgcaCznrTE7eJTSZ3cjPE=;
 b=NtTZpr43kuOxwHPnwbhH2DoMkavGO8FCCJCUIT8O8xhILF7vXFDF/IQzlXdB0i/yQ0KO6J
 nCNjnxG27b0PETnqFcG7NF/gO003DleW4eidQh+ty8Lc59IVGYMObTZQxElTLyZkmF6I2H
 AyNrCtEYoNT0DDu4nV1zfn5xqRwYWew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-f_ud1ntNNH2L8SbKK1DC8A-1; Thu, 30 Jul 2020 11:11:57 -0400
X-MC-Unique: f_ud1ntNNH2L8SbKK1DC8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE68257;
 Thu, 30 Jul 2020 15:11:55 +0000 (UTC)
Received: from [10.3.114.255] (ovpn-114-255.phx2.redhat.com [10.3.114.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EEFA71906;
 Thu, 30 Jul 2020 15:11:46 +0000 (UTC)
Subject: Re: [PATCH] schemas: Add vim modeline
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d3625b38-7f07-ea8b-42c3-1d462d18018f@redhat.com>
Date: Thu, 30 Jul 2020 10:11:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0ylz0ep.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 6:51 AM, Markus Armbruster wrote:

>> Given that we already have emacs mode-lines, I see no reason to
>> not also have vim mode-lines, so regardless of the deeper discussion
>> I think this is patch is fine to merge in the short term
>>
>>    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Agreed on that front.

>>
>>
>>> Naming QAPI schema files .json even though their contents isn't was a
>>> mistake.  Correcting it would be a pain.  If we correct it, then the
>>> sooner the better.
>>>
>>> Renaming them to .py gives decent editor support out of the box.  Their
>>> contents isn't quite Python, though: true vs. True, false vs. False.  Do
>>> we care?  Only a few dozen occurences; they could be adjusted.
>>>
>>> Renaming them to .qapi would perhaps be less confusing, for the price of
>>> "out of the box".

I've tried that patch in the past, but it went nowhere at the time.
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03173.html

Rebasing it to the present would be a complete rewrite, but I'm still 
willing to do it if we think it will go somewhere this time.


>>
>> IMHO, the critical rule is that if you a pick a particular file extension
>> associated with an existing language, you absolutely MUST BE compliant
>> with that language.
> 
> Can't argue with that :)

Also in violent agreement.

> 
>> We fail at compliance with both JSON and Python because we're actually
>> using our own DSL (domain specific language).
>>
>> IOW if we're going to stick with our current file format, then we should
>> be naming them .qapi. We can still use an editor mode line if we want to
>> claim we're approximately equiv to another language, but we can't be
>> surprised if editors get upset.
>>
>>
>> The bigger question is whether having our own DSL is justified ?
>>
>> I'm *really* sceptical that it is.
> 
> To be precise: our own DSL *syntax*.  Semantics is a separate question
> to be skeptical about.
> 
>> We can't use JSON because it lacks comments. So we invented our own
>> psuedo-JSON parser that supported comments, and used ' instead of "
>> for some reason. We also needed to be able to parse a sequence of
>> multiple JSON documents in one file. We should have just picked a
>> different language because JSON clearly didn't do what we eneeded.
> 
> JSON is a exceptionally poor choice for a DSL, or even a configuration
> language.
> 
> Correcting our mistake involves a flag day and a re-learn.  We need to
> weigh costs against benefits.

How much of that can be automated with tooling?  Yes, a re-learn is 
needed, but if a tool can convert between the two syntaces with minimal 
pain, the re-learn (in both directions: rebasing patches written 
pre-change for merge after the change lands upstream, and backporting 
patches post-change to trees that are pre-change) is not as painful.

> 
> The QAPI schema language has two layers:
> 
> * JSON, with a lexical and a syntactical sub-layer (both in parser.py)
> 
> * QAPI, with a context-free and a context-dependend sub-layer (in
>    expr.py and schema.py, respectively)
> 
> Replacing the JSON layer is possible as long as the replacement is
> sufficiently expressive (not a tall order).

I'm open to the idea, if we want to attempt it, and agree with the 
assessment that it is not a tall order.  In fact, if we were to go with 
the JSON5 language instead of JSON, we are already that much closer to 
having sufficiently expressive (although JSON5 does not seem to be as 
popular in terms of pre-written libraries).

> 
>> You suggest naming them .py. If we do that, we must declare that they
>> are literally Python code
> 
> Agree.

I'm not necessarily a fan of .py for QAPI files; it makes me think of 
executable python code, even if we chose it merely for something that 
python could parse natively instead of rolling our own parser.

> 
>>                                modify them so that we can load the
>> files straight into the python intepretor as code, and not parse
>> them as data. I feel unhappy about treating data as code though.
> 
> Stress on *can* load.  Doesn't mean we should.
> 
> Ancient prior art: Lisp programs routinely use s-expressions as
> configuration file syntax.  They don't load them as code, they read them
> as data.
> 
> With Python, it's ast.parse(), I think.
> 
>> While JSON doesn't do what we need, its second-cousin YAML is a more
>> flexible format. Taking one example
>>

> StrictYAML insists on quotes.
> 
> I hate having to quote identifiers.  There's a reason we don't write
> 
>      'int'
>      'main'('int', 'argc', 'char' *'argv'[])
>      {
>          'printf'("hello world\n");
>          return 0;
>      }
> 

JSON5 would also let us get rid of some quotes, if that is considered a 
desirable goal of the representation (although I'm not sure that quote 
avoidance should be driving our decision, so much as automated conversion).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


