Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0517C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE1A23B2A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkNIFY3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE1A23B2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsXe-0001Bq-RL
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jpsWf-0000ef-AW
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:04:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52902
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jpsWb-0000cO-SB
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593432276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJfKZveAVQm+PxgUKE5g8cSvtfqkVfLc6GvM1DZHAo8=;
 b=hkNIFY3CjpS8SKFbTrl9SSN2vlVcHospft9j73TYcBR9DYhxxqIqbRDsNxcsxpTPYQNRxQ
 datuSunlJVPXxP+C/G/p2JKtoJy61VQiGaW4rd95MDhTY4lIVLdAx2eGSFu0DrPevfm4kE
 7Ffd+Gb2hWKX5ubMjXcCxB94XgDiDl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-8TcQpfoaOSaFhP9K39jtTQ-1; Mon, 29 Jun 2020 08:03:54 -0400
X-MC-Unique: 8TcQpfoaOSaFhP9K39jtTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7319464;
 Mon, 29 Jun 2020 12:03:53 +0000 (UTC)
Received: from starship (unknown [10.35.206.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B6F060BF3;
 Mon, 29 Jun 2020 12:03:52 +0000 (UTC)
Message-ID: <2daeeb10392c783e4dbe3974f9560ee630f9672b.camel@redhat.com>
Subject: Re: [PATCH 06/19] iotests: Check whether luks works
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Mon, 29 Jun 2020 15:03:51 +0300
In-Reply-To: <20200625125548.870061-7-mreitz@redhat.com>
References: <20200625125548.870061-1-mreitz@redhat.com>
 <20200625125548.870061-7-mreitz@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-06-25 at 14:55 +0200, Max Reitz wrote:
> Whenever running an iotest for the luks format, we should check whether
> luks actually really works.
> 
> Tests that try to create luks-encrypted qcow2 images should do the same.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/087        | 1 +
>  tests/qemu-iotests/178        | 1 +
>  tests/qemu-iotests/188        | 1 +
>  tests/qemu-iotests/189        | 1 +
>  tests/qemu-iotests/198        | 1 +
>  tests/qemu-iotests/206        | 1 +
>  tests/qemu-iotests/263        | 1 +
>  tests/qemu-iotests/284        | 1 +
>  tests/qemu-iotests/common.rc  | 3 +++
>  tests/qemu-iotests/iotests.py | 5 +++++
>  10 files changed, 16 insertions(+)
> 
> diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> index bdfdad3454..678e748c58 100755
> --- a/tests/qemu-iotests/087
> +++ b/tests/qemu-iotests/087
> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> +_require_working_luks
>  
>  do_run_qemu()
>  {
> diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
> index 7cf0e27154..f09b27caac 100755
> --- a/tests/qemu-iotests/178
> +++ b/tests/qemu-iotests/178
> @@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt raw qcow2
>  _supported_proto file
>  _supported_os Linux
> +_require_working_luks
>  
>  echo "== Input validation =="
>  echo
> diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
> index 09b9b6083a..13b225fded 100755
> --- a/tests/qemu-iotests/188
> +++ b/tests/qemu-iotests/188
> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto generic
>  _supported_os Linux
> +_require_working_luks
>  
>  
>  size=16M
> diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
> index c9ce9d3bed..e6a84b8a3b 100755
> --- a/tests/qemu-iotests/189
> +++ b/tests/qemu-iotests/189
> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto generic
>  _supported_os Linux
> +_require_working_luks
>  
>  
>  size=16M
> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
> index fb0d5a29d3..aeb059d5ea 100755
> --- a/tests/qemu-iotests/198
> +++ b/tests/qemu-iotests/198
> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto generic
>  _supported_os Linux
> +_require_working_luks
>  
>  
>  size=16M
> diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
> index f42432a838..11bc51f256 100755
> --- a/tests/qemu-iotests/206
> +++ b/tests/qemu-iotests/206
> @@ -24,6 +24,7 @@ import iotests
>  from iotests import imgfmt
>  
>  iotests.script_initialize(supported_fmts=['qcow2'])
> +iotests.verify_working_luks()
>  
>  with iotests.FilePath('t.qcow2') as disk_path, \
>       iotests.FilePath('t.qcow2.base') as backing_path, \
> diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
> index d2c030fae9..f598a12899 100755
> --- a/tests/qemu-iotests/263
> +++ b/tests/qemu-iotests/263
> @@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto generic
>  _supported_os Linux
> +_require_working_luks
>  
>  
>  size=1M
> diff --git a/tests/qemu-iotests/284 b/tests/qemu-iotests/284
> index 071e89b33e..9f6c29a79c 100755
> --- a/tests/qemu-iotests/284
> +++ b/tests/qemu-iotests/284
> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto generic
>  _supported_os Linux
> +_require_working_luks
>  
>  
>  size=1M
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index f3667f48ab..7ac46edc1f 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -605,6 +605,9 @@ _supported_fmt()
>      # setting IMGFMT_GENERIC to false.
>      for f; do
>          if [ "$f" = "$IMGFMT" -o "$f" = "generic" -a "$IMGFMT_GENERIC" = "true" ]; then
> +            if [ "$IMGFMT" = "luks" ]; then
> +                _require_working_luks
> +            fi
>              return
>          fi
>      done
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 039170a8a3..e1ddfcb662 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -1010,12 +1010,17 @@ def _verify_image_format(supported_fmts: Sequence[str] = (),
>          # similar to
>          #   _supported_fmt generic
>          # for bash tests
> +        if imgfmt == 'luks':
> +            verify_working_luks()
>          return
>  
>      not_sup = supported_fmts and (imgfmt not in supported_fmts)
>      if not_sup or (imgfmt in unsupported_fmts):
>          notrun('not suitable for this image format: %s' % imgfmt)
>  
> +    if imgfmt == 'luks':
> +        verify_working_luks()
> +
>  def _verify_protocol(supported: Sequence[str] = (),
>                       unsupported: Sequence[str] = ()) -> None:
>      assert not (supported and unsupported)


If I understand correctly all raw luks tests are now under the condition that
luks works, and qcow2 tests are added to this manually for the tests that
use encryption. Seems fair to me.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


PS: I also run the iotests with luks and qcow2, and it works fine.

Note that iotest 051 is broken (regardless of these patches)

051      fail       [14:18:42] [14:18:49]                    output mismatch (see 051.out.bad)
--- /home/mlevitsk/UPSTREAM/qemu/src/tests/qemu-iotests/051.pc.out	2020-06-07 12:50:28.037624714 +0300
+++ /home/mlevitsk/UPSTREAM/qemu/build_luks/tests/qemu-iotests/051.out.bad	2020-06-29 14:18:49.372420624 +0300
@@ -142,7 +142,7 @@
 
 Testing: -drive if=ide
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Device needs media, but drive is empty
+(qemu) QEMU_PROG: Device needs media, but drive is empty
 
 Testing: -drive if=virtio
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -214,7 +214,7 @@
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Block node is read-only
+(qemu) QEMU_PROG: Block node is read-only
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
Failures: 051
Failed 1 of 1 iotests


It seem to use an pc machine type specific 'out' file, thus I might have something wrong in my enviroment.

Best regards,
	Maxim Levitsky


