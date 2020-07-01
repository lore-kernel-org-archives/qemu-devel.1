Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD95C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B441E2053B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhSMP6vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B441E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqVKQ-0000TK-VS
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 01:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqVJf-0008Rn-QR
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:29:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqVJd-0002Ga-5T
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593581387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvNoBdUnEnCe7AbnjHm5GSwijh9ALt/w0c3ehNAI2wU=;
 b=UhSMP6vonbNgYxq4mfJKWAHiQdUfDxr+Xs0A1BxWFNPrvX8cr3VUzRelcdriB91pJsU4WZ
 Eg3D8LMgDallPynDFrUMINdH1HeQKWE2TBAthcda/kPhtnb8PDsjW6azDKZZ3yhBNtAe1d
 z0uxRYXXQp4u4z8ykw+tOeMUEsp4f5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-ZjPv8F5vOb2Aj6HTwouArw-1; Wed, 01 Jul 2020 01:29:39 -0400
X-MC-Unique: ZjPv8F5vOb2Aj6HTwouArw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0974A804001;
 Wed,  1 Jul 2020 05:29:37 +0000 (UTC)
Received: from [10.72.13.177] (ovpn-13-177.pek2.redhat.com [10.72.13.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B8C060BE1;
 Wed,  1 Jul 2020 05:29:19 +0000 (UTC)
Subject: Re: [PATCH v2 00/12] vDPA support in qemu
To: qemu-devel@nongnu.org, lulu@redhat.com
References: <159354041626.15477.8604156689503337818@d1fd068a5071>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <db885de8-9671-b847-f2f4-b67b245f1c9e@redhat.com>
Date: Wed, 1 Jul 2020 13:29:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159354041626.15477.8604156689503337818@d1fd068a5071>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
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
Cc: rdunlap@infradead.org, mst@redhat.com, mhabets@solarflare.com,
 rob.miller@broadcom.com, saugatm@xilinx.com, armbru@redhat.com,
 hch@infradead.org, eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 maxime.coquelin@redhat.com, aadam@redhat.com, cohuck@redhat.com,
 hanand@xilinx.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/1 上午2:06, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200630174937.25560-1-lulu@redhat.com/
>
>
>
> Hi,
>
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
>
> === TEST SCRIPT BEGIN ===
> #! /bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-mingw@fedora J=14 NETWORK=1


Please fix this. You can reproduce this with the above commands.

Thanks


> === TEST SCRIPT END ===
>
> /tmp/qemu-test/src/hw/net/virtio-net.c:173: undefined reference to `vhost_dev_set_config'
> /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: hw/net/virtio-net.o: in function `virtio_net_get_config':
> /tmp/qemu-test/src/hw/net/virtio-net.c:149: undefined reference to `vhost_dev_get_config'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:208: qemu-system-x86_64w.exe] Error 1
> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
> make: *** Waiting for unfinished jobs....
>    LINK    aarch64-softmmu/qemu-system-aarch64w.exe
> /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: hw/net/virtio-net.o: in function `virtio_net_set_config':
> /tmp/qemu-test/src/hw/net/virtio-net.c:173: undefined reference to `vhost_dev_set_config'
> /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: hw/net/virtio-net.o: in function `virtio_net_get_config':
> /tmp/qemu-test/src/hw/net/virtio-net.c:149: undefined reference to `vhost_dev_get_config'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:208: qemu-system-aarch64w.exe] Error 1
> make: *** [Makefile:527: aarch64-softmmu/all] Error 2
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 669, in <module>
>      sys.exit(main())
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=9f5def1ac1a840deb219e8827020f24d', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-lwyumgcs/src/docker-src.2020-06-30-14.01.04.32102:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=9f5def1ac1a840deb219e8827020f24d
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-lwyumgcs/src'
> make: *** [docker-run-test-mingw@fedora] Error 2
>
> real    5m52.723s
> user    0m8.824s
>
>
> The full log is available at
> http://patchew.org/logs/20200630174937.25560-1-lulu@redhat.com/testing.docker-mingw@fedora/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


