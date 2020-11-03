Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4490C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FED0206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FED0206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuiA-00074l-St
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kZugh-0005m7-F5; Tue, 03 Nov 2020 06:41:19 -0500
Received: from 3.mo52.mail-out.ovh.net ([178.33.254.192]:51583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kZugc-0003Cy-2r; Tue, 03 Nov 2020 06:41:19 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.171])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id CFEDA2030D1;
 Tue,  3 Nov 2020 12:40:58 +0100 (CET)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 3 Nov 2020
 12:40:58 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0043aa9208b-8673-4097-99bc-8ddec51a5bb0,
 C161C3821E84BD2E3FFA4C47F5A99552FEBD76C4) smtp.auth=groug@kaod.org
Date: Tue, 3 Nov 2020 12:40:57 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 3/4] hw/ppc/spapr_tpm_proxy: Fix hexadecimal
 format string specifier
Message-ID: <20201103124057.38f6fe95@bahia.lan>
In-Reply-To: <20201103112558.2554390-4-philmd@redhat.com>
References: <20201103112558.2554390-1-philmd@redhat.com>
 <20201103112558.2554390-4-philmd@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: a8ad55e2-364a-4178-8c30-585e54b1e1fb
X-Ovh-Tracer-Id: 4740601560615918002
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddtfedgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=178.33.254.192; envelope-from=groug@kaod.org;
 helo=3.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 06:41:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Dov Murik <dovmurik@linux.vnet.ibm.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  3 Nov 2020 12:25:57 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> The '%u' conversion specifier is for decimal notation.
> When prefixing a format with '0x', we want the hexadecimal
> specifier ('%x').
>=20
> Inspired-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index dcc06d49b5a..6d8d095aa28 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -19,7 +19,7 @@ spapr_update_dt_failed_size(unsigned cbold, unsigned cb=
new, unsigned magic) "Old
>  spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned ma=
gic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> =20
>  # spapr_tpm_proxy.c
> -spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_devic=
e_path=3D%s operation=3D0x%"PRIu64
> +spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_devic=
e_path=3D%s operation=3D0x%"PRIx64
>  spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_o=
ut, uint64_t data_out_sz) "data_in=3D0x%"PRIx64", data_in_sz=3D%"PRIu64", d=
ata_out=3D0x%"PRIx64", data_out_sz=3D%"PRIu64
> =20
>  # spapr_iommu.c


