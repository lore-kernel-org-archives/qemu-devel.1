Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C899C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D107E222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvUs/rqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D107E222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irTr5-0003Pc-VV
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 16:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irTqK-0002iE-NC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irTqI-0007ZF-Me
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:35:20 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irTqI-0007Y9-Cq
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:35:18 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so13714353wrw.8
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=D1BqpD8tQRg2mwZVE7s/nwNGKlZklm2ZGc78sQBV7VE=;
 b=XvUs/rqxRtMFxkF366Xdi7XVnTdnQcMLx03TTeAvB/OuN10iEob6lIJ0VsH3Njkj8J
 ekQnE13nkYwK6Xl5n8CJVgWTSYbiZkSCAYiLf/gS1F+u3CEyRu3GEZczEeNsaKNPPjDL
 gFz52QFpyMrlep6qzNnJNBisjuTEjwvECumvS9HqVH5fDiCm5ul3zFRh/BX4Qq93s1mq
 CUwesHmk1hj+j0MR2h65wUK/aUR6PSJ6hpAHi2IGBcFbu3pirWz3hoJY93YLCbtfraad
 9PIQ4MvMnsPxwk9iC0/tiNKgjSAJj3Nvbz0pjD+7tanFAWk50moDMB8CaoJSM3vrwrIQ
 lBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=D1BqpD8tQRg2mwZVE7s/nwNGKlZklm2ZGc78sQBV7VE=;
 b=pfjtuX78rJlcp5Y1xglj3avjFoGr3aq9e3ev7FR1SJLgn1T1gBGhd6IYdQ8dRyZ/4v
 NVeHm4mu+KZscQomoTbMk3K3oJPTmwQDZB+YxNRl1uwXeY2rxx6GbLWqJXy8v7whpaY9
 qXwV3qAYC+CWG1KQsgb5S4peEE9hSYVSJSrWS3WqFf5Cf0wgzLj4BgwYDjP8D+9iw5mA
 uGtNBQ4e9f8eHrrwGFYvIUDQ1OaZ8mvoNIEv4gajNn6E6OKbnqPSacSTdvBeRkB8GDwg
 5z65P8VwgzSFaJwFBgAHP/ZmYXdkPy3i76JR/Bbht9zbrcJe5SnIcSMEqqajXLS8Y8r0
 boWw==
X-Gm-Message-State: APjAAAVGnzUU6bNLAyA1ShuHJwvRyPE6rco8I22clC4H3EzMFQe4+gqN
 Cie3/1aXog2Rt5j0Qax2GNTNsQ==
X-Google-Smtp-Source: APXvYqzWflLjwpyUJDAhwpKsssTDHT9z0vTbwLjZduh/Ix9muu/nJsoI/XF6SA/jpm7UplicwnUzdg==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr27325434wre.156.1579037717084; 
 Tue, 14 Jan 2020 13:35:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c5sm21309319wmb.9.2020.01.14.13.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 13:35:15 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3BCA81FF87;
 Tue, 14 Jan 2020 21:35:15 +0000 (GMT)
References: <20200114145437.28382-1-berto@igalia.com>
 <87blr5nc6z.fsf@linaro.org>
 <b9059159-9d86-fbb6-71a1-51b1dfc3aab7@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] qcow2: Use a GString in report_unsupported_feature()
In-reply-to: <b9059159-9d86-fbb6-71a1-51b1dfc3aab7@redhat.com>
Date: Tue, 14 Jan 2020 21:35:15 +0000
Message-ID: <878sm9n2lo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 1/14/20 7:08 PM, Alex Benn=C3=A9e wrote:
>> Alberto Garcia <berto@igalia.com> writes:
>>=20
>>> This is a bit more efficient than having to allocate and free memory
>>> for each item.
>>>
>>> The default size (60) is enough for all the existing incompatible
>>> features.
>>>
>>> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>   block/qcow2.c | 24 ++++++++++++------------
>>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index cef9d72b3a..ecf6827420 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -453,16 +453,15 @@ static void cleanup_unknown_header_ext(BlockDrive=
rState *bs)
>>>   static void report_unsupported_feature(Error **errp, Qcow2Feature *ta=
ble,
>>>                                          uint64_t mask)
>>>   {
>>> -    char *features =3D g_strdup("");
>>> -    char *old;
>>> +    GString *features =3D g_string_sized_new(60);
>>         g_autoptr(GString) features =3D g_string_sized_new(60);
>> will save you the clean-up later.
>
> Does this work with g_string_free() too?

It does:

static inline void g_autoptr_cleanup_gstring_free (GString *string)
{
        if (string)
           g_string_free (string, TRUE);
}

If you want to keep the allocated string but drop the GString you are
still best doing that yourself.

>
>>>         while (table && table->name[0] !=3D '\0') {
>>>           if (table->type =3D=3D QCOW2_FEAT_TYPE_INCOMPATIBLE) {
>>>               if (mask & (1ULL << table->bit)) {
>>> -                old =3D features;
>>> -                features =3D g_strdup_printf("%s%s%.46s", old, *old ? =
", " : "",
>>> -                                           table->name);
>>> -                g_free(old);
>>> +                if (features->len > 0) {
>>> +                    g_string_append(features, ", ");
>>> +                }
>>> +                g_string_append_printf(features, "%.46s",
>>>       table->name);
>> We have a number of cases of this sort of idiom in the code base. I
>> wonder if it calls for a utility function:
>>         qemu_append_with_sep(features, ", ", "%.46s", table->name)
>
> Good idea for https://wiki.qemu.org/Contribute/BiteSizedTasks
>
>> Anyway not mandatory for this patch so with the autoptr fix:
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>>>                   mask &=3D ~(1ULL << table->bit);
>>>               }
>>>           }
>>> @@ -470,14 +469,15 @@ static void report_unsupported_feature(Error **er=
rp, Qcow2Feature *table,
>>>       }
>>>         if (mask) {
>>> -        old =3D features;
>>> -        features =3D g_strdup_printf("%s%sUnknown incompatible feature=
: %" PRIx64,
>>> -                                   old, *old ? ", " : "", mask);
>>> -        g_free(old);
>>> +        if (features->len > 0) {
>>> +            g_string_append(features, ", ");
>>> +        }
>>> +        g_string_append_printf(features,
>>> +                               "Unknown incompatible feature: %" PRIx6=
4, mask);
>>>       }
>>>   -    error_setg(errp, "Unsupported qcow2 feature(s): %s",
>>> features);
>>> -    g_free(features);
>>> +    error_setg(errp, "Unsupported qcow2 feature(s): %s", features->str=
);
>>> +    g_string_free(features, TRUE);
>>>   }
>>>     /*
>>=20


--=20
Alex Benn=C3=A9e

