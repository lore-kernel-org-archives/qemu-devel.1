Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8618C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 17:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BE320792
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 17:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPb3UNO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BE320792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2e8V-0008Px-Rs
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 13:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2e7m-0007uf-Le
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 13:19:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34501
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2e7j-0003Sc-RO
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 13:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596475182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2akmLsgxpLRz4cRDZ2+4eh0NYwHFMY45MC8zfjpY+EI=;
 b=TPb3UNO8SViFPCeTLqWJUvEWU9K2MV3lgCVFeUFdl/GnpyFGthY+ITUlvhBJBnni6TF9yp
 uC2SMTkmQzC7VpR4DZcfBxViwDjeuE+JbXMAC2o742Z9Aeu+xFsOIaj1fbySIitEVL958F
 FErKgtW/4NL5hJMKgbrDcS1AXLfGqdY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-KVrXmALdO-elg8o6PFYZlA-1; Mon, 03 Aug 2020 13:19:40 -0400
X-MC-Unique: KVrXmALdO-elg8o6PFYZlA-1
Received: by mail-wr1-f70.google.com with SMTP id z12so11927988wrl.16
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 10:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2akmLsgxpLRz4cRDZ2+4eh0NYwHFMY45MC8zfjpY+EI=;
 b=m1w3A1ixYajVnvJ9AolVoR+9FozBAJegCXuxGWi++WaN0t1upiqDW2jtVabbjxS4bO
 /5b+gNXIuWt9DopwwnLWjB5nV4MKn8xMDYpFegThutQUZsy750W/bi/vYKGUdTHLUDxe
 +JNHZRt+j4jTBGO9S0vIHVaY0HMV/ktITojNjSuyJ0BOhrj5o4kxWzqd23SPH6onI/FG
 M7ZXM7ksxk0X5GjfelV/1k0bepJcXc0eaw2S7jleCnlsiWaA32wuD1MUTA3SKvUs8kWq
 AS/BTYB+4H18saTNZLNviIxeNQK7SOOdU5epeRcOhzgzAZzTq245ppxrobJCLqndcLoB
 bMMA==
X-Gm-Message-State: AOAM530QApP0oDRY3dqSJi8ZgPCuDua3lVONUEDeIbiP0bEZN+4ozYve
 tT/qa8Nma2BnlAdPLg6knStZgK2inou96aZynrYo79qwcesKrjokKtiLAE5Ka/QAXU+I6bRz0aP
 y5lM3mSb4Pns5o3w=
X-Received: by 2002:adf:82f6:: with SMTP id 109mr17476179wrc.25.1596475179353; 
 Mon, 03 Aug 2020 10:19:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwASAzVN9nDIOHckOoFxtlFYrdfLfaAmE2MYTP1IP9jGdmskECo9lfFlN+fqUTKphb12w9mFA==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr17476150wrc.25.1596475179071; 
 Mon, 03 Aug 2020 10:19:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id g14sm353495wmk.37.2020.08.03.10.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 10:19:38 -0700 (PDT)
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <87y2mvhg3k.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <facfef76-d880-82dd-f862-a64f8f487ba2@redhat.com>
Date: Mon, 3 Aug 2020 19:19:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87y2mvhg3k.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/08/20 18:03, Markus Armbruster wrote:
>> In general it seems like a good idea to use a standard file format and
>> not "a standard file format except for two characters". :)  We also
>> wouldn't be having discussions on editors.
> 
> No argument.  But towards which standard file format should the schema
> evolve?
> 
> * Standard JSON: no comments, no go
> 
> * JSON with # comments: need to change strings from ' to "
> 
> * JavaScript: need to change comments from # to //
> 
> * Python: may want to switch bool literals from true, false to True,
>   False

Second or third, I'd say.  I dislike using .py because a stream of
Python objects doesn't really have a meaning in Python: that's the
difference between .js and .json.

Third requires someone to do the work in the parser.  Unlikely.

>> That said, after a bit more research I'm skeptical about the possibility
>> of using an off-the-shelf parser because most of them either don't
>> support comments, or are based on YAJL which simply discards comments.
>>
>> Since '//' comments are harder to parse than "#" comments, this would
>> actually _add_ code instead of removing it.  Also since our doc comment
>> syntax uses "##" as a delimiter, we'd have to bikeshed what the doc
>> comments would look like ("//!", "///", etc.).
> 
> Doc comments don't have to be comments in the schema language.  They
> could be doc strings.  Requires decent support for long strings, which
> JSON does not provide.

Exactly.  This was the appeal of YAML (or StrictYAML so that Norwegians
don't turn into Falsians) as far as I understood.  But if we were to go
YAML, I'd rather have make doc strings part of the YAML document too.
That is what Nir suggested, it makes sense but someone has to write the
conversion code.

> If all we want is decent editor support out of the box, then rename to
> .py, and drop the modelines.  No merge conflicts, no git-blame
> pollution.

Another possibility is to rename to .qapi and keep Python modelines as a
hack that does work.

Paolo


