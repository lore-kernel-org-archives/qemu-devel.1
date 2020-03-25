Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A246CC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687A4206F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuYJAlvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687A4206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHCt8-0005LI-KG
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 16:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jHCs8-00049X-KR
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jHCs7-0005ZB-LX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:43:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41881)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jHCs7-0005Z5-I6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585169011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVABMqgro/8J18xyVRjpC7BUClaPwlpLpRYAP31ijU0=;
 b=AuYJAlvDZAXUQANxaFQSZq4kfoKoW5PjxBzf1n6NXtfwRnrJZAl1UkyypE6zcYzx6VMjv9
 kt4V1G4zTMXYJBFTchwITZuCU6qeHwlXtJSt8DIUuzO9g+4lUGs8WuUBZE9axFZ/dBC1/t
 jJppiNtZQznfwweb/JeJCnx4KL+mgbw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-_zPt275eOAi-7TKTOhQP2Q-1; Wed, 25 Mar 2020 16:43:23 -0400
X-MC-Unique: _zPt275eOAi-7TKTOhQP2Q-1
Received: by mail-ed1-f71.google.com with SMTP id x1so3134879edv.14
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 13:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RBe1K8MQ2M04ZfmtUogC0PJ68rNSUWjEDHmfKrXit24=;
 b=D3d7xnA/MkXH3i2bmLww4dXpJo/NLLhU+pzmiysIxSdtgzbXRD3SiVz8FE3TwBDQFU
 xfSDwlGwl62aXmBSdUJXxmo3EZy/8u+h63epKiwuRxVgSFrNtcPMxAY9cu87Fn2W5W3q
 qbhEZ7e7mStoDwMK2SeSkW03UL09xwxbNjNf0PSM0PMy29tClt5w2KD9WHG9m3N45yva
 RXOh/G/H6Gl2y8l4r8liBV2N3vbdZcWPn1hT2lGgQSS3xXqAJpqqMIS1jT3txFO1ZAjM
 KaECiyffj1NkC8tIJ9MbB0RJ7YHZ5R1ZHshok022AWk2vRYSIhllzbpE+m2IN+yySZ2a
 bN2Q==
X-Gm-Message-State: ANhLgQ142Ey58nWydi7DgNaW94E+aX+eCFxJKwsxclGAOrTXkT2J1Ol0
 WnXJMmUuoxAtWw5d7Zp/fw8L4nuO/d1IjVH6fFahgUm+Atngp+Ou3P5Y1TvKROKEnDfPPttCzTS
 vaLKhH7UtifnC+AY=
X-Received: by 2002:a17:906:5045:: with SMTP id
 e5mr4922905ejk.325.1585169001863; 
 Wed, 25 Mar 2020 13:43:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vshrHgKEHueb77YondEHKZRJWPc4tdwZ5XvXCyoNO0MV/WFxL19zm5TZgTPKnDICW1pP9S3Gg==
X-Received: by 2002:a17:906:5045:: with SMTP id
 e5mr4922887ejk.325.1585169001574; 
 Wed, 25 Mar 2020 13:43:21 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id y62sm1077ede.5.2020.03.25.13.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 13:43:21 -0700 (PDT)
Subject: Re: [PATCH for-5.0 3/3] object-add: don't create return value if
 failed
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200325184723.2029630-1-marcandre.lureau@redhat.com>
 <20200325184723.2029630-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f514365d-38de-3d7a-c081-558566e84deb@redhat.com>
Date: Wed, 25 Mar 2020 21:43:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325184723.2029630-4-marcandre.lureau@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 7:47 PM, Marc-Andr=C3=A9 Lureau wrote:
> If object-add failed, no need to create a return value that may later
> be leaked.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   qom/qom-qmp-cmds.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 435193b036..6bd137ccbf 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -287,8 +287,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_data,=
 Error **errp)
>       visit_free(v);
>       if (obj) {
>           object_unref(obj);
> +        *ret_data =3D QOBJECT(qdict_new());
>       }
> -    *ret_data =3D QOBJECT(qdict_new());
>   }
>  =20
>   void qmp_object_del(const char *id, Error **errp)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


