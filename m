Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B33EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BF7206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGxuaGib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BF7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIEw-0007KG-Ba
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHoP-0002vk-I8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:41:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37207
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHoM-0003pQ-OH
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u1oLVhkwdrrqr9KIO/1hxkVUkb0RNCZZeyZDZKOVCXE=;
 b=AGxuaGibL+OU1bQaxqnoO8IE4wvouVQTrIOrDy09CRvNja9r1Qa8mn6/B/qtdmKHLBYzIJ
 TFffHS0DtazcwIYk5bjE2Fro3NvI8ixHO9Y7jBmP3vx0bzSzdhS3l2xtD3qTyTdHbCqJgJ
 YqeZYhUanuIQIC94wzEE+5ia+XaYtLk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-gXDLiLhuPIyern6gXD1Zig-1; Wed, 08 Jul 2020 09:38:20 -0400
X-MC-Unique: gXDLiLhuPIyern6gXD1Zig-1
Received: by mail-ej1-f72.google.com with SMTP id d16so37167733eje.20
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=u1oLVhkwdrrqr9KIO/1hxkVUkb0RNCZZeyZDZKOVCXE=;
 b=Ne8tCM5y5Ji2OqkRo+FHCHOVgra7fvg7ZH/+f5SA5wddaEDZ/t5HbBLd3HbQxhVsQ2
 50wTRb8U3bZYVPRB+4hgYiFrgEcHuPp1V8Fwvb/+Quldf4eaJk9O3Rz9uPxboT8EBE5O
 NUJdedvf/eFgdkOR2XOW71ZXqszs2bOTR9X/QLiZgmfL+GqkPxYLh37fcUiwn/Ry+tu2
 s4agOR0SMkadHwv4zkMMz7/s2yMMsg1WZ2RVnAmd7zwQDx7om8s6fGrpq0WMImR4rZnA
 0dUEkvRVqoEu+QxOAIbOLkonXkv10m5Ty0peSLc89ctCVISafXlQGWHbFL/SVnRxRFFv
 dzSw==
X-Gm-Message-State: AOAM531DHBLXSx7W/a3mSUQotWj9XGoBESfB3mdFHjHorHNKIGbtm9tM
 E5DVwMo89Ln2g8//59Lta/7UpCu+zwB7TMWrEgKfpwO8OhNFEMzTSubPyMrBJO8XcLDjt17SYyZ
 qIsXN+CXT50be44k=
X-Received: by 2002:a17:906:1151:: with SMTP id
 i17mr54527025eja.535.1594215498716; 
 Wed, 08 Jul 2020 06:38:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztMLb2QnoGWxmmjy6/tcHDgKUx9pm6rJHHmupxiOPjIKmvlhjWqaIZaokFKimPtw2mhcHnCw==
X-Received: by 2002:a17:906:1151:: with SMTP id
 i17mr54527001eja.535.1594215498468; 
 Wed, 08 Jul 2020 06:38:18 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s1sm27946667edy.1.2020.07.08.06.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 06:38:17 -0700 (PDT)
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <477ce8e8-283e-6f3e-d3ed-c7f758eaebdb@redhat.com>
 <67032ba5-41fc-8890-29b1-44d27d75f313@redhat.com>
 <20200708133214.GJ3229307@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <92d67b71-29db-c3e6-1b2c-e325f396ce0b@redhat.com>
