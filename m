Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16498C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D969320720
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC4mSrjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D969320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv57c-0002fA-48
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jv56t-0001rf-Da
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:31:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36253
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jv56q-0002pY-Q6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594672291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npXcZB1oEpTEYQh+i59P7qcGIdfEjSPDVH3ZHWjVmAs=;
 b=dC4mSrjLy7rEGIZMDOcnFU33uboFPvLdt+RaSfQ3aJyXlacso4xfC5wAMe1UDPNxjw1FbJ
 O/dUfGmQxMisVuptYZY19bZHDUQS230qnH5CTxXg0LHAPJKlGcD5elHHioT1v79OkEVpgp
 yJ0AwhdHkgx03n4WeE0+HaZ7/AK3C/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-rIIvEY8NMFeyKyec2NibYw-1; Mon, 13 Jul 2020 16:31:29 -0400
X-MC-Unique: rIIvEY8NMFeyKyec2NibYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1092107ACCA;
 Mon, 13 Jul 2020 20:31:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DA362DE81;
 Mon, 13 Jul 2020 20:31:00 +0000 (UTC)
Date: Mon, 13 Jul 2020 16:30:58 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 03/12] python/machine.py: Add _early_cleanup hook
Message-ID: <20200713203058.GA2949886@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-4-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-4-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:40AM -0400, John Snow wrote:
> Some parts of cleanup need to occur prior to shutdown, otherwise
> shutdown might break. Move this into a suitably named method/callback.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 938c891b1d..4280aab380 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -354,16 +354,9 @@ def _launch(self):
>                                         close_fds=3DFalse)
>          self._post_launch()
> =20
> -    def wait(self):
> +    def _early_cleanup(self) -> None:

Inaugurating type hints "around here", huh? :)

WRT method name, up to the end of this series, this method is only about
closing the console socket, so *maybe* just name it accordingly and move
on to an abstract method name when/if the need arises?

Either way,

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8MxIAACgkQZX6NM6Xy
CfOpVA//ftl/w4VHckzC91FpNUMIFIggQQZtQHEOkNgDodb1Ir4tkK4Df9tYog2O
wumYd8aDQj0UrNLih6xhFMlemMqCi5zeKtJAM3ZZj857N9rB0275RDx2d4ViL+vJ
iX65WtnDJx7pU9H/oQZWZR+OVFyGDyrGA4Yk9ZKCfZK1IycdRdd3t721p0kRv0qv
xTQvjHV1aAVaHFfdNbRRoScw/TzlMtCnQPA9lzpOKge+oxKCTtulaDR3FIpNc/B2
8Fw4fCRqZcuxPBtZ13YPqGaCiNgrDJvdXeIcVrHFHxXchxZhq6XgpUUvqdjbIiFE
gE5WqKeXfTSAJ6U/sxgHJl0ja+3Bnq3HT0hNRRvd5Imxsl4247sWAho5Q9abCWhp
HeecsZQeFxSAg+0fYkUVXZr5Oh+RE7Do2qgYrOMiOvsk2ws9ClNM8SR4T+41dzlB
nMyJXV9+6RmOuiUiparVJ/MWDNH7L8YM8Dxz9lX0GQ7SFko+NH+EMbT5sWVMDuwY
TYVzEIjnd4VbWEDZIfvseAKMzDRMOqiiiqqY08PWoknt6SgaeH5+IYxecpDypp7K
xn5p94LleJNEkZE5moCN3KYXaO0HpuphSQl4KVqHrkNqKIIMSpWt5mjADeW3wJ1L
M+3CSjkyUsGfyTpSKz/CR1SG2uaSk8KKYYsSHC89xJyDVrTZcUs=
=3yK6
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


