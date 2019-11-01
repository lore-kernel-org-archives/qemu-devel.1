Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BBECA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 18:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1F421734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 18:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9/W8bL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1F421734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQbhT-0005ax-Ev
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 14:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQbgT-0004gp-AU
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 14:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQbgR-0007TW-2e
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 14:30:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQbgQ-0007Pi-V2
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 14:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572633001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sBIv+VSRGRVO/LOVtlHQhf9XmOlxh1Vq6etlbSSF1M=;
 b=P9/W8bL9hS94RmTIjWNYW6J1siuxw0wEBSvoaEfpNqQl5XJqtoRF3dlgz3YsC/OxRb0LAs
 lkMUM2JzYA+h1RJ3f62iMouo7PHGuYDrYAEjI+HPxd7oqJeNeCUvkmk21/VP+QRGdgQcEM
 YHXXNkRPUBc+OXleGVkv9aOGWum6DlA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-6XbZyROmNgq4xZjq5qAv1A-1; Fri, 01 Nov 2019 14:29:57 -0400
Received: by mail-wm1-f72.google.com with SMTP id g13so4434514wme.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 11:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SR49IsEGG2SIhgx22mvT/0dNRtuXAgzA/YvhwPf51Fk=;
 b=tjKhHs5X0zxipp8JiS7ZtaX/iOPJ2ets7zrAcjFFuNhGcZicBnfraJWQLxABQHR7AY
 6TXXBEDJGXmRmRDtOl2wWf1h2BX6zlj705JgeO1x8742oGOfFvMY/bmPkY01+qxFv/xd
 sixNFal9aGBoqVOFTUQBmLp7BgPyAoNLy3ixP17a+cCzLq4tN4RiYZ66v3qNTBJaCVxc
 g2RFJb10lrdY/7DOkSJd3JYQZtEDUsOhBU0+KdFIYeyZL/DQKcjof5XDT+7RL8qPAqI0
 2Dv9I24rY8istoCLeKxk3oEPFomTxEBP4iw/4zHjOTdiJWObs7gcUqJoYzESnp2/K9+l
 pTfA==
X-Gm-Message-State: APjAAAWHejjUqiUU6nCzjIXJo4R8zw/azIVeDWpFJFc1WhC8SKgGS64g
 QuDyoLmLjDr6MNxwoc/DgpRFv/33uloGFSw93IqN2QAtt5n5u2Z4mi1a6NEELTGvf8XYuJlHJyT
 TV+meihLJI1wAwfk=
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr11523615wru.159.1572632996736; 
 Fri, 01 Nov 2019 11:29:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxagAjZ77NNecTgOvJ1YX1BpksJMPPB02lSm0Tjqp1/7hBPeS3CflmjzJEyYkG1MhoYxybqZw==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr11523602wru.159.1572632996531; 
 Fri, 01 Nov 2019 11:29:56 -0700 (PDT)
Received: from [192.168.20.189] (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id w8sm9750379wrr.44.2019.11.01.11.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2019 11:29:55 -0700 (PDT)
Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2ae98ce7-7eed-90c5-f29d-5474904ac40c@redhat.com>
Date: Fri, 1 Nov 2019 19:29:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: 6XbZyROmNgq4xZjq5qAv1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Alessandro Di Federico <ale@rev.ng>, "nizzo@rev.ng" <nizzo@rev.ng>,
 =?UTF-8?Q?Niccol=c3=b2_Izzo?= <izzoniccolo@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Taylor,

On 10/25/19 6:26 PM, Taylor Simpson wrote:
> We would like inform the you that we will be doing a talk at the KVM=20
> Forum next week on QEMU for Qualcomm Hexagon.=A0 Alessandro Di Federico,=
=20
> Niccolo Izzo, and I have been working independently on implementations=20
> of the Hexagon target.=A0 We plan to merge the implementations, have a=20
> community review, and ultimately have Hexagon be an official target in=20
> QEMU.=A0 Our code is available at the links below.
>=20
> _https://github.com/revng/qemu-hexagon_
>=20
> _https://github.com/quic/qemu_
>=20
> If anyone has any feedback on the code as it stands today or guidance on=
=20
> how best to prepare it for review, please let us know.

Is your target the 'Hexagon Series 600', with documentation available here?
https://developer.qualcomm.com/software/hexagon-dsp-sdk/tools

Regards,

Phil.


