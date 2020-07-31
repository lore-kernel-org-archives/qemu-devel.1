Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B487FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8341922B42
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5cWm7ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8341922B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Wwm-0004My-Jm
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 11:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k1Wvn-0003V2-7O
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:26:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20682
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k1Wvl-0006Zy-K6
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596209205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJh7LwqnSJ4fWnx9paVcnQmM8xau82cYPCN3q5zToNE=;
 b=Z5cWm7ZWPpFEdX/hRTTTWA3VmU3Nv5dYzbVowzWPSRjfEuI5VJDlyhHXhZZ5fXzGBIoLp+
 5dUPhJnMz4qenc40DimMH0NmFJD7TM/bex2UXhb/e68yQJVE5LzXLet6ERDbdNH5eOQWQp
 6rGlMkhxGqlZ14zNIGxKrfEhciv17Qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-VvddpSatN36IQBYxRGRCcg-1; Fri, 31 Jul 2020 11:26:41 -0400
X-MC-Unique: VvddpSatN36IQBYxRGRCcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6AB8107ACCA;
 Fri, 31 Jul 2020 15:26:39 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35CBA57;
 Fri, 31 Jul 2020 15:26:29 +0000 (UTC)
Subject: Re: [PATCH] schemas: Add vim modeline
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
Date: Fri, 31 Jul 2020 11:26:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731150738.GB3660103@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 04:39:53
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

On 7/31/20 11:07 AM, Daniel P. Berrangé wrote:
> On Fri, Jul 31, 2020 at 02:55:34PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>>>> Some of the criticism there doesn't matter for our use case.
>>>
>>> Yeah, what matters is whether it can do the job we need in a way that is
>>> better than what we have today, and whether there are any further options
>>> to consider that might be viable alternatives.
>>
>> Would it improve things enough to be worth the switching pain?
> 
> The short answer is that I don't think that question matters. We should
> do the conversion regardless, as our JSON-but-not file format has no
> compelling reason to exist as a thing when there's a variety of standard
> file formats that could do the job. I'd explicitly ignore the sunk costs
> and minor amount of work to convert to a new format.
> 

This is not a language we spend a lot of time editing, too. Is it really 
such a big cost to re-learn a tiny language like this?

That concern seems overplayed, in my view.

> The long answer is that as a general philosophy I'm in favour of agressively
> eliminating anything that is custom to a project and isn't offering an
> compelling benefit over a functionally equivalent, commonly used / standard
> solution.
> 

I agree as violently as I know how. The purpose of this is not for us, 
it's for the ecosystem.

I saw the critique that we still use JSON-ish for the runtime QMP 
protocol, and moving the QAPI IDL to a standard wouldn't remove all 
instances of a custom format from our tree.

This is actually a great argument for doing the other thing: moving QMP 
onto a standard protocol. The point is not to complicate matters for 
QEMU developers, but to simplify matters for developers from other 
projects who are integrating QEMU.

> Any time a project re-invents the wheel, that is one more piece of custom
> knowledge a contributor has to learn. Each one may seem insignificant on
> its own, but cummulatively they result in death by a 1000 cuts. This makes
> a project increasingly less attractive to contribute to over the long term.
> 
> Measuring the long term benefit of the change is generally quite difficult,
> because while you can see what impact a change will have today on current
> code, it is hard to usefully evaluate future benefits as you're trying to
> imagine the impact on things that don't even exist.
> 
> Overall my POV is not to think too hard about measuring improvements, and
> discard any concern about sunk costs. Instead have a general presumption
> in favour of eliminating any examples of wheel re-invention in a project.
> Even if regular contributors don't want to spend time on such work, this
> kind of thing is pretty amenable to new contributors looking for tasks to
> start their involvement.
> 
> The QAPI JSON-but-not file format is a case where I think we should just
> adopt a standard file format no matter what. A conversion will have some
> short term work, but this is really simple data to deal with and the code
> involved is nicely self contained. Again I'm not saying QAPI maintainers
> must do it, just put the idea out there as a piece of work that would
> be welcomed if someone is interested in working ont.
> 

I have a lot of code trying to pylint and mypy-ify the QAPI parser, and 
a prototype YAML parser. The work that remains to be done is hooking up 
my new YAML parser into the code generator.

Assuming I am able to continue working on this, an RFC could be soon.

> Another example would be elimination of anything in QEMU code that is
> duplicating functionality in GLib, even if there zero functional
> difference between the two impls.
> 
> Another example would be adopting a standard code style and using a
> tool like clang-format to enforce this for entire of existing code
> base and future contributions and throwing away our checkpatch.pl
> which nearly everyone is scared of touching as it is Perl code.
> 
> Regards,
> Daniel
> 


