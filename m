Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A2BC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD17206B2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGkpeuGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD17206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKG9D-00080h-0S
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 03:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKG8G-0007a8-Oh
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKG8E-0000Sd-FH
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600672860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rCKT4t5+Y8aKYKVijnp26wh4irvur1ihrxHX/mNkQSo=;
 b=FGkpeuGJdoY/V3eUm2YPqh7gHUJILIPufjrP6PiZ74U8IKD5W1neED81u7dLmy6eJa72li
 aLnQ9JPSzolqRgHVw29NWSf4O6lXxixz7Wi3vEHyAmU/EuQkVwW7VMnvcpvfcKzr2ZT/Qu
 tP0NKM6cBRagcJ5dWmQ5Eoefgi4qR2E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-A8ORS0s7MP6qamUy3Uu00g-1; Mon, 21 Sep 2020 03:20:58 -0400
X-MC-Unique: A8ORS0s7MP6qamUy3Uu00g-1
Received: by mail-wm1-f70.google.com with SMTP id a7so3395695wmc.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 00:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rCKT4t5+Y8aKYKVijnp26wh4irvur1ihrxHX/mNkQSo=;
 b=bc2DH+jxjd9HVxX0jmi39scc5hssAP4gsQqbt+CSnd1ROKAkQZOGmAC4jxDv7SGxmj
 c6Umus7MxPtWEcCm5NoEso+5iL6On9AkJ2lcuJtXxo4/kFQjoYlM9bceHuIgbDfb9OK/
 U3E5n6XoH4Jm32Oadd5p0wWVrwAUQmIOPe1pvLG+QRd3YG1b/B67vAyUA8RurZB+d6jB
 FPiRvkhk7MEYLkXE81qpQydou3HHwK/N61Gr57dWK+Aki+1snSAt5ZM0xtFz8iKbrqSf
 bRMF3J7v58f/OaMyBdNRxvT2COkTc1h5+nYpq43mpKe9lncHriVzOwpnhmfMAP8Pqe6b
 c2YA==
X-Gm-Message-State: AOAM530kamPUmFDj/vS7korxKgs5StyeddXD7xC0AN1bNVIz5/+9V5fj
 q6q6JpJKiVtUALRgZSntJwII0f0Z+zth8rAmCgQkbepNsCwdbFbDUIcJQ/1wukjYRDooT3p/gao
 sannOz/PLiPRfT9s=
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr29113903wrp.390.1600672857530; 
 Mon, 21 Sep 2020 00:20:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw32nNv6uKiqpAs+mPNnqp7oAGOu6H2GdVVRj3vT8tunf1mPoiWzRJjLSwBqsULCbapBa8JzQ==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr29113879wrp.390.1600672857334; 
 Mon, 21 Sep 2020 00:20:57 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f14sm19205205wme.22.2020.09.21.00.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 00:20:56 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Reverse debugging
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <160006358590.31457.16757371597343007847.stgit@pasha-ThinkPad-X280>
 <ad338011-6abf-7833-6553-cf724b4fb23d@redhat.com>
 <81870ddb-5bde-898c-fdb8-a2770ccafa4a@ispras.ru>
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
Message-ID: <beddf4c3-87df-eee1-3ec3-ff8848dd8124@redhat.com>
Date: Mon, 21 Sep 2020 09:20:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <81870ddb-5bde-898c-fdb8-a2770ccafa4a@ispras.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, alex.bennee@linaro.org, zhiwei_liu@c-sky.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 8:48 AM, Pavel Dovgalyuk wrote:
> On 20.09.2020 10:58, Paolo Bonzini wrote:
>> On 14/09/20 08:06, Pavel Dovgalyuk wrote:
>>> GDB remote protocol supports reverse debugging of the targets.
>>> It includes 'reverse step' and 'reverse continue' operations.
>>> The first one finds the previous step of the execution,
>>> and the second one is intended to stop at the last breakpoint that
>>> would happen when the program is executed normally.
>>>
>>> Reverse debugging is possible in the replay mode, when at least
>>> one snapshot was created at the record or replay phase.
>>> QEMU can use these snapshots for travelling back in time with GDB.
>>
>> I had queued this, it is a very nice patch series.  Unfortunately, the
>> tests failed on gitlab:
>>
>> https://gitlab.com/bonzini/qemu/-/jobs/745795080
> 
> There are other tests that were disabled on gitlab for the unknown reason.
> 
> https://patchwork.kernel.org/patch/11636515/

Unrelated.

> https://patchwork.kernel.org/patch/11701681/
> 
> The latter is related to machine_rx_gdbsim.py

Unrelated, 'gdbsim' is the name of the machine. It is not
using the gdbstub/gdb protocol.

> Could it be the same avocado/python/etc issue with socket interaction?

Yes, likely...

The kludge is to simply add (with an explanation if possible):

  @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')

> 
> 
> Pavel Dovgalyuk
> 
> 


