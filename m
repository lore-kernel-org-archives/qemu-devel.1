Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F4C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342FC21882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342FC21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmuG-0002SL-Am
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iSmtF-0001LM-CK
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iSmtB-0001rI-Eu
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:52:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iSmtB-0001q0-5c
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:52:13 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7B8BC04959B
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 18:52:11 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id 4so1616960wrf.19
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 10:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qBgba8JVfwoR6DVH0R0kEXJxXzxPG4YHntklo13mfc8=;
 b=FruzI/+FalgSc6fsVGOX+FbSHiLyQxwWnFqZ5ufHV5xDO2tQ94nYweHw8vI25SY/x3
 Q8dRADK75xt1c2RXpvNLMso8FGD2CR3rB9OLTLaJ26dfesKEokdrNRam+RfBSH5/Bvv5
 34OzJ3XaPAY3xr12MeMYL547RjrZRujiwpnbL+vmEYtzJ3xMFuteDqPmG+RGazxNn+GF
 BjgySv1PEUNaT3dawBv5iA+ropI0DoI4f2HZj8OwWfqHFCw9iYu1/n7lpx30k+WPpKmX
 QuRmKFg7bTfTbv7jWO2c8BzSrkjYxvE1b8mex6Hf/k1I9wbMpssmEX7yAev1qDXL8Q8Y
 ocnQ==
X-Gm-Message-State: APjAAAXHz63WrL+/Ak/kTmbPkYFTvC4DcDAzb2J4hx/PLa+VEhriy9+e
 KggSqI32NCrdkVSq+R8lLJydXFsSUMf4u/ZdzlDZlQ2Rq0XS5fnw4+TPbbJonPXabkdhUaJA2li
 ydOpVPFK1LHNctCo=
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr4442582wmg.145.1573152730342; 
 Thu, 07 Nov 2019 10:52:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqymrXjnmvmwECtKzkorOG9EpKSYEp2S94c8dBEZuvUJSGjlq3eF1yGmttZvkyIYBL/Ac3IuSg==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr4442542wmg.145.1573152729993; 
 Thu, 07 Nov 2019 10:52:09 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id 19sm1431009wrc.47.2019.11.07.10.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2019 10:52:09 -0800 (PST)
Subject: Re: [Qemu-devel] Exposing feature deprecation to machine clients
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <8736i2zf8e.fsf_-_@dusky.pond.sub.org>
 <423f2f82-9111-9c19-85b6-2645f66ab641@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ee0c3bf0-cb5b-835c-3981-d6f2b8af86e1@redhat.com>
Date: Thu, 7 Nov 2019 19:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <423f2f82-9111-9c19-85b6-2645f66ab641@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, libvir-list@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, mreitz@redhat.com,
 Alistair Francis <alistair.francis@wdc.com>, den@openvz.org,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 8/15/19 7:40 PM, John Snow wrote:
