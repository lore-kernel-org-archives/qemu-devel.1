Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94457C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 20:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECB6208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 20:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoIZaFyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECB6208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2hOf-0002Fe-Ld
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 16:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k2hO3-0001lL-4h
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 16:48:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k2hO0-00054Q-0m
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 16:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596487722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmQMIxZKdH37ZFuyf+nlG4xRP67+oPnvyInJI2eDLAY=;
 b=SoIZaFybP/w5QZUTnVBtI+90pwkGbWgUY6FiHnki/cZMn75K1C8i/Zp5ae6I+sXcRcfrPN
 NjnAPkgct0C174WGpGp3ckBpIbqz6DAMTkBDL0hq+m7X4YhTRFnMfSLrkwLouG6X65I3WZ
 b2SRE1gfaSL0pBHpGH9qexCvqFmsvbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-T6HliqpKPxqq0CSpSjxgTw-1; Mon, 03 Aug 2020 16:48:39 -0400
X-MC-Unique: T6HliqpKPxqq0CSpSjxgTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32BA88064AB;
 Mon,  3 Aug 2020 20:48:38 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com (unknown
 [10.10.115.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54B838AD1C;
 Mon,  3 Aug 2020 20:48:27 +0000 (UTC)
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: Nir Soffer <nsoffer@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <17a92222-2627-4961-b57e-1f1f5c86e14a@redhat.com>
 <e186e3b5-4aef-42c0-6957-2e5ae430686c@redhat.com>
 <6514f2e2-4694-6790-7663-f8a8f6a91e5a@redhat.com>
 <CAMRbyytzHwfEV2=bxhn3zVR3rUKK9DB0V1CCGgub=CfN0pH7jw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b5969c66-26d3-f9fd-a5f0-67ca21f59f93@redhat.com>
Date: Mon, 3 Aug 2020 16:48:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytzHwfEV2=bxhn3zVR3rUKK9DB0V1CCGgub=CfN0pH7jw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 3:54 PM, Nir Soffer wrote:
> On Mon, Aug 3, 2020 at 9:19 PM John Snow <jsnow@redhat.com> wrote:
>>
>> On 8/3/20 2:16 PM, Paolo Bonzini wrote:
>>> On 03/08/20 20:10, John Snow wrote:
>>>> Heresy:
>>>>
>>>> Docstrings could become part of the data format so they can be parsed,
>>>> analyzed and validated. Parsers largely treat comments like non-semantic
>>>> information and discard it. Round-trip parsers that preserve comments in
>>>> any language are extremely rare.
>>>>
>>>> If the docstrings are relevant to the generator and aren't discardable,
>>>> they should be fully-fledged data members.
>>>>
>>>> In a prototype I had for a YAML format, I just promoted docstrings
>>>> directly to fields, so I could allow clients to query help text for
>>>> individual commands.
>>>
>>> This would be actually a good idea, but somebody has to write the code.
>>>    Each field's docstring should be attached to the field, however---no
>>> parsing needed only looking at the tree.  Take a look at what Nir posted:
>>>
>>>> Here is the patch adding schema convertor from qemu "json" format to
>>>> standard yaml:
>>>> https://github.com/oVirt/vdsm/commit/e57b69e72987c0929b20306c454835b52b5eb7ee
>>>>
>>>> The current version of the new yaml based schema:
>>>> https://github.com/oVirt/vdsm/blob/master/lib/vdsm/api/vdsm-api.yml
>>>
>>>
>>>       VmDiskDevice: &VmDiskDevice
>>>           added: '3.1'
>>>           description: Properties of a VM disk device.
>>>           name: VmDiskDevice
>>>           properties:
>>>           -   description: Indicates if writes are prohibited for the
>>>                   device
>>>               name: readonly
>>>               type: boolean
>>>
>>>           -   description: The size of the disk (in bytes)
>>>               name: apparentsize
>>>               type: uint
>>>
>>> etc.
>>>
>>> Paolo
>>>
>>
>> I was working on a small prototype that used something that looked like
>> this; the "*opt" format was traded for "?opt", but otherwise:
>>
>>
>> struct:
>>     name: AudiodevPerDirectionOptions
>>     doc: >
>>       General audio backend options that are used for both
>>       playback and recording.
>>     since: '4.0'
>>     members:
>>
>>       ?mixing-engine:
> 
> This optimizes for writing instead of reading.
> 

Following a "path of least resistance" from the existing QAPI language, 
clearly carrying over the '*optional' syntax.

>      optional: true
> 
> Would be nicer to read, but more important is all the tools parsing
> this schema in multiple languages that will have code like:
> 
>      def is_optional(node):
>          return node.name.startswith("?")
> 
> Instead of :
> 
>     if node.optional:
>         ...
> 
> Or maybe better:
> 
>      if node.required:
> 
> Because it seems that more nodes are optional, so focusing on the required
> items will make the schema shorter and more clear.
> 
>>         type: bool
>>         default: 'true'
>>         since: '4.2'
>>         doc: |
>>           Use QEMU's mixing engine to mix all streams inside QEMU and
>>           convert audio formats when not supported by the backend.
> 
> Using | is nicer than >-. Not sure what is the difference. In vdsm we don't use
> anything and I think it causes trouble when indenting text.
> 

I believe when I wrote this example I was trying to highlight the 
different space consumption styles for the purposes of demonstrating 
what it would do to Sphinx document generation support.

ultimately, there's not really a way to enforce one or the other style 
post-parse.

>>           When set to off, fixed-settings must be also off.
>>
>>       ?fixed-settings:
>>         type: bool
>>         default: 'true'
> 
> Why is the default a string and not the actual type?
> 

I'm going to be honest: I forget. I was playing around with the idea of 
documenting defaults for the purposes of documentation, but not 
necessarily for performing the actual code generation of those defaults.

I believe I specified this field as a string in my grammar and `5` would 
get promoted to "5", but `true` caused a type error.

Doing something in a type-safe way seemed ... harder. So I didn't.

>>         doc: >-
>>           Use fixed settings for host input/output.
>>           When off, frequency, channels and format must not be specified.
>>
>>       ?frequency:
>>         type: bool
>>         default: '44100'
>>         doc: >-
>>           frequency to use when using fixed settings.
>>
>>       ?channels:
>>         type: 'uint32'
>>         default: 2
> 
> Here you use the real type, and this is nicer.
> 
>>         doc: >-
>>           Number of channels when using fixed settings.
>>
>>       ?voices:
>>         type: 'uint32'
>>         default: 1
>>         doc: "Number of voices to use."
>>
>>       ?format:
>>         type: 'AudioFormat'
>>         default: 's16'
>>         doc: "Sample format to use when using fixed settings."
>>
>>       ?buffer-length:
>>         type: 'uint32'
>>         doc: 'The buffer length, in microseconds.'
>>
>>     features:
>>       my-cool-feature:
>>         since: '6.0'
>>         doc: 'This is, no doubt, an extremely cool feature.'
>>
>>       my-bad-feature:
>>         doc: 'This is a very bad feature. I am sorry for making it.'
>>         since: '1.0'
>>         deprecated: '5.9'
> 
> Good example :-)
> 
>>
>>
> 


