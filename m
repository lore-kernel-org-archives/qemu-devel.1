Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139A3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F3520772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWP74WJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F3520772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqv1P-0007qh-3C
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 04:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqv0K-0007Em-8q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:55:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqv0H-0000lg-PC
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593680132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vpen+ZvudtNCHVaWv6qDCEMGRK2/5c9mtGbHmge+f10=;
 b=DWP74WJULnWImhO3UvvXn3DX0O6jBvLX/owToVoEKPddFvjrtWqYzL/ux6S4KGI+WxQBt+
 87mPBqFdqhPoruzW2yOsodUoD9EEroMvEwJIUzz3Py0sRpu/rVKamgvS8ZRUvPK2e6/Y0P
 L1pXD4srymhb9abd89F0SIn1Wz2JSSo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-Apn3wFvEOVi9Skzq2WA24A-1; Thu, 02 Jul 2020 04:55:30 -0400
X-MC-Unique: Apn3wFvEOVi9Skzq2WA24A-1
Received: by mail-ej1-f71.google.com with SMTP id do21so19834711ejc.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 01:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Vpen+ZvudtNCHVaWv6qDCEMGRK2/5c9mtGbHmge+f10=;
 b=ELyFCMa18xYOX7DjhTqixeFIaAP+50Cnfj2a1exrJZccRxurV7JXdykai1L6Fm6Anh
 8NTuYL//J51U/BBufIHy1F6QXEcwlifDgk+8BJ1hjRD5zBd/9xuh1P2ULiimHhprgQDB
 rp93ymtD5ZQgHYigHE94YcPK8mZyF8x441kZPjnOBPenx1aWORVUYzKyieqa6GsulLzc
 jxmx1B/EMtboCOdn9U5kWDpWjZ1hF1dFjQdd47s7vGTkeIRRQkETWBlqzjUnW/QA2Vl4
 qw+e2Nr4RbPAVvWMeIefI/gNz2VAh8fwhtBetk0LOsuq+zNNxfe+02kRFm5jutTSq1KQ
 kvOA==
X-Gm-Message-State: AOAM532U9hrZKjyt/BZx89RjfsTbebWUJ/PDNRhHBElsi7Qorv79jroZ
 gQeiod3K9mEJ2BwGt1C+Ez8FQRuUYvE8iWFvmm7iWhw0nK8Kn2BAXV0ambOrNRo9Lsso2jgi6xt
 NSdPXt5K4lM7NmkQ=
X-Received: by 2002:a05:6402:742:: with SMTP id
 p2mr14466950edy.135.1593680129294; 
 Thu, 02 Jul 2020 01:55:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2Szhqh7XnXwH335qcdVEPaCyUmQtev0l+z+0I64jAh3AmGBhW/PSaLpoczt8+Bjoh6cjIjA==
X-Received: by 2002:a05:6402:742:: with SMTP id
 p2mr14466937edy.135.1593680129112; 
 Thu, 02 Jul 2020 01:55:29 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u1sm9200930edl.17.2020.07.02.01.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 01:55:28 -0700 (PDT)
Subject: Re: [PATCH 4/5] GitLab Gating CI: introduce pipeline-status contrib
 script
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-5-crosa@redhat.com>
 <20200618114524.GA677518@redhat.com>
 <20200622142056.GA791811@localhost.localdomain>
 <20200623175908.GA955618@localhost.localdomain>
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
Message-ID: <80fe3598-6a72-40aa-218a-0fbdea4e8a81@redhat.com>
Date: Thu, 2 Jul 2020 10:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623175908.GA955618@localhost.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Erik Skultety <eskultet@redhat.com>, Wainer Moschetta <wmoschet@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 7:59 PM, Cleber Rosa wrote:
> On Mon, Jun 22, 2020 at 10:21:03AM -0400, Cleber Rosa wrote:
>>
>> The script should indeed work with the workflow you described.  I'll just
>> run a few tests, to make sure that are no caveats, and I'll let you and
>> Peter know about it.
>>
> 
> FIY, I've cherry-pick just the patch with the scripts (for no reason other
> than having some content) and pushed it to a different branch than staging:
> 
>   https://gitlab.com/cleber.gnu/qemuci/-/commits/exp/script_shared_runners
> 
> Then I ran:
> 
>   ./contrib/ci/scripts/gitlab-pipeline-status --wait --verbose -p 15173319 -c ef12b411985baab9071e5fab1851acdd07d9bec8
> 
> Which worked as expected.

Great news!

Can you respin as a new series with this as single patch, and
explanation in the cover about how to setup it? This is the last
piece missing for Peter to use the effort done by Alex/Daniel/Thomas
on the GitLab side :)

> BTW, the commit wouldn't be necessary if I
> was checking on a "staging" branch.  The pipeline triggered (and being
> waited on by the script is at):
> 
>    https://gitlab.com/cleber.gnu/qemuci/-/pipelines/159334485
> 
> So I believe it's now a matter of sorting out job the
> inclusion/exclusion aspects, that is, if we start with all/some of the
> current jobs and some or none of the jobs intended to run on the
> s390/aarch64/x86_64 (non-shared) runners.
> 
> Thanks,
> - Cleber.
> 


