Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC57C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB56F207D0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoiFQPgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB56F207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh87r-0005Ft-5a
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 04:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh87E-0004id-V6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:54:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh87D-0004D6-Cf
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591347253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5nK92y1lDU/Ry7JMnpqW5tTEMd08lN+ayGP2T+rlNWY=;
 b=WoiFQPggWQLzKnLbnGBdItkxWroMyVweUmjuRvqXotba6g7MY9igqZ5UW44F/4hrO8hdlw
 BhcVm6aDUerHEjg7vZMB9CYmu2JVKEd2BxPqlARsQHhUBce9ViUZl+p3658lSSz8gd6/51
 nKQ1QWZgfMTXKfL0EJFCCyIbd0yn+vE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-6yZ2F1S-OASSGO1B5L4RXQ-1; Fri, 05 Jun 2020 04:54:12 -0400
X-MC-Unique: 6yZ2F1S-OASSGO1B5L4RXQ-1
Received: by mail-wm1-f71.google.com with SMTP id l2so2515352wmi.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 01:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5nK92y1lDU/Ry7JMnpqW5tTEMd08lN+ayGP2T+rlNWY=;
 b=T/+RZrGf3PQyviM6awUk7UOeFJGSY8FTNNq6VqeAxwsuekyZeTNGky4iFM1HlIgjd8
 JOUC+442xD1STbC//iiC6q12zKOYXOHHl7JnVVF5uuQqDm6Qvh85/qz6X3AJPg/r4dFm
 k8ZiBiRV52GbA6tR94RpaBwPlKca0uFhENqcTQrRLgtXsG9qiyU7PrSMXNmxntR386jC
 MeAW86v0w7cP35icbF3QzeJth0v/VEOA6Q6AEqCxoonfMrHmZZ92t6qjtG1ht8T6QTrR
 Eny6fgFqzhdVY9iKUBaSII26R4LYSceHnBGv8/eJIRUfDGHpribc4qd4tDGFyFKeP0aX
 opdg==
X-Gm-Message-State: AOAM532YwZRJJLZZQi3KkF8JZLHd0Gp/KZlT1d9Zkhsz2qI8VQP3zqlH
 OjXRc0BEodCiLSchv+5GgqVe7nBqirPWM6uqZkQwnnRJj0RPssMTIQ3XieSa/ikwIejhrmtnTZT
 pco/TqVsz6k1XqjY=
X-Received: by 2002:a1c:658a:: with SMTP id z132mr1623630wmb.20.1591347251267; 
 Fri, 05 Jun 2020 01:54:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkkiYPBVt6pSp3u5fMcJTFLD7sruWJoS72WKzz2nMViyDUIYXFb8EVP/f1fXW5VOnOZE96FA==
X-Received: by 2002:a1c:658a:: with SMTP id z132mr1623611wmb.20.1591347251096; 
 Fri, 05 Jun 2020 01:54:11 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z2sm10909463wrs.87.2020.06.05.01.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 01:54:10 -0700 (PDT)
Subject: Re: [PATCH v4] osdep: Make MIN/MAX evaluate arguments only once
To: David Edmondson <dme@dme.org>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20200604215236.2798244-1-eblake@redhat.com>
 <m2eeqtapix.fsf@dme.org>
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
Message-ID: <be4d75b5-b545-0802-cbe7-0bb8d352d6b2@redhat.com>
Date: Fri, 5 Jun 2020 10:54:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <m2eeqtapix.fsf@dme.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 crosthwaite.peter@gmail.com, quintela@redhat.com, dgilbert@redhat.com,
 Max Reitz <mreitz@redhat.com>, kraxel@redhat.com, dirty.ice.hu@gmail.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 10:24 AM, David Edmondson wrote:
> On Thursday, 2020-06-04 at 16:52:36 -05, Eric Blake wrote:
> 
>>  /* Minimum function that returns zero only iff both values are zero.
> 
> Not your change, but "only" is unnecessary here (or iff -> if).

Maybe we should teach checkpatch.pl to refuse the idiomatic 'iff',
it is already hard enough for non-native English to read (or write)
technical documentation...


