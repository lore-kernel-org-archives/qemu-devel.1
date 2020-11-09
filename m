Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C2EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F36206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SACXyrzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F36206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEFR-0003sY-Hz
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 15:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1kcEEp-0003QI-Uk
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:58:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1kcEEn-0002A9-5E
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604955484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRlxAv9C1q/8QZ6Cas6Q0p7S08IKoEpFfb6JpWWtMws=;
 b=SACXyrzIabFCM3ClZHI6kibdps2et4gI3Fk26oTL+MJABJGFlcBMrkdHp2Pk5oxq7Az0Z3
 IM7joKuS5xcf51sWsAvWn5ADeU/oq0sAki3j65PClBXeTf+1BSihV55nUC728JH2TzDshv
 X4zLrTuLMf583JRFmelcK2tBjiEzPlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-86Xm8CKJOC6Xy1XKgzHUMw-1; Mon, 09 Nov 2020 15:58:02 -0500
X-MC-Unique: 86Xm8CKJOC6Xy1XKgzHUMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E0021099F60;
 Mon,  9 Nov 2020 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-220.rdu2.redhat.com
 [10.10.120.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAC4A1001901;
 Mon,  9 Nov 2020 20:57:52 +0000 (UTC)
Subject: Re: [PATCH-for-6.0 v4 05/17] gitlab-ci: Split CONFIGURE_ARGS one
 argument per line for build-disabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201108204535.2319870-1-philmd@redhat.com>
 <20201108204535.2319870-6-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <f429a203-48ab-4e58-8bf6-8ab180fc55a3@redhat.com>
Date: Mon, 9 Nov 2020 18:57:46 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20201108204535.2319870-6-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wainersm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=wainersm@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/8/20 6:45 PM, Philippe Mathieu-Daudé wrote:
> We will keep adding/removing options to our 'configure' script,
> so for easier maintainability it makes sense to have CONFIGURE_ARGS
> declared as one option per line. This way we can review diff easily
> (or rebase/cherry-pick).
>
> No logical change.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Daniel P . Berrange <berrange@redhat.com>
> ---
>   .gitlab-ci.yml | 80 +++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 63 insertions(+), 17 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 3b15ae5c302..9f090cca5e3 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -203,23 +203,69 @@ build-disabled:
>     <<: *native_build_job_definition
>     variables:
>       IMAGE: fedora
> -    CONFIGURE_ARGS: --disable-attr --disable-avx2 --disable-bochs
> -      --disable-brlapi --disable-bzip2 --disable-cap-ng --disable-capstone
> -      --disable-cloop --disable-coroutine-pool --disable-curl --disable-curses
> -      --disable-dmg --disable-docs --disable-glusterfs --disable-gnutls
> -      --disable-gtk --disable-guest-agent --disable-iconv --disable-kvm
> -      --disable-libiscsi --disable-libpmem --disable-libssh --disable-libusb
> -      --disable-libxml2 --disable-linux-aio --disable-live-block-migration
> -      --disable-lzo --disable-malloc-trim --disable-mpath --disable-nettle
> -      --disable-numa --disable-parallels --disable-pie --disable-qcow1
> -      --disable-qed --disable-qom-cast-debug --disable-rbd --disable-rdma
> -      --disable-replication --disable-sdl --disable-seccomp --disable-sheepdog
> -      --disable-slirp --disable-smartcard --disable-snappy --disable-spice
> -      --disable-strip --disable-tpm --disable-usb-redir --disable-vdi
> -      --disable-vhost-crypto --disable-vhost-net --disable-vhost-scsi
> -      --disable-vhost-user --disable-vhost-vdpa --disable-vhost-vsock
> -      --disable-virglrenderer --disable-vnc --disable-vte --disable-vvfat
> -      --disable-xen --disable-zstd
> +    CONFIGURE_ARGS:

I suggest to use '>-' like 'CONFIGURE_ARGS: >-'. It's up to you.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

> +      --disable-attr
> +      --disable-avx2
> +      --disable-bochs
> +      --disable-brlapi
> +      --disable-bzip2
> +      --disable-cap-ng
> +      --disable-capstone
> +      --disable-cloop
> +      --disable-coroutine-pool
> +      --disable-curl
> +      --disable-curses
> +      --disable-dmg
> +      --disable-docs
> +      --disable-glusterfs
> +      --disable-gnutls
> +      --disable-gtk
> +      --disable-guest-agent
> +      --disable-iconv
> +      --disable-kvm
> +      --disable-libiscsi
> +      --disable-libpmem
> +      --disable-libssh
> +      --disable-libusb
> +      --disable-libxml2
> +      --disable-linux-aio
> +      --disable-live-block-migration
> +      --disable-lzo
> +      --disable-malloc-trim
> +      --disable-mpath
> +      --disable-nettle
> +      --disable-numa
> +      --disable-parallels
> +      --disable-pie
> +      --disable-qcow1
> +      --disable-qed
> +      --disable-qom-cast-debug
> +      --disable-rbd
> +      --disable-rdma
> +      --disable-replication
> +      --disable-sdl
> +      --disable-seccomp
> +      --disable-sheepdog
> +      --disable-slirp
> +      --disable-smartcard
> +      --disable-snappy
> +      --disable-spice
> +      --disable-strip
> +      --disable-tpm
> +      --disable-usb-redir
> +      --disable-vdi
> +      --disable-vhost-crypto
> +      --disable-vhost-net
> +      --disable-vhost-scsi
> +      --disable-vhost-user
> +      --disable-vhost-vdpa
> +      --disable-vhost-vsock
> +      --disable-virglrenderer
> +      --disable-vnc
> +      --disable-vte
> +      --disable-vvfat
> +      --disable-xen
> +      --disable-zstd
>       TARGETS: arm-softmmu i386-softmmu ppc64-softmmu mips64-softmmu
>         s390x-softmmu i386-linux-user
>       MAKE_CHECK_ARGS: check-qtest SPEED=slow