Date: Wed, 8 Jul 2020 15:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200708133214.GJ3229307@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <cleber@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 3:32 PM, Daniel P. Berrangé wrote:
> On Wed, Jul 08, 2020 at 03:19:08PM +0200, Philippe Mathieu-Daudé wrote:
>> On 7/8/20 1:48 PM, Thomas Huth wrote:
>>> On 08/07/2020 12.53, Daniel P. Berrangé wrote:
>>>> On Wed, Jul 08, 2020 at 10:52:38AM +0100, Stefan Hajnoczi wrote:
>>> [...]
>>>>> With this in mind I propose moving qemu.org infrastructure to GitLab
>>>>> incrementally. [...]
>>>
>>> FWIW, I think moving the QEMU infrastructure zoo to GitLab is a very
>>> good idea!
>>>
>>> Daniel already mentioned most of the things that I had in mind after
>>> reading your mail (well, actually he mentioned way more things that I
>>> had in mind), but let me add some sentences below anyway...
>>
>> Same comment ;)
>>
>> I find sometime confusing the see which GitLab features are restricted
>> to the paid version and which are available for open source projects.
>>
>>>>> 5. Issue tracking. Launchpad more or less works, but the login always
>>>>> bothers me. If we move git repo hosting then it makes sense to do
>>>>> issue tracking on GitLab too.
>>>>
>>>> The big thing that always bothers me about launchpad is how easy it
>>>> is to get confused between issues for QEMU upstream and issues for
>>>> legacy releases in Ubuntu distro.
>>>
>>> +1000 !
>>>
>>> I was already thinking of suggesting to move the bug tracker to either
>>> gitlab or github or anywhere else during next KVM forum, since it is
>>> IMHO a real pain.
>>>
>>> I've seen so many bugs that users tried to open against the downstream
>>> Ubuntu QEMU package but ended up in the upstream tracker instead. Apart
>>> from that, the Launchpad UI is partly really horrible in my eyes (for
>>> example you never know which action will trigger an immediate change and
>>> which needs to be confirmed by pressing a button). Additional many
>>> developers don't have a Launchpad account, so bugs can not be assigned
>>> properly and you just have to pray that people see the notification
>>> e-mails on the mailing list.
>>>
>>>> There is a question of what todo with existing bugs in launchpad.
>>>>
>>>> Essentially three choices
>>>>
>>>>  1. Move all the open bugs to gitlab
>>>>  2. Move some relevant bugs to gitlab, but close outdated ones
>>>>  3. Leave existing launchpad bugs but don't allow new ones filed
>>>
>>> I think we could set most (outdated) bugs simply to "incomplete" with a
>>> message saying that the reporter should open a new bug on Gitlab if
>>> necessary. Then after 60 days, the "incomplete" bugs will expire (i.e.
>>> auto-close).
>>
>> Some users hide their email on launchpad, so we would be hard to simply
>> re-import their bug on gitlab. Now if you ask them to import it, it is
>> easier. 60 days seem enough to react.
>>
>> Something that always bugged me on launchpad is you can not Cc other
>> people on a bug if they don't have a launchpad account. I haven't
>> checked if GitLab allows that (Bugzilla does).
> 
> GitLab doesn't expose anyone's email address. Any interaction with other
> users is exclusively via their GitLab user name. So yes, you need an
> account to be added to notifications for an issue.
> 
>> We should do some experiments first, because I saw various ways to use
>> the GitLab ticket tags, and none convinced me it is practical.
> 
> Why is that ?  I find the tagging to be one of the things i really
> like coming over from the bugzilla world. It is useful for doing an
> initial triage of bugs in particular, to sort them into logical buckets.
> 
> I think that's particularly useful with our subsystem maintainer model,
> as it will let us direct bugs towards specific maintainers.
> 
> In libvirt we had some generic labels for all projects
> 
>   https://gitlab.com/groups/libvirt/-/labels
> 
> And then further project specific labels
> 
>   https://gitlab.com/libvirt/libvirt/-/labels

Excellent, this is exactly what we need, so I'm not worried anymore :)

> 
>> Should anyone add any tag? Should we restrict to a set of useful tags?
> 
> I believe only admins can define the tags, you can't add arbitrary
> tags to a project as a user.

We are good then (users can still suggest pertinent tags in when opening
an issue).

> 
>> I suppose tags are hints to maintainers, so keeping something similar to
>> the MAINTAINERS file separation could be useful.
> 
> Regards,
> Daniel
> 


