Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D59C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 06:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AEC20857
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 06:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEMeOwLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AEC20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp4n9-0002Ea-2M
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 02:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp4i1-0007JD-7r
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 02:53:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp4hy-0002UM-Ls
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 02:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593240780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRw1XvFbyw7RYLExym52hvANw+t5h1XtZYg/kYYiWRk=;
 b=hEMeOwLt82A0+DJtz4AgUk0oSjJe5r8Il+jUA4gG5+sbUDsNo1v/RDnykB3cD8Xjg3TsuN
 gDvlLY1JJPol9F+qK3PpJekAn/HUt8fzfCmDd9vaPNFoOFYt9mwMKF0JslinWokN7EUQi5
 FPBDbZm15ge25/4TF4w4uvU2522+3ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-TWH-M3A-MhCVxykOqmMoPA-1; Sat, 27 Jun 2020 02:52:56 -0400
X-MC-Unique: TWH-M3A-MhCVxykOqmMoPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2C6A0BE9;
 Sat, 27 Jun 2020 06:52:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B4792B4A6;
 Sat, 27 Jun 2020 06:52:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B14411384A6; Sat, 27 Jun 2020 08:52:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v4 4/8] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-5-f4bug@amsat.org>
 <4d335933-9669-43e1-0966-5f0255142012@kaod.org>
 <34fe3d2b-6b41-0509-f172-5b45486fdf0c@amsat.org>
 <deccf836-48ef-7112-d66e-a8d3cc4a9681@kaod.org>
 <877dvv4pmg.fsf@dusky.pond.sub.org>
 <2d1b8b24-3b2c-d84e-8026-e369f6531247@amsat.org>
 <03da95ed-399d-53e2-c946-a45f1a771701@amsat.org>
 <87bll6tlzl.fsf@dusky.pond.sub.org>
 <61d1f904-0d4f-4ae6-2d4e-3d8e87a9b77c@amsat.org>
Date: Sat, 27 Jun 2020 08:52:51 +0200
In-Reply-To: <61d1f904-0d4f-4ae6-2d4e-3d8e87a9b77c@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 26 Jun 2020 11:43:51
 +0200")
Message-ID: <877dvtt2yk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 02:53:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 6/26/20 7:49 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>=20
>>> On 6/25/20 10:12 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 6/25/20 8:37 AM, Markus Armbruster wrote:
>>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>>
>>>>>> On 6/22/20 10:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>> On 6/22/20 8:27 AM, C=C3=A9dric Le Goater wrote:
>>>>>>>> On 6/21/20 12:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>>> Add a description field to distinguish between multiple devices.
>>>>>
>>>>> Pardon my lack of imagination: how does this help you with debugging?
>>>>
>>>> Ah, the patch subject is indeed incorrect, this should be:
>>>> "... for *tracing* purpose" (I use tracing when debugging).
>>>>
>>>> In the next patch, we use the 'description' property:
>>>>
>>>> +# pca9552.c
>>>> +pca9552_gpio_status(const char *description, const char *buf) "%s GPI=
Os
>>>> 0-15 [%s]"
>>>>
>>>> So when the machine has multiple PCA9552 and guest accesses both,
>>>> we can distinct which one is used. For me having "pca1" / "pca0"
>>>> is easier to follow than the address of the QOM object.
>>>>
>>>>>
>>>>>>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>>>>>
>>>>>>>> Could it be a QOM attribute ?=20
>>>>>>>
>>>>>>> What do you call a 'QOM attribute'?
>>>>>>> Is it what qdev properties implement?
>>>>>>> (in this case via DEFINE_PROP_STRING).
>>>>>>
>>>>>> I meant a default Object property, which would apply to all Objects.=
=20
>>>>>
>>>>> Good point.  Many devices have multiple component objects of the same
>>>>> type.
>>>>>
>>>>>> What you did is fine, so :
>>>>>>
>>>>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>>>
>>>>>> but, may be, a well defined child name is enough for the purpose.
>>>>>
>>>>> object_get_canonical_path() returns a distinct path for each (compone=
nt)
>>>>> object.  The path components are the child property names.
>>>>>
>>>>> Properties can have descriptions: object_property_set_description().
>>>>
>>>> TIL object_property_set_description :>
>>>>
>>>> Ah, there is no equivalent object_property_get_description(),
>>>> we have to use object_get_canonical_path(). Hmm, not obvious.
>>>>
>>>>>
>>>>> Sufficient?
>>>>
>>>> I don't know... This seems a complex way to do something simple...
>>>> This is already a QDEV. Having to use QOM API seems going
>>>> backward, since we have the DEFINE_PROP_STRING() macros available
>>>> in "hw/qdev-properties.h".
>>>>
>>>> Maybe I'm not seeing the advantages clearly. I'll try later.
>>>
>>> The canonical path is not very helpful in trace log...
>>=20
>> Why?
>>=20
>> Okay, I checked the code.  Since the devices in question don't get a
>> composition tree parent assigned, realize puts them in the
>> /machine/unattached orphanage.  The canonical path is something like
>> "/machine/unattached/device[6]", which is less than clear.

