Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB852C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9B7206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CipoqE5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B7206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbem-0004gF-Qh
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbe5-00049B-4A
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:37:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44462
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbdB-0008Mp-0U
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590507399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JPO71FoTWCLpPIX+ZA5F7U9WacQLiJFlUZVUjR2Yp3M=;
 b=CipoqE5SIoFGKvzxbe0sY0Q3YbQuiUSskd4Iu9W6MM52QHlkMp3tgEw4ehgbQW67sGg/Gl
 Z9B0tGLzUR8KKQvq17yLusBR2NCb4w4LfMuaR+ys8KfNFQM+BhNJZvIpH3TnQk5BWaOaLT
 UZkFoIKESy1lNd9KRI2oaRPDKzsgZ/8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-90mcQRgyMXiCi83mAJb6pw-1; Tue, 26 May 2020 11:36:38 -0400
X-MC-Unique: 90mcQRgyMXiCi83mAJb6pw-1
Received: by mail-ed1-f69.google.com with SMTP id x11so9092375edj.21
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JPO71FoTWCLpPIX+ZA5F7U9WacQLiJFlUZVUjR2Yp3M=;
 b=KSVZfKQAWwSCQrfvUGhscQwZXhV26AsJaFQJZ8kUWgUGYA07j+vqgwGj4/Mkc123IC
 NkV0vix1fDoIHcDIYanr+DBavZvsHvL9oAnnCGuU5+8FcB4JFEnC4sdNk7pTI3uzTgWs
 z8hFCb2npK1mXmglKoTwktqV/di9Hx8DYsil1WfJMjMRRncQ2JuG5LdAMOIUHHzV+QNR
 smkMmawwAVBsjMuuETdIN7H6N0R65pxV3EvY9T2exh61hn5tsyZ6zTNduRLZSfGnAJIa
 yoJAogQHvUghA3kl8/Z49GrSPc6lOxtGdDTNtqnSJ4/edr3DSUmbmMkDYpFZs7Q3jM54
 wT+w==
X-Gm-Message-State: AOAM532AIr7Gfo4q/BsEUNcR9+YP+daPHnX55lq9M0uEbrYZJ7/luGKd
 MDSfa7LZTbJEXFvb41E/pP+goZBiNbEtct+ckgF0opjG7yUw9OSY4o3RHn0PZG61ROlvCKgyUpM
 s/HfKnvJ9hPfSTfc=
X-Received: by 2002:a17:906:934e:: with SMTP id
 p14mr1624032ejw.502.1590507397235; 
 Tue, 26 May 2020 08:36:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycfUPt/QE1+XG2hf1PQXMEgdEXc/I8oblFi28xvze5/zcD45JvrUlbCtu2eCm6g0DW0cpypg==
X-Received: by 2002:a17:906:934e:: with SMTP id
 p14mr1624001ejw.502.1590507397021; 
 Tue, 26 May 2020 08:36:37 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id bf15sm209651edb.46.2020.05.26.08.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:36:36 -0700 (PDT)
Subject: Re: [PATCH v3 4/9] qapi/misc: Restrict balloon-related commands to
 machine code
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
 <20200525150640.30879-5-philmd@redhat.com>
 <87eer787tr.fsf@dusky.pond.sub.org>
 <7e926561-c2c3-e815-8518-b283db7c60fd@redhat.com>
 <87mu5v3w3t.fsf@dusky.pond.sub.org>
 <7fb7564d-23cc-28b8-bf5f-a80797c518ec@redhat.com>
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
Message-ID: <67d74bcb-ac60-a6f7-e485-7e419dbf50dc@redhat.com>
Date: Tue, 26 May 2020 17:36:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7fb7564d-23cc-28b8-bf5f-a80797c518ec@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/26/20 11:31 AM, Philippe Mathieu-Daudé wrote:
> +Laurent
> 
> On 5/26/20 11:04 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>
>>> On 5/26/20 9:38 AM, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>
>>>> A brief note on why restricting "to machine code" is useful would be
>>>> nice.  Same for the other patches.
>>>>
>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>
>>>
>>> What about this?
>>>
>>> "QEMU can do system-mode and user-mode emulation.
>>> Only system mode emulate a machine.
>>> Remove this feature from the user-mode emulation."
>>
>> Is is a feature of user-mode emulation before the patch?  Or is it just
>> dead code?
>>
>> Hint: QMP commands tend to be dead code when the program doesn't expose
>> a QMP monitor :)
> 
> Maybe a 'corollary' question, "How user-mode users use QMP?"
> 

I can't find a way to start a user-mode process with a QMP socket, is
there one?


