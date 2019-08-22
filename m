Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D058EC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F7D2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F7D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ivx-0003R6-Qn
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0iv3-00031O-9K
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0iv2-0003YI-1g
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:58:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0iv1-0003Y7-PE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:58:07 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD1DFC08EC1D
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 08:58:06 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id c14so2663844wml.5
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 01:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=d3q7m48DTcotzNF5DTk0GFoZSRniDLygmk1QCcFza9o=;
 b=GSgXEUoZXzrltjsjXXATFIueUIFsa8SFvS6z3iTziTTzZS54NKWVzN2l+KixYE2WKI
 VhaB/Hg08ys1kpFts9MUVqlK3fnDMBC5abmRE9tTABqmOJY3yvU4jzd0skmaFi8hv+Gk
 1TVw0whmT6N5RZYuHBobfJbvtPERXElfSw5dEvYrpCyd0657cvbITHd1fn0CLo5pLIuk
 5orIYas2d3P5oFJ5r3XE2odfyQqSzHPzHLTEwVvN77dF99nqveefq849Ny29pFg0vH+s
 PRD83JBp4WQV8tAN7veyjf3hHyh41YuGAvX/ki1DhAHB4jQBsIZjGQMTOKB4HfUDTrfs
 6ymA==
X-Gm-Message-State: APjAAAXJ+afJ7kl7XNGW5R0POubNq61uUuDNKhoN6gCpQe77a8nHEEY8
 Ya0o2fXk0ciksdd2/L3rNLokajhjceut+xpd8FobTIpls6tlOwE9L8looW1CgPN0BjDm/bFDxdG
 g4840iFlZkIJGLwU=
X-Received: by 2002:a1c:be15:: with SMTP id o21mr4869092wmf.140.1566464285366; 
 Thu, 22 Aug 2019 01:58:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzP5DwMYh4fVTjvRcPTDEz493Sjg2XrVB06GRHDnqVLOZqqdGwKcktjzkeEcn5fDYN7GlRI4A==
X-Received: by 2002:a1c:be15:: with SMTP id o21mr4869050wmf.140.1566464285129; 
 Thu, 22 Aug 2019 01:58:05 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id c201sm6224519wmd.33.2019.08.22.01.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 01:58:04 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.com>
 <20190614091841.GE10957@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <44e330cb-fe17-6f22-523f-2ecc6e280859@redhat.com>
Date: Thu, 22 Aug 2019 10:58:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614091841.GE10957@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iATNbjMuysIcrjOWYZpRi2TusxC7HhIuK"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vhost-user-scsi: prevent using
 uninitialized vqs
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iATNbjMuysIcrjOWYZpRi2TusxC7HhIuK
Content-Type: multipart/mixed; boundary="BJVmbyPMAAcEjPjMAJxZkF49qcnCfy7ZS";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <44e330cb-fe17-6f22-523f-2ecc6e280859@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user-scsi: prevent using uninitialized
 vqs
References: <1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.com>
 <20190614091841.GE10957@stefanha-x1.localdomain>
In-Reply-To: <20190614091841.GE10957@stefanha-x1.localdomain>

--BJVmbyPMAAcEjPjMAJxZkF49qcnCfy7ZS
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Raphael, Stefan,

On 6/14/19 11:18 AM, Stefan Hajnoczi wrote:
> On Tue, Jun 11, 2019 at 05:35:17PM -0700, Raphael Norwitz wrote:
>> Of the 3 virtqueues, seabios only sets cmd, leaving ctrl
>> and event without a physical address. This can cause
>> vhost_verify_ring_part_mapping to return ENOMEM, causing
>> the following logs:
>>
>> qemu-system-x86_64: Unable to map available ring for ring 0
>> qemu-system-x86_64: Verify ring failure on region 0
>>
>> The qemu commit e6cc11d64fc998c11a4dfcde8fda3fc33a74d844
>> has already resolved the issue for vhost scsi devices but
>> the fix was never applied to vhost-user scsi devices.
>>
>> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>> ---
>>  hw/scsi/vhost-user-scsi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

What about backends/vhost-user.c and hw/block/vhost-user-blk.c?


--BJVmbyPMAAcEjPjMAJxZkF49qcnCfy7ZS--

--iATNbjMuysIcrjOWYZpRi2TusxC7HhIuK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl1eWRoACgkQoqP9bt6t
wN7/PQ//d/yry/2epfthODV4QDxasPd2P13EaI5Gtyn9/2ORJQ9OOiFLLEHuKrdh
V0r4G/y2JuIIrk2jBQtxblNtCYEU/p/XWW339sLMfq44N/fDFU2eGeqA8rxu4tEv
puXI/OPXau1ZSGaQAXtI0u4lbFG10PHsig/XhQY7CwHCSjlJT7mzyg5zDRIzjDol
FCliCRi+7iRFJCs0kNOJj3pzrTKS5s8622PWbuoGDepYuiyxEOsPlsO2e73fIBif
+yWa1osvU+D57V+6C5YHtCSye+yOmlZSwAjjwcpTmND0F04WJHq9qHDImImgbRJE
GVuJTCrFOJOGclWac4l/suWVTlIfysJs0paEson/6ZwR7Ccf73BdKmZSiMihxt9D
HCk3XQjARtSe2CHmTiooGH8Va8ObB/QYE8rwl85ZJ3UnEI/Nw8JKq2c1GQ7hHumM
kPFXTZXEYEhcM22O02VzOwvc/EV0uLdSkB8BWzS9xov67d+R6WSTwgbdIWd9tZNT
riewZYprFNONamewfmKlaOcCL5xVvFpwgJag8JhLaC0w6RcEmtYvuHdmMl5DnFs3
IIfqzfjPYAHbQvoIZhN7A5afgRePoOc0NbSRcEA2wFslKVCqRieWEeu0N8SImkVE
0wlFLeDelb6vNwy6+NN4mpVKKjx3Bx+9vL1KDG09HZl7awqMIRs=
=s7iH
-----END PGP SIGNATURE-----

--iATNbjMuysIcrjOWYZpRi2TusxC7HhIuK--

