Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12873C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08AD2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXn8kvKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08AD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwLv-0005UB-V3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuwLM-0004xW-43
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuwLL-0001MS-2a
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:37:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47299
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuwLK-0001Le-VI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579862258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWOuboyoxa8QftgZfcKl6xF2AJTk56c63OEGp+yDjlQ=;
 b=hXn8kvKPleLZRjr7af/tynEUcXEEUg5V3LSVWgOC7zNuJ9L6DeuBMzZod+4kUn2/xsAou1
 +l8Hr5auJ7EHggLbUYVka/ZBBUe+dlabjkeBNJSzzNeHvCvSht7zytbjdDGDZA68oxQxy9
 rBAtHf4Bfq5Fhos8v1PniYDKiHYHpnk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-FPfMage-O8euliBgaoNuog-1; Fri, 24 Jan 2020 05:37:36 -0500
Received: by mail-wm1-f72.google.com with SMTP id b202so479731wmb.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NsRO/WuimR/M0aK+OudLIB1OER2zEAaKoIEePYYCFW4=;
 b=iEia22DJe8gY4fKHPY/2LbLQFpJZ0jtHkHmSkc5saNWK8nT4M3BLPwSbl2qYdqHM3P
 OWCLR9vPMWCdKP1al9IC3QqlShhYsLo4lk0Nr2WyE2+8c+zQbwETyDtVLCv+26UTnLZq
 Qy7YBrdpi1qB0Ywh/X0VdVUoj4/gs5G9FsRxtWv/4ONwWwkL0kmMzS0r8+QuDsmRufge
 oJN/SNJ9QlhvS2bjpW9i3IU2+ehFum7RnjrTVa+wqSfyAvkA2aOSXJSv8vVK4qs/1vMt
 IO5fZTrMSJQAL+DZ9WXwz7EXrFuEKQUa4HGyc5wRamnjORefcgidKPIdvf9Fb0Finx/2
 8tLg==
X-Gm-Message-State: APjAAAWvaMGuM6E4GrlceCMjtSHtqx9yNmKxO4tFSPTt/6H7ukLRrpT5
 nEUz+NaUFPzzIxcVHlfhmvkFAjeVg/rfbnxv3WdAI2ij1b7IYhK2yVcF9CynTjFTZo8NARFN+wd
 ydhHJQJ9zKQ1opAw=
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr3757546wrh.371.1579862255441; 
 Fri, 24 Jan 2020 02:37:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6rrDXzGMn8JPtjb4stqeevNFSEUNFDYHzgdc5XXLA//L973BAmMdlapDGh1uJj4n2bZXcUQ==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr3757487wrh.371.1579862255073; 
 Fri, 24 Jan 2020 02:37:35 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f12sm6318461wmf.28.2020.01.24.02.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 02:37:34 -0800 (PST)
Subject: Re: [PATCH v8 01/11] add device_legacy_reset function to prepare for
 reset api change
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
 <20200123132823.1117486-2-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <40a77809-275f-9f88-7ae6-fba90a1edd63@redhat.com>
Date: Fri, 24 Jan 2020 11:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200123132823.1117486-2-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: FPfMage-O8euliBgaoNuog-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, david@gibson.dropbear.id.au,
 ehabkost@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 edgari@xilinx.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 2:28 PM, Damien Hedde wrote:
> Provide a temporary device_legacy_reset function doing what
> device_reset does to prepare for the transition with Resettable
> API.
>=20
> All occurrence of device_reset in the code tree are also replaced
> by device_legacy_reset.
>=20
> The new resettable API has different prototype and semantics
> (resetting child buses as well as the specified device). Subsequent
> commits will make the changeover for each call site individually; once
> that is complete device_legacy_reset() will be removed.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


