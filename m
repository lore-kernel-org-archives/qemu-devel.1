Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E5FC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD972083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATK45EsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD972083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWjKu-00084w-Jy
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 12:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jWjKH-0007Qi-G9
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:24:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jWjKF-0004zB-Lk
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588868680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y4qAclFnl9n6aLCNsz1yjmf+UolQnMzPbDgXy0E/uVQ=;
 b=ATK45EsY8SPckWcZgLaPbGf59Q3fNaiQH6jX3N0sQ5n9FHOfJjkoGrebJfnb2DgnduTO+e
 1w6YquIRMKQXhu2HJ9qH6soCTSS+HjJZLV23UfuXtFagkQI5YR+FAxSTooqQ7/f777VkPH
 3xqJe8i8OXgmr51eCRon7U4ss6eie6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-M65L3SiYNj-wayK11brmRQ-1; Thu, 07 May 2020 12:24:37 -0400
X-MC-Unique: M65L3SiYNj-wayK11brmRQ-1
Received: by mail-wr1-f71.google.com with SMTP id g10so3736903wrr.10
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 09:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=KMF5LqoPzB8XFZampQNMX7Qi3EOzXSSLI6wO6rwu5wg=;
 b=E2ofkJkmcJAWbRrJafLbpYJMewj85YH8/ucKbEbQGOWSwTx/eyFdXN+9sAsDo6zLC+
 HXZqq/xpjoltk94rImm57N4uRLG4f1WyDKjr5YHmeIBHwDg5XA6ml3vxHL7ESVdt9JEd
 j4ztnrteKFeTg+vrKMEo+ltFKCYpeKWf+D9WLj3bqdae4OhiiIUBrvdnWR+2w3ipAURK
 l9afFbb0iuUAzJ9bAOgNzCbqbssmAaLFtCXFZgE+5DnMpSctcBSfBO26ouyXA1XaeTQW
 n0XePziuwYOQwrCn8o5UIQM8c5cJW/mkdZ1uw2ecA07GUMyzNHCzvowEiAf7GZUZwU1/
 TI5Q==
X-Gm-Message-State: AGi0PuaDQlcaJHIfPR02+LoRi3HVw2KwAlFTpJiEbHV3DG52riwFFRQh
 +qNCrqTLBAelX7QZLa6P/aapIguzSvP+/nzo/jcWmmQKTE6IyT5xfALLZY+aqkoySm3Z7lE4xtH
 ojOr6skzEnXqdfXY=
X-Received: by 2002:adf:e74a:: with SMTP id c10mr16397356wrn.109.1588868676479; 
 Thu, 07 May 2020 09:24:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQSAnm1kMPRgmnH15U/kpmIK/to6cLZyjxUeD/3yoQ9+VqG08QixF5FuSt1gQLImQ8W3aVPA==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr16397338wrn.109.1588868676258; 
 Thu, 07 May 2020 09:24:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc?
 ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
 by smtp.gmail.com with ESMTPSA id k6sm9272266wma.19.2020.05.07.09.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 09:24:35 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] hw/block/nvme: Make device target agnostic
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200504094641.4963-1-philmd@redhat.com>
 <20200504094641.4963-7-philmd@redhat.com>
 <9a46b1b4-bfbf-21bd-cc66-5904e784150c@redhat.com>
 <20200507100435.GG34079@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <694917e5-294c-bf57-8916-d86ce74edb1f@redhat.com>
Date: Thu, 7 May 2020 18:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200507100435.GG34079@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aEjiGRKjX1hgzpjGj3EUZ3Q4GdwkcrCTs"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aEjiGRKjX1hgzpjGj3EUZ3Q4GdwkcrCTs
Content-Type: multipart/mixed; boundary="LyXizUDjDR3ex5jtGRubyM3oMZgJzz9ok"

--LyXizUDjDR3ex5jtGRubyM3oMZgJzz9ok
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/05/20 12:04, Stefan Hajnoczi wrote:
>>>               (NVME_PMRCAP_PMRWBM(n->bar.pmrcap) & 0x02)) {
>>> -            qemu_ram_writeback(n->pmrdev->mr.ram_block,
>>> -                               0, n->pmrdev->size);
>>> +            memory_region_do_writeback(&n->pmrdev->mr, 0, n->pmrdev->s=
ize);
> qemu_ram_write() is being called because we need to msync or persist
> pmem here.
>=20
> The memory_region_do_writeback() API is not equivalent, its purpose is
> for dirty write logging (which we don't care about here because the
> writes themselves will already have been logged when the guest performed
> them).
>=20
> I think qemu_ram_writeback() should just be made common so that this
> code isn't target-specific. Maybe it should be renamed to
> qemu_ram_msync() to avoid confusion with dirty write APIs.

Yes, we can add qemu_ram_msync and memory_region_msync.

Paolo


--LyXizUDjDR3ex5jtGRubyM3oMZgJzz9ok--

--aEjiGRKjX1hgzpjGj3EUZ3Q4GdwkcrCTs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl60NkIACgkQv/vSX3jH
roNykwgAiiMWIxgYDeZT5CL4Omh1d37EezL4s4wHJWjAmUBhyb0oiO/MtYdGyJYe
likeByQFLcGOFoe1P28ZlrnE83hgryV4sEvGaqKEHzKRR5D18Nci8j8hJv8iTvgL
SpfOKqSpcCMxVgv6fgyD5c1kr2e+ctih+VqOAxN+ct9i8etLQNIt9kHUD3KUQmW7
kxhvjIn/tAlA2rv/G8vMba71iieBmZMPAKc6TrUFByyYPb2vw6dcf2Qokd7tNdXK
XjxMn9zxPNmOdB5DGKvFtCUlnzjCVNxpSmZnxELy8YfJdbs4t5OBOh6y7JcwGKSs
jfmZnN2k5ra7ePIydZQOUfkJT8zmbA==
=A1pQ
-----END PGP SIGNATURE-----

--aEjiGRKjX1hgzpjGj3EUZ3Q4GdwkcrCTs--


