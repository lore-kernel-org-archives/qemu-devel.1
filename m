Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23305C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4720C2222E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="TknTdCnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4720C2222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4m9-0002ZY-5r
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kT4d9-0000NS-FS
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:53:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kT4d7-0002B6-Ad
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:53:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id y12so3855570wrp.6
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lcOd8MEoGRbl7O4xZ9qEYTz1er7n6lFOWrdbLE/Njt4=;
 b=TknTdCndK8rBpGvDFcRB3sRepn5UlSUz71aMLYJyUPk8lwG9RQ8N8N8dvdMt7a9s0v
 JuI8zmIKLEF/HOmhml5d0ZcSgSNNlP0twB+rdYapv5ns5SyGACCxtbsst8TEqxOqfvkK
 SN1Np+Zgcy7AoyVxAeDA81LSWJFbJ6TXyAwNta508xqNHpMkqXJzXfCE4r2G92N1pqDE
 L6Uz+kKe2m4P59GvLiyiwasl22FczxgYXzTYFPAI8FlMRJUMpjpBVO8OWzW+q6VwfVqD
 MeIEDHBI8sbjzZlqSTSCsRVWcRppnIIy1lSNZPhjqZqe5TJemo6+Xr4gktdtBjJ2PQ9e
 m/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lcOd8MEoGRbl7O4xZ9qEYTz1er7n6lFOWrdbLE/Njt4=;
 b=fQDTWbvhujwTDoZgSnt7LvvuwE8lUkNukbQAgOsqXpI7gXOXETyoedj48lBoJn2PMG
 3SMh3OKkaNM6P4gp+4oKZvPBmdRj6PU9wwYfDh92eno1czDVrE5gn393ZYAnZLL3MbRr
 yel0tUiqazZZ05FTRSPXMNDj3vGy0vljuNeN1dhrwfuRQPPw4/8QfxjalR5Etw65c/E1
 4f60liyeZ+J+/2yTSnBq6n1dXqkx+FI17IuI6E+W/C8fWj0sGsxsJrEkO53LH2a8ToFL
 6Y1Kb1GPMhP/coXWngvRKx93t1IVuepy9mkmb3Y7Aupbs+Y381KvMxVsj2yY3AhNyTg9
 cpmw==
X-Gm-Message-State: AOAM532EJ++dVhi64j5UM4epd8LujkIsn9bhmHle4BPtxrvhxAYfAfVa
 WM/fUv9c5ucT9y4KzhtMfv43t38DL/ggqFuifyZlX/sQ3Ldc3g==
X-Google-Smtp-Source: ABdhPJyH93qiPSCfQN9ieT0s1Z/JabvIFijPahFjXzjp8k4T0jfR9ztYL5ViICJ9404yc1VoWDximSQb0IRYsAhKAME=
X-Received: by 2002:adf:de89:: with SMTP id w9mr4792034wrl.212.1602773599191; 
 Thu, 15 Oct 2020 07:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200921093325.25617-1-ani@anisinha.ca>
 <CAARzgwz34NDJV40PpEcxCwptJdOfU0u=k5fpZ8JX60Q4_LS7Sg@mail.gmail.com>
In-Reply-To: <CAARzgwz34NDJV40PpEcxCwptJdOfU0u=k5fpZ8JX60Q4_LS7Sg@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 15 Oct 2020 20:23:07 +0530
Message-ID: <CAARzgwx2ZaeazjpT-GPse5-7+KJN5DJKh2eh971M00S5egUCdw@mail.gmail.com>
Subject: Re: [PATCH v3] qom: code hardening - have bound checking while
 looping with integer value
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping ...

On Mon, Oct 12, 2020 at 8:08 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> Request to queue this patch for the next pull.
>
> On Mon, Sep 21, 2020 at 15:03 Ani Sinha <ani@anisinha.ca> wrote:
>>
>> Object property insertion code iterates over an integer to get an unused
>> index that can be used as an unique name for an object property. This lo=
op
>> increments the integer value indefinitely. Although very unlikely, this =
can
>> still cause an integer overflow.
>> In this change, we fix the above code by checking against INT16_MAX and =
making
>> sure that the interger index does not overflow beyond that value. If no
>> available index is found, the code would cause an assertion failure. Thi=
s
>> assertion failure is necessary because the callers of the function do no=
t check
>> the return value for NULL.
>>
>> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>  qom/object.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> changelog:
>> v1: initial version
>> v2: change INT_MAX to INT16_MAX in code
>> v3: make the same change in commit log. Sorry for missing it.
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index 387efb25eb..9962874598 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -1166,11 +1166,11 @@ object_property_try_add(Object *obj, const char =
*name, const char *type,
>>
>>      if (name_len >=3D 3 && !memcmp(name + name_len - 3, "[*]", 4)) {
>>          int i;
>> -        ObjectProperty *ret;
>> +        ObjectProperty *ret =3D NULL;
>>          char *name_no_array =3D g_strdup(name);
>>
>>          name_no_array[name_len - 3] =3D '\0';
>> -        for (i =3D 0; ; ++i) {
>> +        for (i =3D 0; i < INT16_MAX; ++i) {
>>              char *full_name =3D g_strdup_printf("%s[%d]", name_no_array=
, i);
>>
>>              ret =3D object_property_try_add(obj, full_name, type, get, =
set,
>> @@ -1181,6 +1181,7 @@ object_property_try_add(Object *obj, const char *n=
ame, const char *type,
>>              }
>>          }
>>          g_free(name_no_array);
>> +        assert(ret);
>>          return ret;
>>      }
>>
>> --
>> 2.17.1
>>

