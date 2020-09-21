Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FFAC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE4D20BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/qvSvIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE4D20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMdl-0003ft-0l
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKMc5-0002wj-BI
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKMc2-0001d7-EW
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600697773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RLEao7MexzyfFt4A22pF9B8msxKiRQ3kUMgQGtfkcyE=;
 b=R/qvSvIVvdBKOzyVl9rLNAgMxN6BlFNKejGXKVSROoBjs3zAUZVk7l5v3uOdoyjiiaBTNi
 mXaNmSflB+v2G4Eb4Ta3CrYNZwM0PIxv4Hni6zX4qSJ62/x92ppCC44OLXC0ExkY45V16q
 YzSLarBFN8mh6IrFNpnfVwu4QygDQ1w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-0lWNDV8CMSSwebpKv5jWMg-1; Mon, 21 Sep 2020 10:16:11 -0400
X-MC-Unique: 0lWNDV8CMSSwebpKv5jWMg-1
Received: by mail-wm1-f69.google.com with SMTP id w3so3804132wmg.4
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 07:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=MxSQ+/VT7jxoULMAB6ENxExKkpQSG3hnmi7mwloL+CQ=;
 b=NLht9ZnDSG9T1PGFq655R3embiU13iQzV0Rznf2JPjaHuWDpku1Mlm4MgNZLZno0yY
 SQ07uhM93PGfv3T4Cz9THzkoznWYCRzjIH/6YQ2ia2CScjPkCXlS/RmWVbAVh+n571IE
 a62dASzplkq3OdoOAmCF0IjYR6EHFoX74TU9zBnkK+weIhWNr/HDX4Ua+0iIJbao2Nu7
 wrOobMrayZ5AQsmogjjDn3cqKxKe+bbHXNKoK/LBZ20aFRZO9cGmbVYk/NgQ6/dEcLkp
 3xa7NZp75DWAbiUK8vtqqbwbYsGRR7JsjJ2B+sR6Uiq6m1SKxY1+D3Y7phkM0SlUqnDz
 uSQw==
X-Gm-Message-State: AOAM5326DgOg+D09P4u2ct0W1rQ/1yRIrEsWqsYLz2mbCvqoNWKdNgKZ
 8yO4+DNvjlwRvgcVaD3Far5C9TLlVyae0VD+uEpY0RxFQjts7Z18j3Q6HGiCcdthG+3kLCueihg
 zW/Uv58REmBriB1w=
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr38911wmh.115.1600697769786;
 Mon, 21 Sep 2020 07:16:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIEXEMRiLlWfOTN5Sx+ogSHqMIhXCttzIJ1hWpMiQrExxAO0ut6F4RerRyTGOR5O+ZjIa6AA==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr38868wmh.115.1600697769411;
 Mon, 21 Sep 2020 07:16:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d153:8d0f:94cf:5114?
 ([2001:b07:6468:f312:d153:8d0f:94cf:5114])
 by smtp.gmail.com with ESMTPSA id q4sm20637248wru.65.2020.09.21.07.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 07:16:08 -0700 (PDT)
Subject: Re: [RFC] Move to C11 Atomics
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200921104107.134323-1-stefanha@redhat.com>
 <b32450b7-13e4-9968-cd99-fe8210040d3b@redhat.com>
 <20200921134423.GA156064@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <439bbea5-60d7-aa9c-e693-3a3b1143154c@redhat.com>
Date: Mon, 21 Sep 2020 16:16:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921134423.GA156064@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HxOFWWUTyL9j5WspOOxIxiIvnYK7C8lCD"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel Berrange <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HxOFWWUTyL9j5WspOOxIxiIvnYK7C8lCD
Content-Type: multipart/mixed; boundary="Mg6yjmpBcvud8J52XPKpgsveFucMDA5YA"

--Mg6yjmpBcvud8J52XPKpgsveFucMDA5YA
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21/09/20 15:44, Stefan Hajnoczi wrote:
> On Mon, Sep 21, 2020 at 01:15:30PM +0200, Paolo Bonzini wrote:
>> On 21/09/20 12:41, Stefan Hajnoczi wrote:
>>> The upshot is that all atomic variables in QEMU need to use C11 Atomic
>>> atomic_* types. This is a big change!
>>
>> The main issue with this is that C11 atomic types do too much magic,
>> including defaulting to seq-cst operations for loads and stores. As
>> documented in docs/devel/atomics.rst, seq-cst loads and stores are
>> almost never what you want (they're only a little below volatile :)):
>=20
> I can't find where atomics.rst says seq-cst operations are almost never
> what you want?

Note that I'm talking only about loads and stores.  They are so much
never what you want that we don't even provide a wrapper for them in
qemu/atomic.h.

  ``qemu/atomic.h`` also provides loads and stores that cannot be
  reordered with each other::

    typeof(*ptr) atomic_mb_read(ptr)
    void         atomic_mb_set(ptr, val)

  However these do not provide sequential consistency and, in
  particular, they do not participate in the total ordering enforced by
  sequentially-consistent operations.  For this reason they are
  deprecated.  They should instead be replaced with any of the following
  (ordered from easiest to hardest):

  - accesses inside a mutex or spinlock

  - lightweight synchronization primitives such as ``QemuEvent``

  - RCU operations (``atomic_rcu_read``, ``atomic_rcu_set``) when
  publishing or accessing a new version of a data structure

  - other atomic accesses: ``atomic_read`` and ``atomic_load_acquire``
  for loads, ``atomic_set`` and ``atomic_store_release`` for stores,
  ``smp_mb`` to forbid reordering subsequent loads before a store.

where seq-cst loads and stores are again completely missing.  smp_mb is
there to replace them, as we did in commit 5710a3e0 ("async: use
explicit memory barriers").

>> we can use store-release/load-acquire
>=20
> They don't provide atomic arithmetic/logic operations. The only
> non-seq-cst ALU operation I see in atomic.h is
> atomic_fetch_inc_nonzero(), and it's a cmpxchg() loop (ugly compared to
> an atomic ALU instruction).

Seq-cst is fine for RMW operations (arithmetic/logic, xchg, cmpxchg),
also because they're usually less performance critical than loads and
stores.  It's only loads and stores that give a false sense of
correctness as in the above commit.

Paolo


--Mg6yjmpBcvud8J52XPKpgsveFucMDA5YA--

--HxOFWWUTyL9j5WspOOxIxiIvnYK7C8lCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl9otacACgkQv/vSX3jH
roN82Af8DitMvRQ39kET3eMpMr06j1oGBHcG8XXbR6RumoKwJYS/kesf/zICI3d5
yUq2iaQL05kTq1Mhu5gdxjEUce/G4MM24UwgE4fDiAemSL+beF64GJG4RYjEKBFR
1SvdPE2enB8HEHDXMFR8QQDMmb0y+WXzQk65T2PpBor/wsEdMTnhapk0SunbYiLE
HN7AsTOIDmrL9EYJL0aV8RlfTrJy0dJAw154ebJj7F1Rdmdmwl+CliwBOQu6Meom
jOCUSZ2m3D5N/GQ92p6t6xSlhYVRap5noHvBxh7/h7925kBfkABIBqCVZbZU7FGf
pgpz+UZEKZBjio63L5o86yRA1mcDog==
=V6pn
-----END PGP SIGNATURE-----

--HxOFWWUTyL9j5WspOOxIxiIvnYK7C8lCD--


