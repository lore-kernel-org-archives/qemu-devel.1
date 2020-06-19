Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2762080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVvKoQgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2762080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIkX-0003md-O0
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmIjm-00030Z-PW
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:15:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20463
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmIjj-0000cE-O9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592579723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rYbuyMJ+5VOKybU3CNqoYfLyK+Tr+M/60gTEXuVbHQQ=;
 b=CVvKoQgr7oFqRsns+y1GkkerJYMORI03opQUyr2LMC4NUhcyKQk/rh9t2XZ1YpGcfW0E4X
 9s8V6CvCp02bKqAAs8SvsILFRTSuOSiIaZrXMAb1v+yI/W4Yks7WEOYeBwbPnzznrKXsnJ
 JYZmqE9/9aYpTXRouVw0iAufz8llPjM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-Z-_95wIxPV-Y-UFTRam_9Q-1; Fri, 19 Jun 2020 11:15:20 -0400
X-MC-Unique: Z-_95wIxPV-Y-UFTRam_9Q-1
Received: by mail-wr1-f70.google.com with SMTP id f5so4368241wrv.22
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rYbuyMJ+5VOKybU3CNqoYfLyK+Tr+M/60gTEXuVbHQQ=;
 b=JnYF/gvGCReTbrek9gO703LkEcxTw1fEUI0n41L4uV5/k8Yc1IHK69kh0WPFovWc1B
 RxO882onTaT58TI0eUOq25M77RRTK5j/KvFxbxJiKMs5BSsytYA5KBHWDRibshbgU4I5
 mc/n2JqbjjAVhU8gKkyA/TqaKZWoduO8FQ6vdY5nsxmEChkL3KSafaH8o/bIxHnmXoMo
 fUr+JtxOQJhDVjNi7CdPgHCHnQ+rKegNjmJUx6REOsGt09n/2B5gS+gBOuYYohinA2BY
 DjjBakdeofw/HF0jc291UjZ8wd8ozLjWmZU4O6E0JN5z/WMm0pPtIRWHwG7XSiRn1TcU
 PWCg==
X-Gm-Message-State: AOAM530EQCjnaP11410Kx+WapxfOC/t4ZhCEHqi9ALKv2OrxPHTYYPFN
 t5EPfDDBp5FxQrNzVWqVmkY+z+5TO1wMsdyAWtqGL+kC7+x7aNQN3GxdobXCSD0U5HK1z8Zioft
 nWiBFhxUsaL/BEPg=
X-Received: by 2002:adf:e401:: with SMTP id g1mr2524971wrm.57.1592579719166;
 Fri, 19 Jun 2020 08:15:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCM5b10oLf52LXQWJ7CTjdNzltUuB5v/ef7FQTfYA9XW22xtmMgCxCdEQtmbOQho8xACIc5Q==
X-Received: by 2002:adf:e401:: with SMTP id g1mr2524939wrm.57.1592579718950;
 Fri, 19 Jun 2020 08:15:18 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id q4sm6932758wmc.1.2020.06.19.08.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 08:15:18 -0700 (PDT)
Subject: Re: [PATCH 0/7] python: create installable package
To: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200617195241.GA434320@localhost.localdomain>
 <32791435-4aa4-7eaa-e2c6-b53165f2e28d@redhat.com>
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
Message-ID: <8e91bf40-34a2-91c2-6cd2-4dbf58dec8cf@redhat.com>
Date: Fri, 19 Jun 2020 17:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <32791435-4aa4-7eaa-e2c6-b53165f2e28d@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 10:27 PM, John Snow wrote:
> 
> 
> On 6/17/20 3:52 PM, Cleber Rosa wrote:
>> On Tue, Jun 02, 2020 at 08:15:16PM -0400, John Snow wrote:
[...]
>> Are you proposing that we have, say, "python-qemu" version 10, being
>> the 10th API version, without any regard to the QEMU version
>> supported?  Or version 10.5.3 would mean 10th API version, intended
>> to support QEMU 5.3?
>>
> 
> I am proposing only that we use semver to track the API version of the
> SDK itself.
> 
> So that could be:
> 
> A) 1.x, 2.x, 3.x (etc) with absolutely no connection to the intended
> QEMU support version. It either works or it doesn't. It might not work
> very spectacularly. Major semver bumps indicate a breaking change to the
> library API.

Major changes occurs between QEMU releases. If there is no QEMU release,
it is pointless to release the python-qemu package, right?

> 
> B) 1.5.0.0, 1.5.1.0, 1.5.2.0 (etc) where the major version still
> describes the API, but the remainder of the version describes the
> intended target QEMU.
> 
> Or, we could do:
> 
> C) 5.0.0, 5.1.0, 5.2.0, etc. where it tracks the QEMU version verbatim,
> end of story.

At least it KISS.

> 
> I don't like (C) very much, because it violates some prevailing idioms
> about python package versioning. A or B seem better, but do run us into
> potential trouble with people having mismatched versions.

Which is why I prefer (C).

> 
> I'd take A or B. (B) is a little chatty but gives some good information
> and allows you to pin versions effectively, so I think I'm leaning
> towards that one right now.
> 
> Well, whatever we do right now, I think I do really want to make sure we
> are publishing under 0.x to really give the illustration that we are NOT
> promising even the illusion of stability right now.


