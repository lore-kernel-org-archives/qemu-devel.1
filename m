Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9655C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA47A20748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErwxnScE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA47A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWFM-0002GD-TI
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isWEc-0001oY-Q1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isWEZ-0002PK-0o
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:20:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isWEY-0002OJ-HV
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579285237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YNDYC9FA7o+/y27WLZf2NpWMg8YDtsn7f1Bt3pfZJRE=;
 b=ErwxnScEKds/EgK1eYf8u5wnBTzQbXBl2paLihjhYIMAM0SY1NuJJ71kIa4vr+TXoseAEY
 kizBNmQZn+UWy66qPv/VegffjrpK7/A/0EevctIBcb0AP48Srkn/sLIggMjJ+dDkrPhbP+
 oHw0pDvCwJ4NJCtn5LQ/e+zRrbPOuM4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-I7caYlEDNemC2yZtvEwZNw-1; Fri, 17 Jan 2020 13:20:35 -0500
Received: by mail-wr1-f71.google.com with SMTP id y7so10871438wrm.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/7sZxFASlxP6N35izqnlqfH2FE8gpvo1uvTH9UvtGp0=;
 b=RvbMWWTf0S8vzEn6E9gYiiCUPHjm+XblV0IsvTEx7Zoj/64gciu3G7nqAY394oWq7r
 u4zyLcBy3iz8FwGKQB6stih0vSVpMz+h9yOdtPbO+qH+f4XHAcf///beWjJzBBpnak6a
 AnAYm2DSMWg2sD0Eaj0TKt1PWprlMe0NW816ytaAv8lZYbCIQ252eqUV6BpH5bkBcDru
 ArkpnPXgYZSulCMxscYeOQb0E11ZskJwm9patF43clN8/bkVIiRBXwxFTlD4stkVg6/r
 wgUdGCenMhsFt8O0YlgjZPZmf7aXxR+tTwdMYLL8rb3bHQoi3GfINLnsaobbY3bwNXHO
 WrSA==
X-Gm-Message-State: APjAAAUnNFBFEoYJTgX1UWri4cARP6F9bFMurcahIjsdxaKMZeyEeLms
 8q4azIySRceYKlkaMTPyyAsn2n9bmsEdZdg1VKrLsRhqkltnqGgFofNTYCUpb/FWs5gvXGCbBuc
 I/j0VMcxoR20hZl8=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr4413625wrw.126.1579285234609; 
 Fri, 17 Jan 2020 10:20:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIdcEKr+uq/1nejpm4Pg4fA63bnQJW+2WYlOL0oPdEoRUiB91nZKmV2w620Xpq9XJzMdNjBQ==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr4413606wrw.126.1579285234340; 
 Fri, 17 Jan 2020 10:20:34 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u14sm34451118wrm.51.2020.01.17.10.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 10:20:33 -0800 (PST)
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200117015322.12953-1-richard.henderson@linaro.org>
 <7b14c840-0d3f-0c67-06be-81b058c727fb@gmx.de>
 <08c4bdcb-b07d-eb30-a38d-f27ed6400952@redhat.com>
 <57d3bd1a-0597-8353-46bd-09dd93347f7b@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55a08a64-79ee-48f3-e19b-4f0c2380b09f@redhat.com>
Date: Fri, 17 Jan 2020 19:20:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <57d3bd1a-0597-8353-46bd-09dd93347f7b@linaro.org>
Content-Language: en-US
X-MC-Unique: I7caYlEDNemC2yZtvEwZNw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: dave.anglin@bell.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 6:30 PM, Richard Henderson wrote:
> On 1/17/20 6:13 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> -=C2=A0=C2=A0=C2=A0 MemOp mop =3D MO_TEUL | MO_ALIGN_16 | a->size;
>>>> +=C2=A0=C2=A0=C2=A0 MemOp mop =3D MO_TE | MO_ALIGN | a->size;
>>
>>
>> Hmmm you changed MO_TEUL -> MO_TE, so from MO_32 to MO_8.
>>
>> Per your description, shouldn't this be MO_TEUL | MO_ALIGN_4?
>=20
> The "UL" part is also being added by a->size.  This code was written this=
 way
> in preparation for the 64-bit ldc, and the bug was not noticable because =
we
> don't have that yet.

Ah I missed the a->size.

So on 32-bit the hw trap doesn't trap on unaligned 16, but traps on=20
unaligned 4.

On 64-bit we don't know yet, but IIUC we expect to not trap on unaligned 8.

Looking at target/hppa/insns.decode:

&ldst           t b x disp sp m scale size

@ldstx          ...... b:5 x:5 sp:2 scale:1 ....... m:1 t:5     &ldst disp=
=3D0
@ldim5          ...... b:5 ..... sp:2 ......... t:5     \
                 &ldst disp=3D%im5_16 x=3D0 scale=3D0 m=3D%ma_to_m

ldc             000011 ..... ..... .. . 1 -- 0111      ......   @ldim5=20
size=3D2
ldc             000011 ..... ..... .. . 0 -- 0111      ......   @ldstx=20
size=3D2

We have a->size =3D 2 =3D MO_32 =3D MO_UL.

So do you plan to add LDCD from PA2.0 using size=3D3, OK.

 From "exec/memop.h":

      * MO_ALIGN supposes the alignment size is the size of a memory access=
.
      *
      * There are three options:
      * - unaligned access permitted (MO_UNALN).
      * - an alignment to the size of an access (MO_ALIGN);

Ah so with LDCW we already access a word, so MO_ALIGN -> MO_ALIGN_4.

With LDLD we'll have MO_ALIGN -> MO_ALIGN_8.

Now "MemOp mop =3D MO_TE | MO_ALIGN | a->size;" makes sense!

The power of your decodetree script amazed me again :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


