Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776ECC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422122072A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmuP27kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422122072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9UmE-0006e6-DQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 09:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9UlR-0005vB-Qo
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9UlQ-0006Sj-2W
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:12:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9UlP-0006QY-RM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583331162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7srj8zEuTazIYxOYrJokLlRxWd2VZAqD00tlhx9owY=;
 b=CmuP27kzdlY6a/prT5HhyfRJ1sPF7PHKJj9FoBFne90zTi6Wv5O/GUXBYH0Mwkviwp8ZAA
 ZdOGpbN06Ni69FAJkkiKuc/5iUtVOb3v6hHMZ5uJCI7qOEdGGz1h46AyhCFZA7E1KoHJvQ
 MjpUjjSms/5NmCU5YQ4sVGreTAGq1tA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-LqEMEanJOkqtTss9M8XI9A-1; Wed, 04 Mar 2020 09:12:41 -0500
X-MC-Unique: LqEMEanJOkqtTss9M8XI9A-1
Received: by mail-ed1-f71.google.com with SMTP id x13so1678186eds.19
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 06:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lFyl0oWSIFawg9jU+3cT2APwSI/olxPL8/tc2lKxfMo=;
 b=aVJC8i1sYgms60J+bdNXYQhSpFKTlRk5cHfQ5DSdeKPc39z4Uv/unfpMdYWCo7uqnC
 12/mLETiRXTjd8WyPZEAEgtBc2S6mvGi/qjMAuzoTvmrAtXxkj+ndFGG2grHnvH7lVeD
 +tf/rJwift/pT4OGCt4ad8eE6jOdkRvuhSxEIsP7A+0isNzXCeakVJ3VZM5U6ZFWjCQP
 SWzdPP027prz6Erejw3ub2cwDuc9y33H2aPSTjrawdQz3D3t8LkkYqyiKtUJVsdUOxNz
 tyUGAb7q+pT64AoB34Qv5v+K4UVEfD+tMoUZo1oPtWB0M+2Kg0W7+K/7RxWG/Wvo4vPi
 og0Q==
X-Gm-Message-State: ANhLgQ14trJJ6OOLWMA0VEWVHY+EqfF6q6rLHZbiCFTK2zlr3Nqbo8fk
 YRE2DMd6Rtadss170KuPWMGAPQXbeJ54059F53LsiQdioYJiALqoERu3Ip6l/U1YcZusMJAyDEI
 0RhVHQyyDrnCH37I=
X-Received: by 2002:aa7:d98b:: with SMTP id u11mr3006960eds.318.1583331160251; 
 Wed, 04 Mar 2020 06:12:40 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuP55SvhASNjU9nGkyGp7u2t6tkxKJ0KuqmQr1ZP4GnrNsftDADFi9LO4DFGKJ7ZEB2x7Vnvw==
X-Received: by 2002:aa7:d98b:: with SMTP id u11mr3006903eds.318.1583331159941; 
 Wed, 04 Mar 2020 06:12:39 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id h21sm1070908ejq.83.2020.03.04.06.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 06:12:39 -0800 (PST)
Subject: Re: [PATCH 1/2] misc: Replace zero-length arrays with flexible array
 member (automatic)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200304005105.27454-1-philmd@redhat.com>
 <20200304005105.27454-2-philmd@redhat.com>
 <1e1a1491-15ca-29d4-8bd6-1bf14edb4ad5@redhat.com>
 <38b55649-b1cd-8891-5c13-ec4c6ef3ae5e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f1d4241c-e82e-53db-cc33-898890a0b070@redhat.com>
Date: Wed, 4 Mar 2020 15:12:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <38b55649-b1cd-8891-5c13-ec4c6ef3ae5e@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/4/20 2:44 PM, Paolo Bonzini wrote:
> On 04/03/20 14:12, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> hw/scsi/spapr_vscsi.c:69:29: error: field 'iu' with variable sized type
>> 'union viosrp_iu' not at the end of a struct or class is a GNU extension
>> [-Werror,-Wgnu-variable-sized-type-not-at-end]
>>  =C2=A0=C2=A0=C2=A0 union viosrp_iu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 iu;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^
>>
>> Yay we found a bug! Thanks Gustavo :)
>>
>> union srp_iu {
>>  =C2=A0=C2=A0=C2=A0 struct srp_login_req login_req;
>>  =C2=A0=C2=A0=C2=A0 struct srp_login_rsp login_rsp;
>>  =C2=A0=C2=A0=C2=A0 struct srp_login_rej login_rej;
>>  =C2=A0=C2=A0=C2=A0 struct srp_i_logout i_logout;
>>  =C2=A0=C2=A0=C2=A0 struct srp_t_logout t_logout;
>>  =C2=A0=C2=A0=C2=A0 struct srp_tsk_mgmt tsk_mgmt;
>>  =C2=A0=C2=A0=C2=A0 struct srp_cmd cmd;
>>  =C2=A0=C2=A0=C2=A0 struct srp_rsp rsp;
>>  =C2=A0=C2=A0=C2=A0 uint8_t reserved[SRP_MAX_IU_LEN];
>> };
>=20
> It's variable-sized but it's okay as long as the total size doesn't
> exceed SRP_MAX_IU_LEN.  So it's not a bug, but I agree it's a time bomb.
>   Moving the field last should work, but it would still be quite
> dangerous code.

Yeah I reached the same conclusion.

I'll send a fix for the dangerous code.
Do you want to drop this series, or only the change in 'struct srp_rsp'=20
(or in all hw/scsi/srp.h). Actually I guess it makes sense I move the=20
'hw/scsi/srp.h' changes with the series cleaning dangerous code.