This is common for onboard devices.  I hate it.

Some boards do better than others.  For instance, ast2600-evb has 33
sensibly named entries under /machine/soc/, and only 9 entries in the
/machine/unattached/ orphanage.  i440fx has two sensible named ones
under /machine/, and 26 in the orphanage.

>> The components of the canonical path are the names of the QOM child
>> properties.  object_get_canonical_path_component() returns the last one,
>> in this case "device[6]".
>>=20
>> If we made the devices QOM children of some other device, we could name
>> the child properties "pca0" and "pca1".
>> object_get_canonical_path_component() would then return the strings you
>> want to see.
>>=20
>> We make a device a QOM child of some QOM parent device only if the child
>> is a component device of the parent (hence the name "composition
>> tree").
>>=20
>> Are these devices integral components of something else, or are they
>> separate chips?
>
> Separate chips in the machine (actually not even on the machine mother
> board where is the CPU, but on a daughter board card).
>
> So in the composition tree I expect to see them as
>
>   /machine/pca0
>   /machine/pca1

As long as the final canonical path component is something readable
rather than auto-generated crap like "device[6]",
object_get_canonical_path_component() is usable for tracing.

>>> The description I set matches the hardware definitions
>>> and is easier to follow, see patch #6 (where it is set)
>>> where the description comes from:
>>>
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg714658.html
>>>
>>>   Description name taken from:
>>>   https://github.com/open-power/witherspoon-xml/blob/master/witherspoon=
.xml
>>>
>>> So in this particular case I don't find the canonical pathname
>>> practical (from an hardware debugging perspective).
>>=20
>> Personally, I'd be content with i2c bus and address for debugging
>> purposes.
>>=20
>> The i2c buses *are* components: canonical paths look like
>> "/machine/soc/i2c/aspeed.i2c.3".  The combination of
>> object_get_canonical_path_component(dev) and
>> object_property_get_uint(dev, "address", &error_abort) identifies any
>> i2c device on this machine, not just the two you decorate with a
>> description string.
>
> The I2C busses is provided by Aspeed peripherals. I counted 19 different
> I2C busses on this machine.
>
> "pca0" is connected to i2c bus #11, "pca1" to bus #3.
>
> I still don't think this will be practical, but I'll try your
> suggestion.

"bus=3D11 addr=3D0x60" isn't exactly wonderful, but it seems practical
enough for me.  Even "device[6]" seems workable, just bothersome,
because it's needlessly hard to remember, and prone to change.

Mind, I'm not recommending any particular solution for "want a more
useful device ID in traces", I'm just throwing out ideas on how to solve
the problem in a more general way.

Working towards a a neater QOM composition tree might help with more
than tracing.


