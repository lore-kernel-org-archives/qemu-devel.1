Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20D6C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F892063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VC6Lt8XT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F892063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QKk-0007ZF-Sy
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8QK7-0006lD-26
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:48:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28911
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8QK4-0003Pr-ST
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597852098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EpYbA9U6DEvr6fH5/sdQ8/3xjHK/yFaCRzjqKqZ5YHI=;
 b=VC6Lt8XTL/RzO1Pqw8llnIzKo3th4PZcJBX9aWPUmSQ7LyzuFCl9qwmBT2IppuxGOtK6Ix
 xtRVUvmfAdZkS8KbTuGEA2b5WGN9fnG6PaUcpE2dvzblo2DGObjs34SkfVpb+IyugkVKb6
 oRfm/PA6tRoeXL9ajvbVEzzPV2S84cE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-g7KPo9EhOo--Cs1DXyoZXg-1; Wed, 19 Aug 2020 11:48:14 -0400
X-MC-Unique: g7KPo9EhOo--Cs1DXyoZXg-1
Received: by mail-wr1-f71.google.com with SMTP id z1so9478663wrn.18
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 08:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=T6tPuZqsLFoI1BB3VEecLkd9Fes4LU46C9aXqdteRzo=;
 b=GRwPEEwoBfMNpSZHy1MmXqk4cYzwfzROlNfeW8+CMfhqy9I/xWq7CoTXyBktBJb3g0
 v1W3tTbqBRerr9Zamzr3w9SGXgb5rcA1ohK9nXUDY+7H3xruLrJEiXC1QA7y9UI90Oke
 asKLWw1Sf88zLz8YPYo9y+ixqAbWKt0gcXBwLG6klGPrPwv5kjf6A2jXlDcMzTGAHVgg
 TV7X3uL1HFdc+uGTqZXtxd/YJKT3QJZWIcs3sTbTAtfvSXcj/2UplFCGR2TxJNONzwbl
 KPoVxrWg2uOmQ+NZZ1cdkTrsX9VxMHJ3Cff3G+eyIycndvpFSGBlnHbXKJb4IIyz+NvV
 /2qg==
X-Gm-Message-State: AOAM531HMKKH+VSmI4MMvzOBMGMnvVmdLIFEOTa3hNBEmUgo54fDkrE2
 X0o4n3UBK3QdSiIbAJ65Vde4azCGiP7bt8/FF3V8UGWbZsy9UtP9iPgomTbivMsvjXcqMiod7s0
 udIOjwxflFgOuBf0=
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr27016848wrv.423.1597852093251; 
 Wed, 19 Aug 2020 08:48:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPaT3bBG529rKsrMP5Jv+cvo9mK8dnAxeen/ALNWTeSNi/uvdKPEowsFrYsrlQ40r6Kc8fSQ==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr27016785wrv.423.1597852092342; 
 Wed, 19 Aug 2020 08:48:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id f15sm43583586wrt.80.2020.08.19.08.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 08:48:11 -0700 (PDT)
Subject: Re: [PATCH v3 02/12] block/io.c: drop assertion on double waiting for
 request serialisation
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
 <20200817091553.283155-3-vsementsov@virtuozzo.com>
 <20200819152836.GP366841@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <890b5c05-1391-b2bb-7595-69061ace45c2@redhat.com>
Date: Wed, 19 Aug 2020 17:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200819152836.GP366841@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FkHAQUPRpgaEHz8MZJLBJMKRbKHxiUex7"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FkHAQUPRpgaEHz8MZJLBJMKRbKHxiUex7
Content-Type: multipart/mixed; boundary="crLpDUKTw1WmKMgmHtNAkTmUBAcQDfyK5"

--crLpDUKTw1WmKMgmHtNAkTmUBAcQDfyK5
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19/08/20 17:28, Stefan Hajnoczi wrote:
> On Mon, Aug 17, 2020 at 12:15:43PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> The comments states, that on misaligned request we should have already
>> been waiting. But for bdrv_padding_rmw_read, we called
>> bdrv_mark_request_serialising with align =3D request_alignment, and now
>> we serialise with align =3D cluster_size. So we may have to wait again
>> with larger alignment.
>>
>> Note, that the only user of BDRV_REQ_SERIALISING is backup which issues
>> cluster-aligned requests, so seems the assertion should not fire for
>> now. But it's wrong anyway.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  block/io.c | 11 +----------
>>  1 file changed, 1 insertion(+), 10 deletions(-)
>=20
> This code was added by Paolo, CCing him.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

bdrv_mark_request_serialising already calls
bdrv_wait_serialising_requests_locked so it is okay.

Thanks,

Paolo

>> diff --git a/block/io.c b/block/io.c
>> index ad3a51ed53..b18680a842 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1881,7 +1881,6 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_=
t offset, uint64_t bytes,
>>                            BdrvTrackedRequest *req, int flags)
>>  {
>>      BlockDriverState *bs =3D child->bs;
>> -    bool waited;
>>      int64_t end_sector =3D DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZ=
E);
>> =20
>>      if (bs->read_only) {
>> @@ -1893,15 +1892,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64=
_t offset, uint64_t bytes,
>>      assert(!(flags & ~BDRV_REQ_MASK));
>> =20
>>      if (flags & BDRV_REQ_SERIALISING) {
>> -        waited =3D bdrv_mark_request_serialising(req, bdrv_get_cluster_=
size(bs));
>> -        /*
>> -         * For a misaligned request we should have already waited earli=
er,
>> -         * because we come after bdrv_padding_rmw_read which must be ca=
lled
>> -         * with the request already marked as serialising.
>> -         */
>> -        assert(!waited ||
>> -               (req->offset =3D=3D req->overlap_offset &&
>> -                req->bytes =3D=3D req->overlap_bytes));
>> +        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
>>      } else {
>>          bdrv_wait_serialising_requests(req);
>>      }
>> --=20
>> 2.18.0
>>



--crLpDUKTw1WmKMgmHtNAkTmUBAcQDfyK5--

--FkHAQUPRpgaEHz8MZJLBJMKRbKHxiUex7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl89SboACgkQv/vSX3jH
roOjpQf/UTGqtbKf4JLupYGXVtWzwCdQR9KMjQq5zhJtxJ5NvBLtv7yiDeRRRF06
/WEIFQOygu02RSuERp2Iil55HM6rAnHvW5Pnx3HUsarEgyNOAt6CMFkeCaL28yyE
3v5zX+cpsuXc+yX0SRnF4MlaywlSnpOL2mGKAgKzkV9uu6qX9vg/ZAuGxRyDofcr
U/dVJjkFMmMrWYUF/nU/RyfA0t32E9fQn417tbhXVDsuI6U7IMIEZeSSyAKMxiPf
U8++0KB7hyVr1quaUupxs9/+OyjsyCz2JbOY7/2TJwywaUDIxRQzsxWXCqUPmuxI
ldwNUX1o+Iqg8ayF2Jy8MAu7Hf2mMA==
=F9DH
-----END PGP SIGNATURE-----

--FkHAQUPRpgaEHz8MZJLBJMKRbKHxiUex7--


