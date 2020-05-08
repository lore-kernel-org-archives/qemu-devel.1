Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A12C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69370208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhNAJeQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69370208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWzIl-0001Tg-LZ
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 05:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWzI7-0000r4-Ic
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:27:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWzI5-0008L9-9V
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588930052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mq6EtZlGWSlSN07Uv7+QU9cQvm3+D3vWT6kLdwIOzS0=;
 b=NhNAJeQecy8U/lu5bsoRQzNw3YLhw3qjrVVSX5Id/9PmrZ4xqX8+T1TP1Jbge/fsIKlfOU
 1IDS61Lh9+KMGnzEHgeGlgzZYnwPf1no+xjCSIij5fAWKmUMylUjQATgcc2bciJrOPb96t
 K8Jr3aE5THZAe3AXOWpLrLkbu1ZRlhE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-P3cVdKoZOl2JLVyjUs4Ucg-1; Fri, 08 May 2020 05:27:30 -0400
X-MC-Unique: P3cVdKoZOl2JLVyjUs4Ucg-1
Received: by mail-wm1-f69.google.com with SMTP id w189so1215598wmg.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 02:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G7miEU4/Cww1iB3jcG2FZNWDVmSXr9lhQDS6L2mqLuE=;
 b=oyvaR0Dnm+vVzBashFZvQCUz6U52hwlrMiEA0ZDbK6OBI6zJBoJz0jh7R+N/yhlRDO
 rY95NW7BNJc4Tldh1jDjMbqjVXKTSV0yu3yf61DvpSyRWvi678e+GLbQZ8vaSAv6jn6x
 JTf81CCclhvbvIxAKRscRiFYO0UAhRNm1awiSBvW5DtnS6ERKp3I7nDXxm4CMxRaHIsg
 SVlSOLDJxK5rdTeReSI89xgZOu+SSA24iaIcPa4Pk0rL7GXNXxd4eLibob4DKK3dtO4Q
 Y17om7f2ufy7S1DthNcxtXvc96x++t2u/OcgP7ZseWnrPA8Qp1ibu75dF7pM+TmAPwnC
 3zgw==
X-Gm-Message-State: AGi0PuZkY7ylrJ341rkt19XdpbjO5CH4rUH/Wi29Rd++FXvz79e5j/63
 P37UpkeQhF1v77kxkr4NgkCizV3gvMLjA4IATSQ+wZ+ewPQV0zQfUptMf3ijaQeuORrFyBQ0kzt
 jsVeS0d5sQH3cOMo=
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr1856529wrx.107.1588930049363; 
 Fri, 08 May 2020 02:27:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypLwZYHA/W54tnr+5MbYcybfnSYTSLsxwKP05kP9lpaeFke9frHGQZYIuQb3If7woMCKGww6WQ==
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr1856498wrx.107.1588930049161; 
 Fri, 08 May 2020 02:27:29 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n12sm2084617wrj.95.2020.05.08.02.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 02:27:28 -0700 (PDT)
Subject: Re: [PATCH 06/10] exec: Move ramblock_recv_bitmap_offset() to
 migration/ram.c
To: quintela@redhat.com
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-7-philmd@redhat.com> <87imh6g89c.fsf@secure.mitica>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a364eb2f-f14a-dff6-5553-c5934dd7f27b@redhat.com>
Date: Fri, 8 May 2020 11:27:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87imh6g89c.fsf@secure.mitica>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 10:07 AM, Juan Quintela wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>> The ramblock_recv_bitmap_offset() function is only used once
>> in migration/ram.c, move it there.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20
> But, if you are in the mood:
>=20
>>   }
>>  =20
>> +static inline unsigned long int ramblock_recv_bitmap_offset(void *host_=
addr,
>> +                                                            RAMBlock *r=
b)
>> +{
>> +    uint64_t host_addr_offset =3D
>> +            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
>> +    return host_addr_offset >> TARGET_PAGE_BITS;
>                                    ^^^^^^^^^^^^^^^^
>=20
> That should be qemu_target_page_bits().

Ah! I've been looking for this function :)

>=20
> We are trying (not there yet) that migration code is target independent,
> this TARGET constant are one of the problems (not the only one,
> thought).

Good.

>=20
> And yes, I know that this file has both the function and the constant,
> sniff.
>=20
> Later, Juan.
>=20


