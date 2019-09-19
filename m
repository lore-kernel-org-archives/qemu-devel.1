Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF00C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4A521907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4A521907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAuIH-0001A7-QE
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAuB9-0003UG-3b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAuB7-00060S-O0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:00:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAuB7-000608-H0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:00:49 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6E8AC057E9F
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 11:00:48 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id f10so1409562wmh.8
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/IT+7IerED1OsSsPApCiaJuyRU3U6AZWX35uS/tYjPA=;
 b=VTxFZsfmMiKH+KtnOoRmKBvxQ+pSExjPhG8b0SIlxJG1ZycWwKAzPe5TeFUWk/pZGO
 il2OT5apWfwj301+WW2Wq4tfpqGufZDt/szkyPGyNA9IQ4GGeoVShfGGZja4N8XrAbFC
 h5xGXBbLk3R05S7YMiuaJ01N8LAakBCLYLSES3t/onwRvoEduFDv9B/u14i1C4PogGiD
 mPes/OqfUY/iNvkZ0FECwHi/hLbzv+wH9hNdopUs9rjSI/Wp+/ZyCiCvKu6M4PidStvI
 /PS65waXCEeBzjAIomBnhrFhZgneKY6xOhSF9BCgtsz2teL1hDWtWRo5PbRryMj64I8V
 r6Tg==
X-Gm-Message-State: APjAAAUAdLyWOfwYL2NhunXnXkcIheQcGe1tlIFBeX0tUSgf3vw3kTKp
 EpKsppUUekvCTCVw84jLw/0G5fxPLpHJPdM7DKGzaL5kVmcUDqB+9XWc+SBS3xqwXu+NiOrZZrW
 NUO9thbpOhb/kugU=
X-Received: by 2002:a1c:e916:: with SMTP id q22mr2369893wmc.15.1568890847415; 
 Thu, 19 Sep 2019 04:00:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwrWmc+KcQCepVB6IR6XY1PSxsjJ33gcqbBxqhrL7n3TMU19RE+FP/CG1dwsnAm9Vjb2CS0DQ==
X-Received: by 2002:a1c:e916:: with SMTP id q22mr2369877wmc.15.1568890847236; 
 Thu, 19 Sep 2019 04:00:47 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b144sm8237533wmb.3.2019.09.19.04.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 04:00:46 -0700 (PDT)
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20190919104907.18005-1-philmd@redhat.com>
 <641b9c18-c9b7-d557-94aa-8690f9c04766@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <84a8bb5a-e80d-35e6-73f1-6014ef88cf48@redhat.com>
Date: Thu, 19 Sep 2019 13:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <641b9c18-c9b7-d557-94aa-8690f9c04766@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] util/qemu-option: Document the
 get_opt_value() function
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 12:58 PM, Damien Hedde wrote:
> Hi Philippe,
>=20
> On 9/19/19 12:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Coverity noticed commit 950c4e6c94 introduced a dereference before
>> null check in get_opt_value (CID1391003):
>>
>>   In get_opt_value: All paths that lead to this null pointer
>>   comparison already dereference the pointer earlier (CWE-476)
>>
>> We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
>> 0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
>> for the 'value' parameter".
>>
>> Since this function is publicly exposed, it risks new users to do
>> the same error again. Avoid that documenting the 'value' argument
>> must not be NULL.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  include/qemu/option.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/include/qemu/option.h b/include/qemu/option.h
>> index 844587cab3..141d6a883d 100644
>> --- a/include/qemu/option.h
>> +++ b/include/qemu/option.h
>> @@ -28,6 +28,18 @@
>> =20
>>  #include "qemu/queue.h"
>> =20
>> +/**
>> + * get_opt_value
>> + * @p: a pointer to the option name, delimited by commas
>> + * @value: a non-NULL pointer that will received the delimited option=
s
>> + *
>> + * The @value char pointer will be allocated and filled with
>> + * the delimited options.
>> + * It is an error to pass a non-NULL @value parameter.
>=20
> You mean "a NULL @value" I suppose (not a non-NULL).

Oops... Thanks :)

>> + *
>> + * Returns the position of the comma delimiter/zero byte after the
>> + * option name in @p.
>> + */
>>  const char *get_opt_value(const char *p, char **value);
>> =20
>>  void parse_option_size(const char *name, const char *value,
>>
>=20
> --
> Damien
>=20

