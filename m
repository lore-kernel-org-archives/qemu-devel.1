Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13149C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D194C20833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D194C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsw9-0000Jb-4k
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43195)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hcsWi-0003hH-Iy
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hcsWg-0000WB-Pr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:22:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hcsWc-0000T8-2Q; Mon, 17 Jun 2019 10:22:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 431FA307D962;
 Mon, 17 Jun 2019 14:22:16 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4035B5F59C;
 Mon, 17 Jun 2019 14:22:00 +0000 (UTC)
Message-ID: <ec4586f21117b8e45f5fe7dde9b7a73334cbdcee.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 17:21:59 +0300
In-Reply-To: <20190610134905.22294-13-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-13-mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 17 Jun 2019 14:22:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 12/12] qemu-iotests/087: checks for
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-06-10 at 19:19 +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  tests/qemu-iotests/087     | 26 ++++++++++++++++++++++++++
>  tests/qemu-iotests/087.out | 10 ++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> index d6c8613419..0cc7283ad8 100755
> --- a/tests/qemu-iotests/087
> +++ b/tests/qemu-iotests/087
> @@ -124,6 +124,32 @@ run_qemu_filter_aio <<EOF
>  { "execute": "quit" }
>  EOF
>  
> +echo
> +echo === aio=io_uring without O_DIRECT ===
> +echo
> +
> +# Skip this test if io_uring is not enabled in this build
> +run_qemu_filter_io_uring()
> +{
> +    run_qemu "$@"
> +}
> +
> +run_qemu_filter_io_uring <<EOF
> +{ "execute": "qmp_capabilities" }
> +{ "execute": "blockdev-add",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "node-name": "disk",
> +      "file": {
> +          "driver": "file",
> +          "filename": "$TEST_IMG",
> +          "aio": "io_uring"
> +      }
> +    }
> +  }
> +{ "execute": "quit" }
> +EOF
> +
>  echo
>  echo === Encrypted image QCow ===
>  echo
> diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
> index 2d92ea847b..f0557d425f 100644
> --- a/tests/qemu-iotests/087.out
> +++ b/tests/qemu-iotests/087.out
> @@ -32,6 +32,16 @@ QMP_VERSION
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
>  
>  
> +=== aio=io_uring without O_DIRECT ===
> +
> +Testing:
> +QMP_VERSION
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
> +
> +

This is kind of wrong copy&paste happened here: 

The "aio=native without O_DIRECT" test is a negative test trying to enable libaio support without O_DIRECT,
which qemu check and fails on.

The io_uring can be enabled without O_DIRECT, thus negative test doesn't make sense, but rather a positive test which not only enables
this but actually does some IO in this mode to see that it works is needed IMHO.



>  === Encrypted image QCow ===
>  
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0


Best regards,
	Maxim Levitsky


