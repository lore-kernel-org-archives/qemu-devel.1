Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69914C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B2D2399A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LA+aaUVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B2D2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKkXe-000815-1W
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 11:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKkTu-0006CB-Is
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKkTp-0001Jf-AT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600789518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5yJneTNOhDfKvpz+T1Z7KfAwiOqaoJfmYR/XphGE/M4=;
 b=LA+aaUVqO1yex5JJBfzP2nkX47FnVuEuuo3aN89YcftoEnWeFSS932T18LedfwXGL2SZIp
 YIfxgjoLYYTEgywgLJG3E6UzjrjCTrpmlFpbP+KxSQ6ta7P92RiWAxw/Eh1RyfzftNQpkA
 c/9Ps5jQ9dS/Z3vjgk81fNhRZkFy+Gw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-0Djgn-2IP6aWC1ijm8KZuA-1; Tue, 22 Sep 2020 11:45:16 -0400
X-MC-Unique: 0Djgn-2IP6aWC1ijm8KZuA-1
Received: by mail-wm1-f69.google.com with SMTP id l15so1053443wmh.9
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 08:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=myp5R80g4EA1V5MrCMXFck1gdaJElndzB6Cy3z501Kg=;
 b=jq4MohQld8Wk8V5/dQsH4M0hGTwtBVSX//mBAJ4XBEKKhw37IfuLuWLuYXOt3XcWHf
 WstCBAeSHpGOGgZGDcqQIsyDJO/LdttxZXWHg3SIp6mEUCJMRJU296lbrDwx2Z+Acs1/
 tbQv4YV9OZH4isOEhOjDRqpscN0wor9UcweNfT2tN5+A69X7BM/QzKSPXO6Sn2nm9pGx
 jVDYSMiWZXGdMcazZm1F3ZlX84lYlAWG0n1Klad8NHl5rXucd3Y8Sq3CqNVVEgMMX9rG
 S2asDbYqlhJ5SsYveX9BKjtcoLJs3tgbc1PR8pWzVksVrWvD9DjOKxjnpzgtJqoLFi+N
 LPgg==
X-Gm-Message-State: AOAM533EA+W+rtLDEL4S/ucbWUafRnl6p/xq40AUODuS+wXlVDokAGlR
 jPG/OKBInS7N7d1Oe3QJuSUBrcgoEeYf7Rw6g9l9hAt5njgIDBNbJpeFeVVydDHCGwp+kjhUffW
 O5LkQZTwJMxDH1Lc=
X-Received: by 2002:adf:f852:: with SMTP id d18mr6051099wrq.245.1600789514290; 
 Tue, 22 Sep 2020 08:45:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQEDrbMq3ypPTxPI+Opwgioz4BEo4o+6wRc9oNwTTB3bsT+6zueLOxZXUxWL3+pmDVE5q4Ag==
X-Received: by 2002:adf:f852:: with SMTP id d18mr6051082wrq.245.1600789514087; 
 Tue, 22 Sep 2020 08:45:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id l17sm5046112wme.11.2020.09.22.08.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 08:45:12 -0700 (PDT)
Subject: Re: [PATCH v2 01/20] configure: Detect libfuse
To: Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-2-mreitz@redhat.com>
 <0360f62c-9074-594d-8e12-b00166380513@redhat.com>
 <8b1640ee-2346-6989-046c-865566fcf216@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be2d8705-78af-3a72-1259-4ff0045bb9a0@redhat.com>
Date: Tue, 22 Sep 2020 17:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8b1640ee-2346-6989-046c-865566fcf216@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wHJU2oZYpzqwuXlywjH2k78i4vkqZRWU7"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wHJU2oZYpzqwuXlywjH2k78i4vkqZRWU7
Content-Type: multipart/mixed; boundary="yTpWkBMPCthPgcJJUOrBKItciXgnZhGP6"

--yTpWkBMPCthPgcJJUOrBKItciXgnZhGP6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22/09/20 17:37, Max Reitz wrote:
> On 22.09.20 13:14, Thomas Huth wrote:
>=20
> [...]
>=20
>> Could you turn this immediately into a meson test instead? See e.g.
>> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg07112.html as
>> an example for how to do this.
>=20
> Done (I think).  Until I send v3, the updated version lives here:
>=20
> https://git.xanclic.moe/XanClic/qemu/commits/branch/fuse-exports-next
> https://github.com/XanClic/qemu/commits/fuse-exports-next

Looks good.

Paolo


--yTpWkBMPCthPgcJJUOrBKItciXgnZhGP6--

--wHJU2oZYpzqwuXlywjH2k78i4vkqZRWU7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl9qHAcACgkQv/vSX3jH
roPjvwf+P/Z5btZSnsdUCUxBQEjzda18teng05anoAANcS2pVj54IuumGi2K8+ke
I9ILEZjC7gAhhPZ7OJt9tvL79iA/85v3WAPrsudM28utKFa2WWjd6Ppeo4o3UDvi
t/iYQm22/rCd6nGiKIJvsZqWi61FcfI48tCYo09czd8VWhjjsx70F8Bmx86Te4Jb
nTunfh0+gwF3m7yGXglkeQUNfBUkLhVdYwL+tm76/63oebajh11VfQwOGrPkLp68
i6csvWkkQdv+AwosedoGYQSKTVbLow3o68IvJCPHx99TwYSyWHg+tpR3iRGZ6F6H
4kNBeP04YQwIP67SavmZftOlvZI7nw==
=eBE/
-----END PGP SIGNATURE-----

--wHJU2oZYpzqwuXlywjH2k78i4vkqZRWU7--


