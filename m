Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21045C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D572072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej1sKJ6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D572072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVer4-0006R2-IK
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVeQh-0001V3-Mb
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVeQg-0001HB-KY
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:26:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37631
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVeQg-0001Gx-H4
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573835198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=bvwQ9arAzNdN+4ryciCsMR33vKFRQDJSKnZ8LfXIvFk=;
 b=Ej1sKJ6Rl6E89L7cZQ8mNixO5za+6Nqh9PI/JCisMDBUDbA9P87OjVAFVP6FhDh8NgY7ae
 vDtpgmqiU+L9QWgw2zTasg4xmbjN5hhLmINih8vmV1XCgxdS8QJZShq0aUGr3Ng4adbIWN
 EQ0aKRlcQwHRHEm3G6WMipsk1/2KCl8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-NDeD3ukpPK2rwzM2TvVHvw-1; Fri, 15 Nov 2019 11:26:35 -0500
Received: by mail-wr1-f72.google.com with SMTP id p4so7927544wrw.15
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 08:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wwKjFF72Lcx6n9ALLm/wuvSqnuU9nc75+tDwCCoXzlg=;
 b=egQhMpDGIlXPmeIG2VeM4n+u7BtRUFNd052Psy0W+8G1jkiZaYtHDOsEYQAOf6guLm
 qin9Q80ZyulQt3TeoPnIMK7bGvgPw7Sd2fNibqiIQn67XTcUZHQSAnx9IiPYOqtgUDDQ
 McGucYHJ05qLN5EhPsro+M56NKFTGdpRRYMrUl2N0yZnEsPzkCgnwYVtCOG+L7x/H8A3
 RtTm9u554aeSWqlYtwl7XL6vKcSA/HxW0AtftpznfgLrRfpWqcFXCUpvIjOic+0KUa7j
 RtgrsBXlpuvM2ckWp4CUnOYMc9eQxNHEeaIcrADP7OaF4Puq5ojSpUJC7a/zcWYtG88D
 yQCQ==
X-Gm-Message-State: APjAAAU7dqSHaYENx5MRUnLkdceWyBsWvuCVv6x322/UEDX7E9ktSLir
 fDBpGqC7IOmY3sE8N4x5f4zRaXxvlmwaifW2mJwHeEm1H7dxwnhEtazBj4SNSjnAYyTtI8Yg6U+
 /IpGloUR8UtviI4s=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr5615313wrq.40.1573835194488;
 Fri, 15 Nov 2019 08:26:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZHgQkQN0tONg0zJ2lzz0fcuawEyIQH/qU2HnMX94L237axSyu9RPXpf+3mE82A0fOwJe8Lg==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr5615284wrq.40.1573835194149;
 Fri, 15 Nov 2019 08:26:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id r2sm11901923wrp.64.2019.11.15.08.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2019 08:26:33 -0800 (PST)
Subject: Re: [PATCH 2/2] docs/microvm.rst: add instructions for shutting down
 the guest
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191115161338.42864-1-slp@redhat.com>
 <20191115161338.42864-3-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <43713428-7f0d-aaf0-cd66-fad9ebd5e5cb@redhat.com>
Date: Fri, 15 Nov 2019 17:26:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115161338.42864-3-slp@redhat.com>
Content-Language: en-US
X-MC-Unique: NDeD3ukpPK2rwzM2TvVHvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/11/19 17:13, Sergio Lopez wrote:
> Add a new section explaining the particularities of the microvm
> machine type for triggering a guest-initiated shut down.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  docs/microvm.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/docs/microvm.rst b/docs/microvm.rst
> index 4cf84746b9..fcf41fc1f6 100644
> --- a/docs/microvm.rst
> +++ b/docs/microvm.rst
> @@ -106,3 +106,24 @@ disabled::
>       -device virtio-blk-device,drive=3Dtest \
>       -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>       -device virtio-net-device,netdev=3Dtap0
> +
> +
> +Triggering a guest-initiated shut down
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +As the microvm machine type includes just a small set of system
> +devices, some x86 mechanisms for rebooting or shutting down the
> +system, like sending a key sequence to the keyboard or writing to an
> +ACPI register, doesn't have any effect in the VM.
> +
> +The recommended way to trigger a guest-initiated shut down is by
> +generating a ``triple-fault``, which will cause the VM to initiate a
> +reboot. Additionally, if the ``-no-reboot`` argument is present in the
> +command line, QEMU will detect this event and terminate its own
> +execution gracefully.
> +
> +Linux does support this mechanism, but by default will only be used
> +after other options have been tried and failed, causing the reboot to
> +be delayed by a small number of seconds. It's possible to instruct it
> +to try the triple-fault mechanism first, by adding ``reboot=3Dt`` to the
> +kernel's command line.
>=20

Queued, thanks.

Paolo


