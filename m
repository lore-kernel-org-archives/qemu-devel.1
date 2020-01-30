Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6EDC35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5490420CC7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7IWQtZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5490420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixI1A-0002oO-F1
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixI0U-0002AW-JV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixI0S-00009w-0d
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:09:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixI0R-00008V-SY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580422187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwUphAWQo0KbBGx2U/vmzSW5DvUDW+bFxz40je9soag=;
 b=E7IWQtZ6Aoog8f1Mq5veo1SZuAmHuQIb5YZEGfsv8FKT9dEu4zjj/W3RKrw8bSl/oWJN8Z
 kJVd2Rmr5EiS6seoZBcNtPOCsWm+aY7ojxuXNSb0IP8u5JyO3GASTkmeyEAVRR2OWyBF7Y
 pRy1Q57pA1CjVofgI3yNFXRoqtVQrJ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-RTd28l8vMpeuvr77KU9bBg-1; Thu, 30 Jan 2020 17:09:42 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so2359331wrm.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EgxH0Q2+gvE/aYlLvOBWFidPOfhKxe5WL+p2INPUkpg=;
 b=H+WBU66zN8+eFZ+feO6n7cLbFGh0jBcduKlpE5mS1K3+UnYfAdPvfUPES4Lrg6RfyJ
 it/slvZArsnheNVvejKK0Hi45w+0zg2bLzt6yYknhQLYUfQNR3+q9G8MGvYQWslltOOi
 hkccv+zHQ/DCoNN6DsXnEgy97AZrk5ewKXCWra7TMBsHtPzCJ5qztZ2pi1VY0oPGew1I
 ccU5SZF14+SkFKsdT4pG8ijMTfZi4eE213uupwTGVKnOIGyxojTxifz0tyM2M/hgYFVB
 9X2gHukjGd2eBCOlqyUc9wKgAANhH3icecDRvzFS1D7mnUUvj+eOS9jKTDiCke0T1Swh
 7D2Q==
X-Gm-Message-State: APjAAAUqeTisJJ1S150T0dZG7lJ+Co0HlX0GtgBihjs5nCepATWqrBfK
 p32eQ4dKyY9QPYzoSQxk+OrQ5wMwEqLEK65+6jXiJeCze54XODL+hGLWB2p8+6lKJDwF6y1c25z
 FOzTSK7lctesvSKA=
X-Received: by 2002:a1c:b607:: with SMTP id g7mr7838862wmf.110.1580422180696; 
 Thu, 30 Jan 2020 14:09:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVO0/W1ZgfVrCeEefdFq/7rll9noPkp9YZtPho3rVyNcCi5+UVdKd6I82U64QRtSpzZBhfEg==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr7838834wmf.110.1580422180355; 
 Thu, 30 Jan 2020 14:09:40 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q1sm3575186wrw.5.2020.01.30.14.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:09:39 -0800 (PST)
Subject: Re: [PATCH] qemu-deprecated: Remove text about Python 2
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200109095116.18201-1-thuth@redhat.com>
 <5883bc34-926e-70e3-6402-32dfb5d92ab2@redhat.com>
 <e1ae4e63-626c-cc6d-5117-4b4fbd1ad436@redhat.com>
 <20200114102031.GE4071034@redhat.com> <874kww7lk3.fsf@dusky.pond.sub.org>
 <efe0d310-1c48-4f1b-2ffe-46eea85af871@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8beaabcd-4026-c3fa-4168-698b1c4dfcd2@redhat.com>
Date: Thu, 30 Jan 2020 23:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <efe0d310-1c48-4f1b-2ffe-46eea85af871@redhat.com>
Content-Language: en-US
X-MC-Unique: RTd28l8vMpeuvr77KU9bBg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 6:16 PM, John Snow wrote:
> On 1/15/20 11:04 AM, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>>> On Tue, Jan 14, 2020 at 11:08:16AM +0100, Thomas Huth wrote:
>>>> On 13/01/2020 23.36, John Snow wrote:
>>>>> Right now, we don't
>>>>> really have these docs hosted in a searchable way online in a
>>>>> per-version format. Once the notice is gone, it's gone from the mirro=
r.
>>>>>
>>>>> I removed some bitmap functionality not too long ago and I created a
>>>>> "Recently Removed" section as a bit of a troubleshooting guide should=
 it
>>>>> be needed.
>>>>>
>>>>> - Do we want this section?
>>>>> - Should I remove it?
>>>>> - Can we add historical docs to the website to see previous deprecate=
d
>>>>> docs in a searchable manner?
>>>>
>>>> I also once started a page in the Wiki here:
>>>>
>>>>   https://wiki.qemu.org/Features/RemovedFeatures
>>>>
>>>> ... but apparently, it did not get enough attention yet, otherwise you
>>>> would have noticed it before introducing the new chapter into the
>>>> qemu-doc ...
>>>>
>>>> We definitely need one spot where we can document removed features. I
>>>> don't mind which way we do it, either the qemu-doc or the wiki, but we
>>>> should unify on one of the two. I guess the qemu-doc is the better pla=
ce
>>>> since we are tracking the deprecated features there already and one mo=
re
>>>> or less just has to move the text to the other chapter when things get
>>>> finally removed?
>>>
>>> Yeah, I've said in the past that we should not be deleting deprecations
>>> from the docs entirely.
>>>
>>> If you look at GTK docs for example, you'll see they keep a record of
>>> all incompatible or noteworth changes between release:
>>>
>>>    https://developer.gnome.org/gtk3/stable/gtk-migrating-3-x-to-y.html
>>>
>>> IMHO, we should follow this and have an appendix of removed features,
>>> with sub-sections per QEMU release listing each removed feature. Thus
>>> deprecation docs just get moved to this appendix at the right time.
>>
>> This is exactly the "Recently Removed" appendix John added in commit
>> 3264ffced3d.
>>
>> Now we need a sucker^Wvolunteer to restore all the stuff we dropped from
>> appendix "Deprecated features" to this appendix.  John, you were
>> incautious enough to signal you care; what about you?
>>
>=20
> Can add to the pile, but admittedly I am a little backlogged trying to
> recover from the holidays. I can't promise any time to it right this minu=
te.
>=20
> I can try next week, if I don't forget.

In case you forgot :P


