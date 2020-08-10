Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D19C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68719206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6NlDCeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68719206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k557S-0001Uo-IT
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k556a-00012U-QK
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:32:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k556Y-0002XY-Eq
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597055552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IhQIJbGIk7psZT5W4r1nqFXg4LD4ZrEAYJOXSvREV34=;
 b=M6NlDCeSgkA6aWqYVIbDdA28kzyM9h6mVbi1SqhGXJ8thJLSMv+8f4SqRoDz+fozGc7CV7
 l+MWJ2Qk7r36IIP0LBj4B+slcqhUNcbd2wQ26kCL/quqruILeLi8sKd4kTXqoyA19e2uWH
 N9HGPiFaj0noGbf0FMqC+X6156mNfFY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-lBf9Ye8hMB63kyucSg2D1Q-1; Mon, 10 Aug 2020 06:32:30 -0400
X-MC-Unique: lBf9Ye8hMB63kyucSg2D1Q-1
Received: by mail-wr1-f71.google.com with SMTP id d6so4026359wrv.23
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 03:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IhQIJbGIk7psZT5W4r1nqFXg4LD4ZrEAYJOXSvREV34=;
 b=cQlNoCRKZoiLuY6n1mARgKVj3c6ozutEO6cVOrrr6Ow4HO8t1jVR5BGq6EpRWy446I
 katJvVvJhCU68+j2qaRc7OCkSQzJFzzF6c/TrecVatElGwvnmYF/nXOoQTNKmW+yHBeR
 liKecNZnduqb1w7oV9+nMA5t7GgLFt1Ux8NF4O8MCodXXsmYMjXji5LL4JOuUHRSmSS6
 aD0TZn8HKPLXqjOScQSFOP8eX1ganGi2I+O8+9OBLyX70/LLCqOvC3KfNEeQFhjv1DAC
 rIGjbOCUM0Z6+hcIzXIS1Lh+Fo0MH+dPX5ZKLLl46Qf47gNVu2oO1Cw1YREFkJ6P4yI5
 Pt8w==
X-Gm-Message-State: AOAM5332iCsX5DyLkc7wtNtk1Yw3iton/dsEcKMkeGxSpaAZPLW4Ixbx
 a16EZYWpm6NWVHe714ylcBKhwvcZ5EoeMA26TfzBKZr3GIS8fAaU6rZJjVs0ebedXBIFqIzgyaQ
 h7P8oOJtjBd0HJPw=
X-Received: by 2002:a05:600c:c7:: with SMTP id
 u7mr25770139wmm.135.1597055549132; 
 Mon, 10 Aug 2020 03:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVR3vI8LSm9KIHBC9ZdbxStaW9XGDL16bfkzqIWnhSV8lHK7q8h021sVvE0knyhDuAcpCTCw==
X-Received: by 2002:a05:600c:c7:: with SMTP id
 u7mr25770125wmm.135.1597055548962; 
 Mon, 10 Aug 2020 03:32:28 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v8sm21535714wmb.24.2020.08.10.03.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 03:32:28 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
 <9d7b7f59-ec3e-1f74-d1d4-359e3388f0f8@redhat.com>
 <87ft8yd0ht.fsf@dusky.pond.sub.org>
 <CAFEAcA8-qAh9RzAZNqFS9HphAEDuCVVGzZO7vKem-1WCJogyjw@mail.gmail.com>
 <f8cb36ff-a98a-9147-1c31-6f6394a4ec77@redhat.com>
 <20200807155824.GN120942@redhat.com>
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
Message-ID: <544746a8-1ac8-b12e-6890-1579b9e6ab3c@redhat.com>
Date: Mon, 10 Aug 2020 12:32:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200807155824.GN120942@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:06:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 5:58 PM, Daniel P. Berrangé wrote:
> On Fri, Aug 07, 2020 at 05:14:06PM +0200, Paolo Bonzini wrote:
>> That one exception, the one thing that disappoints me of the whole
>> conversion, is the trace.h files.  The current solution is one of the
>> first parts I did of the conversion and I have never touched it since; I
>> think it can be improved (I can even think of two ways to do it), but I
>> don't really have the time to do it now.  But even that bit is just
>> ugly, not unmaintainable, and I really see nothing in the conversion
>> that is a step back for QEMU's long term maintainability and our ability
>> to develop new features.
> 
> I was never entirely happy with the trace.h stuff even in "make".
> Trying to maintain the "trace.h" name for every generated header
> was probably a mistake in retrospect. it caused me so much pain
> trying to get the "make" rules correct so that we resolved the
> right trace.h in each case. I was deperately trying to avoid
> updating the #include lines, but I'm not sure it was worth
> it in the end. Would have been easier to just generate a unique
> header file name for each dir and update the #includes.

Never too late. Having unique trace headers would allow us to reuse
trace functions in different modules.

I.e.:
- hexdump()
- cases where multi-devices not well split in subsystem parts
  . xen out of i386
  . net could reuse mdio
  . rocker out of net
  . can out of net
  . reuse semihosting traces in target/
- cases with buses where the device is target-specific

> 
> Regards,
> Daniel
> 


