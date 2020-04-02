Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F134BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 21:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6A220719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 21:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUX6Cjga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6A220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK7Zt-00008r-Pc
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 17:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jK7Z1-0007jZ-AS
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jK7Z0-0000fO-5o
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:39:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jK7Z0-0000en-2h
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585863589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RxtPlEXlcaqYBxg2eIAiSh0pgnLGNrMETIvIu2cV6A=;
 b=TUX6CjgaMr8p/2T+BEB5hpqUQGe4LrIg7w10mqUMBVzxal3ud1bl3ZkiggIT+tWuT0acWF
 Yw35q1WGu9g6RGT1HZouVfWp05CDFdDgMUydzWUn5ouP1dn8h58PI006+7R+uJtqLATHKb
 y0dx8ik5NgIKhXe59u5alLeMsVYmJ+A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-bxJBRn1OO6C_HikMkFX8gA-1; Thu, 02 Apr 2020 17:39:42 -0400
X-MC-Unique: bxJBRn1OO6C_HikMkFX8gA-1
Received: by mail-wr1-f70.google.com with SMTP id j12so2029253wrr.18
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 14:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FyipcZIYUNRe6GAqKKoOZyJtkWs4AFhOBTa9X+9XkJ8=;
 b=L5rjFY9/e4ysLUPEOZ3ha6Nv4/4WDjulgSNXdW5WZ7rt0sohi18XG5ZGky3Di46tRQ
 qOWYTHoV4g0bn4mi7KWT4ecuI1g+id3Y2l1gw4wqAdjeWXK3B80gDFExZM0G0E55a6Uc
 KIsdub6DXzQcRieNPPhj13A2VWfumQGaGGBIHyu+yCXGVJ24wF8SWUc4WxVT5m2EbKcb
 amIM73bZYnMldSVJkjPt/BY+u/Vweq4fEkZCVNkiK3NeVLv2NuS35ESc5Y+dVuC7x50o
 IaW5J4CsinBmYoOyB2Vt/+HDTDnu7frYqyqpHmcx1FzNcjtsILIltyS/Ut4i0MhD+uat
 7Isw==
X-Gm-Message-State: AGi0PuaILdgk6enX1foe3hNO6wWrQJy+fNl67ufnEflaFK592EDXi7gP
 xRO39GNyxdDntIbziwNgGXQ1ZHrbcTl/cU/8YjBL7myZq2OBX7VdqoVGYqN1n2jQau8aLxMd6Z8
 7Knqyd97hgEQJzSk=
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr5799881wrl.201.1585863581694; 
 Thu, 02 Apr 2020 14:39:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ6t7UKcKf0I9CnK3u1NAifn1pK8xAXVx1G3La2M64cwPthK/6eGcuQlqrD0kackVEQo288PA==
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr5799868wrl.201.1585863581470; 
 Thu, 02 Apr 2020 14:39:41 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s66sm9016438wme.40.2020.04.02.14.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 14:39:40 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
 <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1007053b-0f31-c459-2199-07d62ae36427@redhat.com>
Date: Thu, 2 Apr 2020 23:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
Content-Language: en-US
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jiri Gaisler <jiri@gaisler.se>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On 3/31/20 6:18 PM, Richard Henderson wrote:
> On 3/31/20 3:50 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> This test was written/tested around beginning of 2019, but was
>> extracted from a bigger series and posted end of June 2019 [*].
>> Unfortunately I did not notice commit 162abf1a8 was merged by
>> then, which implements the AHB and APB plug and play devices.
>>
[...]
>=20
> Thanks!
>=20
> Reviewed-by: Richard Henderson <richard.hendersion@linaro.org>
> Tested-by: Richard Henderson <richard.hendersion@linaro.org>

While queuing this I noticed a change in your email.

Since you replied to Alex patch later [*] with your usual email:
Richard Henderson <richard.henderson@linaro.org>
I think it was a typo, so I fixed it.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg694068.html

Regards,

Phil.


