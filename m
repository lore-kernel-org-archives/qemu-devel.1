Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25CEC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317A720878
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csRdpXZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317A720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbHFR-00034O-4h
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 00:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbHEe-0002WK-3Q
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbHEc-00023t-Dp
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604728677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4ygyH8r/vBtbPO10dz0jRfa7uj0U/3uQN7CLU4Vwl8=;
 b=csRdpXZZodExbV4CVgXvCriPXgvveA/UVNOCt961w+qJxBKVqWYXWsmhKfFlHHHbtCetzx
 h4o8ESCh3/8uPukL+ajqE2ayIPZSVgHtjjLB8Vtge73DnOLLpvnUx5F6UeLGJ8BkTUPqXM
 2AewnYK8ixVV/6mGWQsKG0z2uz2SkBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-8gchkRP0OLO-TalMTIyR3g-1; Sat, 07 Nov 2020 00:57:55 -0500
X-MC-Unique: 8gchkRP0OLO-TalMTIyR3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BD15107AFB1
 for <qemu-devel@nongnu.org>; Sat,  7 Nov 2020 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-47.rdu2.redhat.com
 [10.10.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5729E5C5DE;
 Sat,  7 Nov 2020 05:57:53 +0000 (UTC)
Date: Sat, 7 Nov 2020 00:57:51 -0500
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 11/11] qapi/introspect.py: Add docstring to
 _tree_to_qlit
Message-ID: <20201107055751.GG2208@localhost.localdomain>
References: <20201026194251.11075-1-jsnow@redhat.com>
 <20201026194251.11075-12-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026194251.11075-12-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2020 at 03:42:51PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Not a big deal, but maybe move this to an earlier position in the
series?  IMO it'd make other reviewer's life easier.  Either way:

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+mN18ACgkQZX6NM6Xy
CfNzTA//cAnNzTFzJg4duHeSV1VNuI97VqKLPS1RWmXtQekjy8IeaYknb9n60PkK
QCvgc2CjZ07MyOvOf97kHYR5SUHdF23XZdRJZDeNsSldgDkiWfxKtPv47UfYmqit
tFKjO6SNqGuWYC84YpsU5ukQbAgEqY7SriLgLzHYSJd809/0Rr2fjYCkTwy8+/D4
exi2YyLKlcS+p+t7GRHd66zRsD4tJzSoLvgVWoghHcUkLK5eB4zm9Uwx337aoJ2C
z7R0Vt6QnKvNLOXyelQd7v9JymXIKk+XT8J+mS2JAdUPJk8xvlNGE65u9RX7eO3D
EtjN86Pjsv/0/yglLsckHPZdtBYgvudnuBM2Of/CCGzXpFaCaskI9tuMPWubDC/J
pWWX93YCVD9Efe2B9SMqoWJOBsxscYOWd0aijrTSXJmpBeltJHRf36RsazV9oCEp
81QCc65/9Bez6PI3tTHm4n3zQHkCR12UCDCpylfJd3qg7CReYrdUIQjV3xwFtlNY
Fyt23GnLXZ1JuFQLQXLEhoEeKDgAZtS40gtAl4Uzr723p0CNDOtyRKTVQ6V5skB9
9G9OHMdwYNPxAmyrAX8g/eEWAqCc4aqla103i3HUHS4KurpbohZdP8u+X1qL9x/i
I6+f5iOXJusVTYl2oqGsE2F3ImaFeDeXAtriqe4ofWBJ7404QS8=
=JzL2
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--


