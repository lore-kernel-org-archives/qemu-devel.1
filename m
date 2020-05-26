Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3971DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC62820787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAgsE6tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC62820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdVwq-0004EJ-6g
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdVw7-0003i5-TO
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:31:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20141
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdVw6-0003Qj-K9
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590485509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O+E221KnaOSRRKvFIiWIca+iSBbjUivuXvHamMsOHMo=;
 b=OAgsE6tvwzjdqkvgAwOmyB78MNdzdOLrSONItDLN2gQv5N06ZFTuJ4Tv11bIw3hv+4v4Mi
 FMMqkqzfCBQmZaOAVL9XxZAwu+pCZ/K5CmHiB8iAhUXN+4TA4Z8z3ZcEo2x/ACvve9W2Tb
 8wdtujhSPl32Be5/gaIwH9dXQVbba5w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-J-aF7WpDO5GIIlCnr8ubdQ-1; Tue, 26 May 2020 05:31:47 -0400
X-MC-Unique: J-aF7WpDO5GIIlCnr8ubdQ-1
Received: by mail-ej1-f71.google.com with SMTP id hj12so572623ejb.13
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 02:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=O+E221KnaOSRRKvFIiWIca+iSBbjUivuXvHamMsOHMo=;
 b=J/qpyBbI4rAbozCQ1BnGbjYkGr+vUF9bFD+I2EZoXCYo5FYuryu9Vcs7WmiFigRTNM
 TvrR9aElN5XAUnoaStO1Lb504sWV7fSi+JMyvqcD5LG9qIT1wDLPCrg0IFNFKa5ixAf6
 vlmq40Ov20aKKpalppKS1gcAGRarjLrGKEa3kG0RpCDXtEnIsfXs8gDx6FyoLn7mD6iS
 C0W4SYXHLm2Ngc1rfgxs/30a/7Y30erbPyFkAoaD5YIMf1krciFOPTq/XtrgAzrQWB1V
 y/o1v/DIvcJxF9FLUznqkHb2vkE0KYF7FHsY5Pfq5a9KX+pU5xdw0Uc4ZEo21yoSOymV
 JBmg==
X-Gm-Message-State: AOAM5304BQXouQ3kfaJLdxVXIuQ/cghHI+xu6bcAObaprQyRxJdbd0/R
 Jc35aejFwIz+wlPxgeH7sHxtk1zVPQMzaPC/poTWweWVRUeJNDF8YXTDTDvca220HNFZ5xdGY6U
 pUMusoyuM+0FBxew=
X-Received: by 2002:a17:906:b2c1:: with SMTP id
 cf1mr335016ejb.135.1590485506325; 
 Tue, 26 May 2020 02:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/n/UQ985AhRDswwjtdZeFLxntvyaP7Pj+d6irfzJKreOygF91x8j69x+wR6/ROiKCkf41ow==
X-Received: by 2002:a17:906:b2c1:: with SMTP id
 cf1mr334987ejb.135.1590485506080; 
 Tue, 26 May 2020 02:31:46 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id u26sm17014278eje.35.2020.05.26.02.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 02:31:45 -0700 (PDT)
Subject: Re: [PATCH v3 4/9] qapi/misc: Restrict balloon-related commands to
 machine code
To: Markus Armbruster <armbru@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
 <20200525150640.30879-5-philmd@redhat.com>
 <87eer787tr.fsf@dusky.pond.sub.org>
 <7e926561-c2c3-e815-8518-b283db7c60fd@redhat.com>
 <87mu5v3w3t.fsf@dusky.pond.sub.org>
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
Message-ID: <7fb7564d-23cc-28b8-bf5f-a80797c518ec@redhat.com>
Date: Tue, 26 May 2020 11:31:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87mu5v3w3t.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Laurent

On 5/26/20 11:04 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 5/26/20 9:38 AM, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>
>>> A brief note on why restricting "to machine code" is useful would be
>>> nice.  Same for the other patches.
>>>
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>
>>
>> What about this?
>>
>> "QEMU can do system-mode and user-mode emulation.
>> Only system mode emulate a machine.
>> Remove this feature from the user-mode emulation."
> 
> Is is a feature of user-mode emulation before the patch?  Or is it just
> dead code?
> 
> Hint: QMP commands tend to be dead code when the program doesn't expose
> a QMP monitor :)

Maybe a 'corollary' question, "How user-mode users use QMP?"


