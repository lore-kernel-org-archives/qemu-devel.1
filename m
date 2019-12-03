Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F361AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B6D2073C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoOeBunj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B6D2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from [::1] (port=55534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icAfh-0006c5-S9
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 11:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1icAWb-0002eA-T2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1icAWS-0002LL-W2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:55:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57845
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1icAWS-00026v-Jy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575388529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mj+7N6lpeGvHNflQt3MnyFasmRG156/84fI9GvVFRt4=;
 b=VoOeBunjd7RNQ9WvlZpLT3hHSvg2f/sTatbN8Uj5Dn6pZQ3zEGaTvD5nWwN3wUC7mbSSUz
 rh7xSbqL6oOKI8dQMlis9v0TQ8W6n5ngrBKUJ6+PdKkCm7XkBDLeuKYubUiNPXeL9eVtH1
 OVtzsIDNROCFrwm6lj0TWQdAlxkeLfc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-fxMzvH6AMUe3obDIwcfXvA-1; Tue, 03 Dec 2019 10:55:28 -0500
X-MC-Unique: fxMzvH6AMUe3obDIwcfXvA-1
Received: by mail-wr1-f71.google.com with SMTP id h30so2008677wrh.5
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 07:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=2u1fFr+7nbDZoXZkg2jwvS1uhtaLClJtvuVPI1eGyyQ=;
 b=n6595jnFdW5O2NkM3jFuiZWLVrHvRxZUs1R/u4KsBWfPn4as9umOW8blPN1IQNY89C
 lG7uSY6jaWGBvql6mZCRSHmYxUpAcna00pQMel0t/K0rMfW5hkL38H7LL6e+9r0+qaVd
 GKgPrdODJw0XyMWrTh2bUynWC/aB19L9gvN0Yv5azeoFZdix+nLYZd9c25DZ+OqyqMgz
 8dAyWxoK4PnWLQUU5ACXjmev2S9VFl1FQ1YVnYwp6djqSRjZpkLHq53Okks2YWWL8vFQ
 cV0BmTK0XENL7nn6cb6SJQRhTBmOfNCfuiYL0QQDJWErVXfoTLJ6uNFFIpfJuEEe2KdS
 k9eg==
X-Gm-Message-State: APjAAAUru/hIxI6AptMTfxPh5KyJFxR35Cq/szUy965J7CdfDfVnW+pw
 nsg/x9kHNP7ssBwBwVpYbfmZwux8Xhz/mT7jGJw2DBNjmJbI9NDuQ1C5zohWICpesLLHoVoF3Rv
 h+woM6h22Ta5VyGA=
X-Received: by 2002:a1c:39c4:: with SMTP id g187mr37312399wma.78.1575388527103; 
 Tue, 03 Dec 2019 07:55:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoy0CXUzMzd89pwtURaFmWkVRLx4rhMG1DfQolxrfulpCHSSDtMlRWoPz6zT0qaOOoPpeLIg==
X-Received: by 2002:a1c:39c4:: with SMTP id g187mr37312387wma.78.1575388526870; 
 Tue, 03 Dec 2019 07:55:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id r63sm2829147wma.2.2019.12.03.07.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 07:55:25 -0800 (PST)
Subject: Re: [PATCH v2 05/15] stubs: add stubs for io_uring interface
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20191025160444.31632-1-stefanha@redhat.com>
 <20191025160444.31632-6-stefanha@redhat.com>
 <20191111111347.GC7297@linux.fritz.box>
 <20191203111600.GA167235@stefanha-x1.localdomain>
 <20191203142845.GE5637@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df85b405-c2a8-bfa0-b4b8-d50b40869332@redhat.com>
Date: Tue, 3 Dec 2019 16:55:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203142845.GE5637@linux.fritz.box>
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KPkxyLXD7nrnRO1IwIWxR9204NQRUJdOI"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KPkxyLXD7nrnRO1IwIWxR9204NQRUJdOI
Content-Type: multipart/mixed; boundary="UdBxt8IoOVuM6Oyala99KSEwz5Ko4H3vh"

--UdBxt8IoOVuM6Oyala99KSEwz5Ko4H3vh
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/12/19 15:28, Kevin Wolf wrote:
>> * It's possible to argue against this and personally I'm not that
>> convinced by stubs for this scenario.  But io_uring.o should be
>> consistent with how things work today with linux-aio.o.  If you feel
>> strongly against having stubs then the linux-aio.o stubs should also be
>> removed (see commit c2b38b277a788).
> I don't really like having block-specific things like Linux AIO or
> io_uring in util/async.c, but given that they have per-AioContext state,
> it's not clearly wrong either.

A good reason to have AioContext in util/async.c is that nowadays Linux
supports poll() via the AioContext ring too, and that would allow doing
busy polling of network sockets.

Paolo


--UdBxt8IoOVuM6Oyala99KSEwz5Ko4H3vh--

--KPkxyLXD7nrnRO1IwIWxR9204NQRUJdOI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl3mhWsACgkQv/vSX3jH
roMrsgf+PGvt/z5nqP6WkysJz/wxZ97tGorj2WV6ewFPkWJxPLaxlUrTELVIUkvH
6Sv4fipI/gRkOhGUjvRzQ4pa9grCt8FKaB/qXdrhOGjG3fzhwfe+h2LYXKWAS/+N
gjoRWs1bZ5CGjNzbAVL4x1B01C0cFITfu98CRGKCsYPTtu8N7EJ5JCJsSHG87mzI
Bir1BiLxzaHFuKMGUE7CNz+UbtmHiPZMY1JFDi2oDI6dnVxUaln/4kE/tY+KDrWL
MwK0A99uhxryK0AAQ2NrzuQSWLvz02s9h3f5CUwnxCPWUOgYwqYIai4Dn5tPs/6W
s3+HEKu3AQRBXbBep4yVZeuKsXJA3g==
=ixiP
-----END PGP SIGNATURE-----

--KPkxyLXD7nrnRO1IwIWxR9204NQRUJdOI--


