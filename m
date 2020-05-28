Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E21C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158F820888
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SisUcV1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158F820888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKQC-0008Fh-9y
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeKPQ-0007hM-51
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:25:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57118
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeKPP-0004KZ-It
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590679527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yXExKyCMeUn6troSSfah7eycaUQAwHnAQgOpsORA75M=;
 b=SisUcV1J4vUvfc5X1pQvVufk0XNSIdjdB1ntoo5xlG11SOCUZj/ZR2O+/vVjjTpOhJlUns
 viCsGx1gJizFu8HRyxqHFixVwMp1mYSyPDvlOOizolvY5RnGqbDHE3AKsbo6wVcqfzj2lL
 iBXX4AJR8Pr+ujgSWf+664vzbZ6ifPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397--veX6gp1NUC_fKUD2bBzNg-1; Thu, 28 May 2020 11:25:24 -0400
X-MC-Unique: -veX6gp1NUC_fKUD2bBzNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C502E1009441;
 Thu, 28 May 2020 15:25:23 +0000 (UTC)
Received: from localhost (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33E545C1B0;
 Thu, 28 May 2020 15:25:21 +0000 (UTC)
Date: Thu, 28 May 2020 16:25:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 6/7] block/nvme: keep BDRVNVMeState pointer in
 NVMeQueuePair
Message-ID: <20200528152520.GJ158218@stefanha-x1.localdomain>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-7-stefanha@redhat.com>
 <e10fe6ca-de77-ecec-f56c-d46918f247cf@redhat.com>
 <cae44d45-e345-fde7-37f4-5195599e99e7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cae44d45-e345-fde7-37f4-5195599e99e7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JsihDCElWRmQcbOr"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--JsihDCElWRmQcbOr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2020 at 05:20:24PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 5/26/20 4:55 PM, Philippe Mathieu-Daud=E9 wrote:
> > On 5/19/20 7:11 PM, Stefan Hajnoczi wrote:
> >> Passing around both BDRVNVMeState and NVMeQueuePair is unwiedly. Reduc=
e
>=20
> Oh, and typo "unwieldy".

Thanks, will fix!

Stefan

--JsihDCElWRmQcbOr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7P1+AACgkQnKSrs4Gr
c8ilkggAhOh1b0pzc9JHTOJjTI+95GFNL9zfzkfMTiTltPC/fG5sKjTnHmob1rP4
m+DVWDS9qkWZYiCxvJ5Cbheu+S5KyshC1BH7TxHqMFLWIIRDxbR0LLYwnZfdGtP0
ZKSAql9drwLWO6G3xoA5vfpgKnoqUi/7jAmW4N8OTMqljKR9D/FFpvFRz+uapogn
5hF6GGHpHFTWxie7x4wZzimjz6a306qazpaSv3TJSUA3LCfp5gOt6ylG3G5G9dLW
m4ZIINDZeIjt224ZM41LEKf1eHmayCiNeBHRDHrnGAyf/77I1OszQrh8YzLjMmjb
R8FZ81um+m5mesrCUzwcSF/cpMDxnQ==
=uWbq
-----END PGP SIGNATURE-----

--JsihDCElWRmQcbOr--