> On 8/15/19 10:16 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
[...]
>>> I asked Markus this not too long ago; do we want to amend the QAPI
>>> schema specification to allow commands to return with "Warning" strings,
>>> or "Deprecated" stings to allow in-band deprecation notices for cases
>>> like these?
>>>
>>> example:
>>>
>>> { "return": {},
>>>    "deprecated": True,
>>>    "warning": "Omitting filter-node-name parameter is deprecated, it will
>>> be required in the future"
>>> }
>>>
>>> There's no "error" key, so this should be recognized as success by
>>> compatible clients, but they'll definitely see the extra information.
>>
>> This is a compatible evolution of the QMP protocol.
>>
>>> Part of my motivation is to facilitate a more aggressive deprecation of
>>> legacy features by ensuring that we are able to rigorously notify users
>>> through any means that they need to adjust their scripts.
>>
>> Yes, we should help libvirt etc. with detecting use of deprecated
>> features.  We discussed this at the KVM Forum 2018 BoF on deprecating
>> stuff.  Minutes:
>>
>>      Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
>>      https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html
>>
>> Last item is relevant here.
>>
>> Adding deprecation information to QMP's success response belongs to "We
>> can also pass the buck to the next layer up", next to "emit a QMP
>> event".
>>
>> Let's compare the two, i.e. "deprecation info in success response"
>> vs. "deprecation event".
>>
>> 1. Possible triggers
>>
>> Anything we put in the success response should only ever apply to the
>> (successful) command.  So this one's limited to QMP commands.
>>
>> A QMP event is not limited to QMP commands.  For instance, it could be
>> emitted for deprecated CLI features (long after the fact, in addition to
>> human-readable warnings on stderr), or when we detect use of a
>> deprecated feature only after we sent the success response, say in a
>> job.  Neither use case is particularly convincing.  Reporting use of
>> deprecated CLI in QMP feels like a work-around for the CLI's
>> machine-unfriendliness.  Job-like commands should really check their
>> arguments upfront.
>>
>> 2. Connection to trigger
>>
>> Connecting responses to commands is the QMP protocol's responsibility.
>> Transmitting deprecation information in the response trivially ties it
>> to the offending command.
>>
>> The QMP protocol doesn't tie events to anything.  Thus, a deprecation
>> event needs an event-specific tie to its trigger.
>>
>> The obvious way to tie it to a command mirrors how the QMP protocol ties
>> responses to commands: by command ID.  The event either has to be sent
>> just to the offending monitor (currently, all events are broadcast to
>> all monitors), or include a suitable monitor ID.
>>
>> For non-command triggers, we'd have to invent some other tie.
>>
>> 3. Interface complexity
>>
>> Tying the event to some arbitrary trigger adds complexity.
>>
>> Do we need non-command triggers, and badly enough to justify the
>> additional complexity?
>>
>> 4. Implementation complexity
>>
>> Emitting an event could be as simple as
>>
>>      qapi_event_send_deprecated(qmp_command_id(),
>>                                 "Omitting 'filter-node-name'");
>>
>> where qmp_command_id() returns the ID of the currently executing
>> command.  Making qmp_command_id() work is up to the QMP core.  Simple
>> enough as long as each QMP command runs to completion before its monitor
>> starts the next one.
>>
>> The event is "fire and forget".  There is no warning object propagated
>> up the call chain into the QMP core like errors objects are.
>>
>> "Fire and forget" is ideal for letting arbitrary code decide "this is
>> deprecated".
>>
>> Note the QAPI schema remains untouched.
>>
>> Unlike an event, which can be emitted anywhere, the success response
>> gets built in the QMP core.  To have the core add deprecation info to
>> it, we need to get the info to the core.
>>
>> If deprecation info originates in command code, like errors do, we need
>> to propagate it up the call chain into the QMP core like errors.
>>
>> Propagating errors is painful.  It has caused massive churn all over the
>> place.
>>
>> I don't think we can hitch deprecation info to the existing error
>> propagation, since we need to take the success path back to the QMP
>> core, not an error path.
>>
>> Propagating a second object for warnings... thanks, but no thanks.
>>
> 
> Probably the best argument against it. Fire-and-forget avoids the
> problem. Events might work just fine, but the "tie" bit seems like a yak
> in need of a shave.
> 
>> The QMP core could provide a function for recording deprecation info for
>> the currently executing QMP command.  This is how we used to record
>> errors in QMP commands, until Anthony rammed through what we have now.
>> The commit messages (e.g. d5ec4f27c38) provide no justification.  I
>> dimly recall adamant (oral?) claims that recording errors in the Monitor
>> object cannot work for us.
>>
>> I smell a swamp.
>>
>> Can we avoid plumbing deprecation info from command code to QMP core?
>> Only if the QMP core itself can recognize deprecated interfaces.  I
>> believe it can for the cases we can expose in introspecion.  Let me
>> explain.
>>
>> Kevin recently added "features" to the QAPI schema language.  The
>> implementation is incomplete, but that's detail.  The idea is to tack a
>> "deprecated" feature to deprecated stuff in the QAPI schema.
>>
> 
> That's a good idea too; but the semantics of exactly *what* was
> deprecated may be hard to capture.
> 
>> Commands and arguments need to support features for that.
>> Implementation should be relatively straightforward.
>>
>> Deprecating an argument's optionalness may require a
>> "optional-deprecated" feature.  I've seen more elegant designs, but I've
>> also seen plenty of uglier ones.
>>
>> Note that features are tied to schema syntax.  To express semantically
>> conditional deprecation like "if you specify argument FOO, then not
>> specifying argument BAR is deprecated", we'd have to add a language for
>> these conditions.  Uh, not now, maybe never.
>>
>> The primary use of having deprecation defined in the QAPI schema is
>> introspection.  The BoF minutes mention this, too.
>>
>> A secondary use could be detecting use of deprecated features right in
>> the QMP core.  No need for ad hoc code in commands, no need for plumbing
>> information from there to the QMP core.
>>
>> I'd like to pursue this idea, then see how well it suits our deprecation
>> needs.
>>
> 
> I should clearly remember to talk to you before thinking about QMP in
> public, because you've thought about it much more.

Pre-release period, time to deprecate some stuffs :)

How should we proceed? Do you have something in mind?

There are older threads about this. Should we start a new thread? Gather 
the different ideas on the Wiki?

(Obviously you are not the one responsible of this topic, you just 
happen to be the last one worried about it on the list).

Regards,

Phil.

