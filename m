Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC2BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 06:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C19220829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 06:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyLfnpQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C19220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Ool-00009L-L5
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 02:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k1Oo5-00085k-L3
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 02:46:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k1Oo2-0000q0-8o
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 02:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596177971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKP1iHmDNHXWt8TCaZXW565oFcZVI1i/skh1hQkfUsw=;
 b=LyLfnpQ1PYQxozBUImykeCGO9LnU3Mcu7R8e8kW3CxcgjBCfkrycTbZEAJywEczicU1f/d
 25AWN5FJKyglcb46JanradDXL0p6+FClbvYPzxWvedH6AiKZu00+x7Kx+ckEGDTi9mocyH
 N917aKA/SwZnQ4atw/I3eSgX88wUWCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-jIXnwkvvNGuXEjkkO_730Q-1; Fri, 31 Jul 2020 02:46:07 -0400
X-MC-Unique: jIXnwkvvNGuXEjkkO_730Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A622801E6A;
 Fri, 31 Jul 2020 06:46:06 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECF115F21A;
 Fri, 31 Jul 2020 06:45:54 +0000 (UTC)
Subject: Re: [PATCH] schemas: Add vim modeline
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ce88d35d-ff34-7e27-4518-c087ccd709cd@redhat.com>
Date: Fri, 31 Jul 2020 02:45:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730132446.GL3477223@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 02:46:11
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
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 9:24 AM, Daniel P. Berrangé wrote:
> On Thu, Jul 30, 2020 at 01:51:10PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>>                                modify them so that we can load the
>>> files straight into the python intepretor as code, and not parse
>>> them as data. I feel unhappy about treating data as code though.
>>
>> Stress on *can* load.  Doesn't mean we should.
>>
>> Ancient prior art: Lisp programs routinely use s-expressions as
>> configuration file syntax.  They don't load them as code, they read them
>> as data.
>>
>> With Python, it's ast.parse(), I think.
> 
> Yes, that could work
> 

I use a similar trick for parsing "Fuzzy JSON" inside of qmp-shell.

It's cute, and I'm not really proud of it.

> 
>>> struct: ImageInfoSpecificQCow2
>>> data:
>>>    compat: str
>>>    "*data-file": str
>>>    "*data-file-raw": bool
>>>    "*lazy-refcounts": bool
>>>    "*corrupt": bool
>>>    refcount-bits: int
>>>    "*encrypt": ImageInfoSpecificQCow2Encryption
>>>    "*bitmaps":
>>>      - Qcow2BitmapInfo
>>>    compression-type: Qcow2CompressionType
>>>
>>>
>>> Then we could use a regular off the shelf YAML parser in python.
>>>

I have a prototype where I started this, but I use "---" as a document 
separator to allow us multiple definitions per file so that the nesting 
remains pleasant.

(YAML does not allow you to duplicate field names.)

>>> The uglyiness with quotes is due to the use of "*". Slightly less ugly
>>> if we simply declare that quotes are always used, even where they're
>>> not strictly required.
>>
>> StrictYAML insists on quotes.
> 
> I wouldn't suggest StrictYAML, just normal YAML is what pretty much
> everyone uses.
>  > If we came up with a different way to mark a field as optional
> instead of using the magic "*" then we wouldn't need to quote
> anything
> 

I have a YAML prototype branch where I use `?field` to indicate optional 
syntax. It works just fine, at the expense of being slightly new to people.

I tested with normal YAML, but I was thinking about adopting strict YAML 
because Markus wanted some assurance we wouldn't get lost in the weeds 
using complex feature of YAML.

(Or, shoot ourselves entirely by accident.)

My prototype doesn't use anything that Strict YAML prohibits, so I 
thought it was a good idea.

IF -- IF IF IF IF IF we decide that actually we need the crazy 
horsepower of standard YAML, or that strict YAML is too buggy -- we 
could always just replace it. No real big deal.

>> I hate having to quote identifiers.  There's a reason we don't write
>>
>>      'int'
>>      'main'('int', 'argc', 'char' *'argv'[])
>>      {
>>          'printf'("hello world\n");
>>          return 0;
>>      }
>>

Fair enough ... but there's no special meaning to quoting or not quoting 
the RHS in YAML, so maybe it's best to avoid pretending like there's a 
structural semantic between an identifier and a string there.

(Since they're both just strings, and the semantic difference is picked 
up inside the QAPI generator post-parse.)

>>> struct: ImageInfoSpecificQCow2
>>> data:
>>>    "compat": "str"
>>>    "*data-file": "str"
>>>    "*data-file-raw": "bool"
>>>    "*lazy-refcounts": "bool"
>>>    "*corrupt": "bool"
>>>    "refcount-bits": "int"
>>>    "*encrypt": "ImageInfoSpecificQCow2Encryption"
>>>    "*bitmaps":
>>>      - "Qcow2BitmapInfo"
>>>    "compression-type": "Qcow2CompressionType"
>>>
>>> With the use of "---" to denote the start of document, we have no trouble
>>> parsing our files which would actually be a concatenation of multiple
>>> documents. The python YAML library provides the easy yaml.load_all()
>>> method.
>>

Nevermind the earlier comment, then.

>> Required reading on YAML:
>> https://www.arp242.net/yaml-config.html
> 
> I don't think this is especially helpful to our evaluation. You can write
> such blog posts about pretty much any thing if you want to pick holes in a
> proposal. Certainly there's plenty of awful stuff you can write about
> JSON, and Python.
> 
>> Some of the criticism there doesn't matter for our use case.
> 
> Yeah, what matters is whether it can do the job we need in a way that is
> better than what we have today, and whether there are any further options
> to consider that might be viable alternatives.
> 
> Regards,
> Daniel
> 

I guess I'll dust off the work I have already to show the class.

--js


