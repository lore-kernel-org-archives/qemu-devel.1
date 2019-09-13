Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA0C4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CD3208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD3208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jaO-0005ud-9c
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i8jZZ-0005LC-N2
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i8jZX-0007qu-TD
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i8jZW-0007mT-HM
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:17:03 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3C0381129
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 11:16:59 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n6so13487525wrm.20
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 04:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GjH2WQztwaGgNvja7krwQOca+Mxzs1RvACns3sLvH0c=;
 b=m+v20tYnYULePsDWZXX1HBvVq4LP+lTRR7YylrbLphFpjBj/cBjC5QHWkniekH0lEi
 VQQUx1RZeOFjlKBDx72CVnBm5suCmamM2vY6oCnacZlSVQSkoe9KGTaIe+cJaXxcDRgM
 eL0TzlMMtkHbeym5DBUgQ/7SHyGrH+YGBZEFc7O3kf5RIaEpVhj5mnjKmzO0RikTAsf8
 EM819v5a7sNxV3E84P0/zkeCGwHOHXB33YbGPKyO0w5BR309aLqDNfWO7HQeVdjbAnjr
 NCLTZ6jn7Hg4gcOAkDpXZl5IMPDylT1lOOcQGmrLUJz3t7XopvX8T+Wx9c+RHLXAXtY3
 WMGA==
X-Gm-Message-State: APjAAAXJ7C1kUq3wx/gX9vVoXU88DBZF7CjOeUyTsozHfZsJ/UqHkoci
 vvfi/v9Xzq0mG0g3zcNToZmPnTrswg09y1C6YZGozOim1v7vLbOxQfa+K5AvL2sJhLlQOgDSuAs
 0KgyDD1lnjhJIHAA=
X-Received: by 2002:adf:a357:: with SMTP id d23mr11412629wrb.18.1568373418658; 
 Fri, 13 Sep 2019 04:16:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbaES6FkWc9pdxWn5wPtQ09Qw5uzmNu4wkXgRfTT07msxaG+Tyg23ggFDs6cxRLNAeXe836Q==
X-Received: by 2002:adf:a357:: with SMTP id d23mr11412608wrb.18.1568373418381; 
 Fri, 13 Sep 2019 04:16:58 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e9sm2552635wme.3.2019.09.13.04.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2019 04:16:57 -0700 (PDT)
To: Sven Schnelle <svens@stackframe.org>
References: <20190913101714.29019-1-svens@stackframe.org>
 <20190913101714.29019-3-svens@stackframe.org>
 <01208241-04a5-0db6-f941-ff9cbc64440f@redhat.com>
 <20190913110800.GA10636@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <484ae730-4763-80f1-1453-4c9a3ef0f03e@redhat.com>
Date: Fri, 13 Sep 2019 13:16:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190913110800.GA10636@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] target/hppa: prevent trashing of
 temporary in do_depw_sar()
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 1:08 PM, Sven Schnelle wrote:
> Hi Philippe,
>=20
> On Fri, Sep 13, 2019 at 12:58:14PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi Sven,
>>
>> On 9/13/19 12:17 PM, Sven Schnelle wrote:
>>> nullify_over() calls brcond which destroys all temporaries.
>>>
>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>> ---
>>>  target/hppa/translate.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>>> index b12525d535..c1b2822f60 100644
>>> --- a/target/hppa/translate.c
>>> +++ b/target/hppa/translate.c
>>> @@ -3404,10 +3404,6 @@ static bool do_depw_sar(DisasContext *ctx, uns=
igned rt, unsigned c,
>>>      TCGv_reg mask, tmp, shift, dest;
>>>      unsigned msb =3D 1U << (len - 1);
>>> =20
>>> -    if (c) {
>>> -        nullify_over(ctx);
>>> -    }
>>> -
>>>      dest =3D dest_gpr(ctx, rt);
>>>      shift =3D tcg_temp_new();
>>>      tmp =3D tcg_temp_new();
>>> @@ -3440,11 +3436,17 @@ static bool do_depw_sar(DisasContext *ctx, un=
signed rt, unsigned c,
>>> =20
>>>  static bool trans_depw_sar(DisasContext *ctx, arg_depw_sar *a)
>>>  {
>>> +    if (a->c) {
>>> +        nullify_over(ctx);
>>> +    }
>>>      return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_gpr(ctx=
, a->r));
>>>  }
>>> =20
>>>  static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
>>>  {
>>> +    if (a->c) {
>>> +        nullify_over(ctx);
>>> +    }
>>
>> I don't see how this patch helps or change anything, isn't it the same=
?
>> You clean in the caller rather than the callee.
>=20
> The Problem is that load_gpr()/load_const() allocate a temporary, which
> gets destroyed in do_depw_sar() when nullify_over() is called. If we
> move the nullify_over() before doing the load_gpr()/load_const() this
> doesn't happen.

Ah! The 'val' argument... I missed that, thanks!

Maybe we can add a comment to make it clearer:

   if (a->c) {
       /*
        * nullify here to not free the load_gpr() arg before
        * calling depw_sar.
        */
       nullify_over(ctx);
   }
   return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_gpr(ctx, a->r=
));

(also in the other function).

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>>>      return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_const(c=
tx, a->i));
>>>  }
>>> =20
>>>
>=20
> Regards
> Sven
>=20

